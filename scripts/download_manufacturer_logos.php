<?php
declare(strict_types=1);

require __DIR__ . '/../includes/db.php';

$logoDir = __DIR__ . '/../assets/manufacturer_logos';
if (!is_dir($logoDir)) { mkdir($logoDir, 0775, true); }

function logMsg(string $msg): void { echo '[' . date('H:i:s') . '] ' . $msg . PHP_EOL; }

function apiGet(string $url): ?array {
    $ctx = stream_context_create(['http' => ['timeout' => 10, 'user_agent' => 'AnganiData/1.0 (angani.co.uk)']]);
    $data = @file_get_contents($url, false, $ctx);
    if ($data === false) return null;
    $decoded = json_decode($data, true);
    return is_array($decoded) ? $decoded : null;
}

function getDirectUrl(string $title): ?string {
    $infoUrl = 'https://commons.wikimedia.org/w/api.php?action=query&titles=' . urlencode($title) . '&prop=imageinfo&iiprop=url&format=json';
    $info = apiGet($infoUrl);
    if (!$info) return null;
    foreach ($info['query']['pages'] ?? [] as $page) {
        if (isset($page['imageinfo'][0]['url'])) return $page['imageinfo'][0]['url'];
    }
    return null;
}

$rows = rows("SELECT id, name FROM aircraft_manufacturers WHERE (logo_url IS NULL OR logo_url='') ORDER BY name");
logMsg('Manufacturers without logos: ' . count($rows));

$downloaded = 0;
$failed = [];
$alreadyHave = 0;

foreach ($rows as $row) {
    $id = $row['id'];
    $name = $row['name'];
    $safeName = preg_replace('/[^a-zA-Z0-9_-]/', '_', $name);

    // Check if a file already exists for this manufacturer (from previous manual uploads)
    foreach (glob($logoDir . '/' . $safeName . '.*') as $existingFile) {
        $ext = pathinfo($existingFile, PATHINFO_EXTENSION);
        $logoFilename = $safeName . '.' . $ext;
        logMsg("  $name: Found existing file $logoFilename, updating DB");
        db()->prepare('UPDATE aircraft_manufacturers SET logo_url=? WHERE id=?')->execute([$logoFilename, $id]);
        $alreadyHave++;
        continue 2;
    }

    // Check for known aliases
    $namesToTry = [$name, str_replace(' ', '_', $name)];
    // Also try just the first word for compound names
    $firstWord = explode(' ', $name)[0];
    if ($firstWord !== $name) $namesToTry[] = $firstWord;

    $foundUrl = null;

    foreach ($namesToTry as $searchName) {
        // Search Commons for logo-type files
        $safeSearch = str_replace(' ', '_', $searchName);
        $apiUrl = "https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch=File:{$safeSearch}+logo&srnamespace=6&srlimit=10&format=json";
        $apiResult = apiGet($apiUrl);

        if (!$apiResult || !isset($apiResult['query']['search'])) continue;

        foreach ($apiResult['query']['search'] as $result) {
            $title = $result['title']; // "File:XXX.svg"
            $titleClean = str_replace(['File:', '_'], ['', ' '], $title);

            // Score the match: prefer logos, exact name matches, SVG files
            $nameWords = explode(' ', $name);
            $matchScore = 0;
            foreach ($nameWords as $w) {
                if (stripos($titleClean, $w) !== false) $matchScore += 10;
            }
            if (stripos($title, 'logo') !== false) $matchScore += 5;
            if (stripos($title, '.svg') !== false) $matchScore += 3;
            if (stripos($title, '.png') !== false) $matchScore += 2;
            // Penalty for unrelated keywords
            if (preg_match('/\b(airline|airport|airways|air_canada|eurowings|emirates)\b/i', $title)) $matchScore -= 20;
            // Bonus for exact title match with manufacturer name
            if (stripos($titleClean, $name) !== false) $matchScore += 15;

            if ($matchScore >= 15) {
                $url = getDirectUrl($title);
                if ($url) {
                    $foundUrl = $url;
                    logMsg("  $name: Found via search ($title, score=$matchScore)");
                    break 2;
                }
            }
        }

        // Second pass: try broader search (just the name, no "logo" qualifier)
        $apiUrl2 = "https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch={$safeSearch}+svg+file&srnamespace=6&srlimit=10&format=json";
        $apiResult2 = apiGet($apiUrl2);
        if ($apiResult2 && isset($apiResult2['query']['search'])) {
            foreach ($apiResult2['query']['search'] as $result) {
                $title = $result['title'];
                $titleClean = str_replace(['File:', '_'], ['', ' '], $title);
                $nameWords = explode(' ', $name);
                $matchScore = 0;
                foreach ($nameWords as $w) {
                    if (stripos($titleClean, $w) !== false) $matchScore += 10;
                }
                if (stripos($title, '.svg') !== false) $matchScore += 5;
                if (stripos($title, 'logo') !== false) $matchScore += 3;
                if (preg_match('/\b(airline|airport|airways|air_canada|eurowings|emirates)\b/i', $title)) $matchScore -= 20;

                if ($matchScore >= 10) {
                    $url = getDirectUrl($title);
                    if ($url) {
                        $foundUrl = $url;
                        logMsg("  $name: Found via broad search ($title, score=$matchScore)");
                        break 2;
                    }
                }
            }
        }
    }

    if (!$foundUrl) {
        $failed[] = $name;
        logMsg("  $name: Not found on Commons");
        continue;
    }

    $ext = strtolower(pathinfo(parse_url($foundUrl, PHP_URL_PATH), PATHINFO_EXTENSION)) ?: 'svg';
    $logoFilename = $safeName . '.' . $ext;

    if (file_exists($logoDir . '/' . $logoFilename)) {
        logMsg("  $name: File exists, updating DB");
        db()->prepare('UPDATE aircraft_manufacturers SET logo_url=? WHERE id=?')->execute([$logoFilename, $id]);
        $downloaded++;
        continue;
    }

    logMsg("  Downloading $name from $foundUrl");
    $ctx = stream_context_create(['http' => ['timeout' => 30, 'user_agent' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36']]);
    $data = @file_get_contents($foundUrl, false, $ctx);

    if ($data === false) {
        $failed[] = $name;
        logMsg("    Download failed");
        continue;
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mime = finfo_buffer($finfo, $data);
    finfo_close($finfo);

    if (!str_starts_with($mime, 'image/')) {
        logMsg("    Not an image (mime: $mime)");
        $failed[] = "$name (bad mime)";
        continue;
    }

    $extMap = ['image/svg+xml' => 'svg', 'image/png' => 'png', 'image/jpeg' => 'jpg', 'image/gif' => 'gif', 'image/webp' => 'webp'];
    $correctExt = $extMap[$mime] ?? $ext;
    if ($correctExt !== $ext) $logoFilename = $safeName . '.' . $correctExt;

    file_put_contents($logoDir . '/' . $logoFilename, $data);
    logMsg("    Saved $logoFilename (" . strlen($data) . ' bytes, ' . $mime . ')');

    db()->prepare('UPDATE aircraft_manufacturers SET logo_url=? WHERE id=?')->execute([$logoFilename, $id]);
    $downloaded++;
}

logMsg("Downloaded: $downloaded, Already had: $alreadyHave, Failed: " . count($failed));
if ($failed) {
    logMsg('Failed:');
    foreach (array_slice($failed, 0, 50) as $f) logMsg("  - $f");
}
