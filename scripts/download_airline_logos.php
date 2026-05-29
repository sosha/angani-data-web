<?php
/**
 * Downloads all airline logos from external URLs to local assets/airline_logos/
 * and updates the database to reflect the new local paths.
 *
 * Usage: php scripts/download_airline_logos.php
 * Environment: ANGANI_DB_PASS must be set (for CLI PHP)
 */

$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) {
    fwrite(STDERR, "ERROR: ANGANI_DB_PASS environment variable not set.\n");
    exit(1);
}

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$logosDir = __DIR__ . '/../assets/airline_logos';
if (!is_dir($logosDir)) {
    mkdir($logosDir, 0755, true);
    echo "Created directory: $logosDir\n";
}

$rows = $db->query("SELECT icao_code, logo_url FROM airlines WHERE logo_url IS NOT NULL AND logo_url != '' ORDER BY icao_code")->fetchAll();

$total = count($rows);
$downloaded = 0;
$skipped = 0;
$failed = 0;

echo "Found $total airlines with logos.\n";

foreach ($rows as $row) {
    $icao = $row['icao_code'];
    $url = $row['logo_url'];
    $destPath = $logosDir . '/' . $icao . '.png';

    if (file_exists($destPath) && filesize($destPath) > 100) {
        $skipped++;
        continue;
    }

    // If the URL is already local, skip
    if (!preg_match('~^https?://~i', $url)) {
        $skipped++;
        continue;
    }

    echo "[$icao] Downloading... ";
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 15,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_USERAGENT => 'AnganiData/1.0',
        CURLOPT_SSL_VERIFYPEER => false,
    ]);
    $data = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $contentType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
    curl_close($ch);

    if ($httpCode !== 200 || !$data || strlen($data) < 100) {
        echo "FAILED (HTTP $httpCode, " . strlen($data ?? '') . " bytes)\n";
        $failed++;
        continue;
    }

    file_put_contents($destPath, $data);
    $downloaded++;
    echo "OK (" . strlen($data) . " bytes, $contentType)\n";

    // Update database to local path
    $localPath = 'assets/airline_logos/' . $icao . '.png';
    $stmt = $db->prepare("UPDATE airlines SET logo_url = ? WHERE icao_code = ?");
    $stmt->execute([$localPath, $icao]);
}

echo "\n--- Summary ---\n";
echo "Total: $total\n";
echo "Downloaded: $downloaded\n";
echo "Skipped (already local): $skipped\n";
echo "Failed: $failed\n";
echo "Logos directory: $logosDir\n";
