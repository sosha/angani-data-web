<?php
/**
 * AnganiData — Global Meta Ads Sync
 * Iterates through all countries and fetches Meta Ads dataset for airlines.
 */
require_once 'db.php';
// Disable memory and time limits for global sync
ini_set('memory_limit', '-1');
set_time_limit(0);

define('DATA_ROOT', realpath(__DIR__ . '/../angani-data/datasets'));

$pdo = AnganiDB::getInstance();
$stmt = $pdo->prepare("SELECT setting_value FROM settings WHERE setting_key = 'meta_access_token'");
$stmt->execute();
$meta_access_token = $stmt->fetchColumn();

if (!$meta_access_token) {
    die("<h1>Access Token Missing</h1><p>Please configure your Meta Access Token in Administration.</p>");
}

// Ensure output buffering is off so we can stream progress
while (ob_get_level()) { ob_end_flush(); }
ob_implicit_flush(true);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Global Meta Ads Synchronization</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .sync-console {
            background: rgba(15, 23, 42, 0.95);
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            padding: 1.5rem;
            height: 60vh;
            overflow-y: auto;
            font-family: monospace;
            font-size: 0.85rem;
            color: #a5b4fc;
            line-height: 1.5;
        }
        .console-line { margin: 0; padding: 0.2rem 0; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .console-line.success { color: #4ade80; }
        .console-line.error { color: #f87171; }
        .console-line.warning { color: #facc15; }
        .console-line.header { font-weight: bold; color: #818cf8; margin-top: 1rem; }
    </style>
</head>
<body>
    <div class="container">
        <?php include 'header.php'; ?>
        <main>
            <h2>🌍 Global Meta Ads Dataset Synchronization</h2>
            <p class="text-muted">Scanning all countries for active airline ads. Please do not close this window.</p>
            
            <div class="sync-console" id="console">
<?php

function out($msg, $type = '') {
    $time = date('H:i:s');
    $safeMsg = htmlspecialchars($msg);
    echo "<div class='console-line $type'>[$time] $safeMsg</div>";
    echo "<script>document.getElementById('console').scrollTop = document.getElementById('console').scrollHeight;</script>";
    flush();
}

// Fetch helper
function fetchMetaAds($searchTerm, $countryCode) {
    global $meta_access_token;
    if(empty($searchTerm)) return [];
    
    $url = "https://graph.facebook.com/v20.0/ads_archive?";
    $params = [
        'access_token' => $meta_access_token,
        'search_terms' => $searchTerm,
        'ad_reached_countries' => '["' . strtoupper($countryCode) . '"]',
        'ad_active_status' => 'ALL',
        'fields' => 'id,ad_creation_time,ad_creative_bodies,page_name,page_id,ad_snapshot_url',
        'limit' => 3
    ];
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url . http_build_query($params));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if($httpCode !== 200) {
        return [];
    }
    
    $data = json_decode($response, true);
    return $data['data'] ?? [];
}

function processCountry($countryCode) {
    $category = 'airlines';
    $sourceFile = DATA_ROOT . "/Countries/$countryCode/$category/$category.csv";
    
    if(!file_exists($sourceFile)) {
        out("Dataset missing for $countryCode ($category), skipping.", 'warning');
        return;
    }
    
    out("Reading airlines for $countryCode...", 'header');
    
    $handle = fopen($sourceFile, 'r');
    $headers = fgetcsv($handle);
    $nameIdx = -1;
    $idIdx = -1;
    
    foreach($headers as $i => $h) {
        $h_lower = strtolower(trim($h, "\xEF\xBB\xBF "));
        if(in_array($h_lower, ['airline', 'name'])) $nameIdx = $i;
        if(in_array($h_lower, ['iata', 'ident', 'icao', 'id'])) $idIdx = $i;
    }
    if($nameIdx === -1) $nameIdx = 2; 
    if($idIdx === -1) $idIdx = 0;
    
    $entities = [];
    while(($row = fgetcsv($handle)) !== false) {
        if(count($row) > $nameIdx && trim($row[$nameIdx]) !== '') {
            $entities[] = ['id' => $row[$idIdx], 'name' => trim($row[$nameIdx])];
        }
    }
    fclose($handle);
    
    out("Found " . count($entities) . " airlines to query.");
    
    $csvRecords = [];
    foreach($entities as $entity) {
        // Respect API rate limits (1 second per entity requested)
        usleep(500000); 
        $ads = fetchMetaAds($entity['name'], $countryCode);
        if(count($ads) > 0) {
            out("- {$entity['name']}: Found " . count($ads) . " ads", 'success');
            foreach($ads as $ad) {
                $csvRecords[] = [
                    $entity['id'],
                    $ad['id'] ?? '',
                    $ad['ad_creation_time'] ?? '',
                    isset($ad['ad_creative_bodies']) ? implode("\n", $ad['ad_creative_bodies']) : '',
                    $ad['ad_snapshot_url'] ?? '',
                    $ad['page_name'] ?? '',
                    $ad['page_id'] ?? '',
                    'ACTIVE',
                    date('Y-m-d H:i:s')
                ];
            }
        }
    }
    
    if(count($csvRecords) > 0) {
        $targetFile = DATA_ROOT . "/Countries/$countryCode/$category/meta_ads.csv";
        if(!is_dir(dirname($targetFile))) {
            mkdir(dirname($targetFile), 0777, true);
        }
        
        $isNew = !file_exists($targetFile);
        $wHandle = fopen($targetFile, 'a');
        if($isNew) fputcsv($wHandle, ['Parent ID', 'Ad ID', 'Creation Time', 'Ad Text', 'Snapshot URL', 'Page Name', 'Page ID', 'Status', 'Last Updated']);
        
        foreach($csvRecords as $rec) {
            fputcsv($wHandle, $rec);
        }
        fclose($wHandle);
        out("=> Saved " . count($csvRecords) . " ad records to meta_ads.csv", 'success');
    } else {
        out("=> No ads found for airlines in $countryCode");
    }
}

// ----- Start Main Loop -----
out("Starting global synchronization...", 'header');

$countriesDir = DATA_ROOT . '/Countries';
$dp = opendir($countriesDir);
$countries = [];
while(($entry = readdir($dp)) !== false) {
    if($entry !== '.' && $entry !== '..' && is_dir("$countriesDir/$entry")) {
        $countries[] = $entry;
    }
}
closedir($dp);
sort($countries);

foreach($countries as $cc) {
    processCountry($cc);
}

out("✅ Global Synchronization Complete!", 'success');

?>
            </div>
            
            <a href="meta_ads.php" class="btn" style="margin-top: 1.5rem;">Return to Ads Library</a>
        </main>
    </div>
</body>
</html>
