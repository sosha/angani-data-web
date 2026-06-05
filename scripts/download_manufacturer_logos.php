<?php
/**
 * Download manufacturer logos from Wikimedia Commons using the Commons API.
 * Attempts to resolve CSV filenames to actual Commons file pages.
 * Usage: php scripts/download_manufacturer_logos.php
 */

declare(strict_types=1);

require __DIR__ . '/../includes/db.php';

$logoDir = __DIR__ . '/../assets/manufacturer_logos';
if (!is_dir($logoDir)) { mkdir($logoDir, 0775, true); }

function logMsg(string $msg): void { echo '[' . date('H:i:s') . '] ' . $msg . PHP_EOL; }
function api(string $url): ?array {
    $ctx = stream_context_create(['http' => ['timeout' => 10, 'user_agent' => 'AnganiData/1.0 (angani.co.uk)']]);
    $data = @file_get_contents($url, false, $ctx);
    if ($data === false) return null;
    $decoded = json_decode($data, true);
    return is_array($decoded) ? $decoded : null;
}

// Get manufacturers from DB that have no local logo yet
$rows = rows("SELECT id, name, logo_url FROM aircraft_manufacturers WHERE (logo_url IS NULL OR logo_url='') ORDER BY name");
logMsg('Manufacturers without logos: ' . count($rows));

$csvPath = __DIR__ . '/../data/ultimate_aircraft_manufacturers.csv';
$csvUrlMap = [];
if (file_exists($csvPath)) {
    $fh = fopen($csvPath, 'r');
    $headers = fgetcsv($fh);
    $logoCol = array_search('Logo', $headers);
    $nameCol = array_search('Name', $headers);
    while ($row = fgetcsv($fh)) {
        $name = trim($row[$nameCol] ?? '');
        $logo = trim($row[$logoCol] ?? '');
        if ($name && $logo && preg_match('#https?://#', $logo)) {
            $csvUrlMap[$name] = $logo;
        }
    }
    fclose($fh);
}
logMsg('CSV logo URLs loaded: ' . count($csvUrlMap));

$downloaded = 0;
$notFound = [];

foreach ($rows as $row) {
    $name = $row['name'];
    $csvUrl = $csvUrlMap[$name] ?? '';

    if (!$csvUrl) {
        $notFound[] = "$name: no CSV URL";
        continue;
    }

    // Extract filename from URL
    // URL format: https://upload.wikimedia.org/wikipedia/commons/thumb/{hash}/{filename}/{size}px-{filename}.png
    if (!preg_match('#/thumb/(?:[^/]+/){2}([^/]+)/(?:\d+px-)?\1\.\w+$#', $csvUrl, $m)) {
        // Try alternate URL format without thumb
        if (!preg_match('#/commons/(?:[^/]+/){2}([^/]+)$#', $csvUrl, $mAlt)) {
            // Just extract the last path segment and decode
            $parts = explode('/', $csvUrl);
            $rawFile = urldecode(end($parts));
            // Remove size prefix like "200px-"
            $rawFile = preg_replace('/^\d+px-/', '', $rawFile);
            $filename = $rawFile;
        } else {
            $filename = urldecode($mAlt[1]);
        }
    } else {
        $filename = urldecode($m[1]);
    }

    // If filename still has the size prefix
    $filename = preg_replace('/^\d+px-/', '', $filename);
    // Decode URL encoding
    $filename = urldecode($filename);
    // Get just the base name (remove .png if it was a .svg.png thumbnail name)
    if (str_ends_with($filename, '.svg.png')) {
        $baseName = substr($filename, 0, -4); // remove .png -> .svg
    } else {
        $baseName = $filename;
    }

    // Search Commons API
    $safeBasename = str_replace(' ', '_', $baseName);
    $apiUrl = "https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch=File:{$safeBasename}&srnamespace=6&srlimit=5&format=json";
    $apiResult = api($apiUrl);

    $foundUrl = null;
    $bestTitle = null;

    if ($apiResult && isset($apiResult['query']['search'])) {
        foreach ($apiResult['query']['search'] as $result) {
            $title = $result['title']; // e.g. "File:Airbus_Logo.svg"
            $score = $result['score'] ?? 0;

            // Check if it's a good match
            $titleClean = str_replace(['File:', '_'], ['', ' '], $title);
            $nameClean = str_replace('_', ' ', $name);
            if (stripos($titleClean, $nameClean) !== false || stripos($nameClean, $titleClean) !== false) {
                // Get the direct URL
                $infoUrl = "https://commons.wikimedia.org/w/api.php?action=query&titles=" . urlencode($title) . "&prop=imageinfo&iiprop=url&format=json";
                $infoResult = api($infoUrl);
                if ($infoResult) {
                    foreach ($infoResult['query']['pages'] as $page) {
                        if (isset($page['imageinfo'][0]['url'])) {
                            $foundUrl = $page['imageinfo'][0]['url'];
                            $bestTitle = $title;
                            break 2;
                        }
                    }
                }
            }
        }
    }

    if (!$foundUrl && !str_contains($baseName, '.')) {
        logMsg("  $name: No match found via search");
        $notFound[] = "$name (search failed)";
        continue;
    }

    $logUrl = $foundUrl ?? $csvUrl;
    $ext = 'svg';
    $urlParts = parse_url($logUrl);
    $pathParts = pathinfo($urlParts['path'] ?? '');
    if (!empty($pathParts['extension'])) $ext = $pathParts['extension'];

    $safeName = preg_replace('/[^a-zA-Z0-9_-]/', '_', $name);
    $logoFilename = $safeName . '.' . $ext;

    if (file_exists($logoDir . '/' . $logoFilename)) {
        logMsg("  $name: File exists, skipping download");
        // Still update DB
        $db = db();
        $db->prepare('UPDATE aircraft_manufacturers SET logo_url=? WHERE id=?')->execute([$logoFilename, $row['id']]);
        $downloaded++;
        continue;
    }

    logMsg("  Downloading $name from $logUrl");
    $ctx = stream_context_create(['http' => ['timeout' => 20, 'user_agent' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36']]);
    $data = @file_get_contents($logUrl, false, $ctx);

    if ($data === false) {
        // Try with the original CSV URL as fallback
        $notFound[] = "$name (download failed)";
        logMsg("    Download failed");
        continue;
    }

    // Check if it's an image
    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mime = finfo_buffer($finfo, $data);
    finfo_close($finfo);

    if (!str_starts_with($mime, 'image/')) {
        logMsg("    Not an image (mime: $mime), content preview: " . substr($data, 0, 100));
        $notFound[] = "$name (bad mime: $mime)";
        continue;
    }

    // Determine correct extension
    $extMap = ['image/svg+xml' => 'svg', 'image/png' => 'png', 'image/jpeg' => 'jpg', 'image/gif' => 'gif', 'image/webp' => 'webp'];
    $correctExt = $extMap[$mime] ?? $ext;
    if ($correctExt !== $ext) {
        $logoFilename = $safeName . '.' . $correctExt;
    }

    file_put_contents($logoDir . '/' . $logoFilename, $data);
    logMsg("    Saved $logoFilename (" . strlen($data) . ' bytes, ' . $mime . ')');

    // Update DB
    $db = db();
    $db->prepare('UPDATE aircraft_manufacturers SET logo_url=? WHERE id=?')->execute([$logoFilename, $row['id']]);
    $downloaded++;
}

logMsg("Downloaded: $downloaded, Failed: " . count($notFound));
if ($notFound) {
    logMsg('Not found/failed:');
    foreach (array_slice($notFound, 0, 30) as $nf) logMsg("  - $nf");
}
