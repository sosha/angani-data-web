<?php
/**
 * AnganiData — Meta Ads API Proxy & Dataset Manager
 * Handles integration with Facebook Ads Library and writing to meta_ads.csv
 */
header('Content-Type: application/json; charset=utf-8');
require_once 'db.php';

// Disable memory limit and time limit for big dataset ops
ini_set('memory_limit', '-1');
set_time_limit(0);
ini_set('display_errors', '0'); // Prevent PHP warnings from breaking JSON

define('DATA_ROOT', realpath(__DIR__ . '/../angani-data/datasets'));

// Get Access Token
$pdo = AnganiDB::getInstance();
$stmt = $pdo->prepare("SELECT setting_value FROM settings WHERE setting_key = 'meta_access_token'");
$stmt->execute();
$meta_access_token = $stmt->fetchColumn();

if (!$meta_access_token) {
    echo json_encode(['error' => 'Meta Access Token not found in settings.']);
    exit;
}

$action = $_GET['action'] ?? '';

switch ($action) {
    case 'sync_target': actionSyncTarget(); break;
    case 'get_entities': actionGetEntities(); break;
    default: echo json_encode(['error' => 'Invalid action']);
}

function jsonOut($data, $code=200) {
    http_response_code($code);
    echo json_encode($data);
    exit;
}

function fetchMetaAds($searchTerm, $countryCode) {
    global $meta_access_token;
    
    // We must pass country code in array format like '["AE"]'
    // Search terms cannot be empty
    if(empty($searchTerm)) return [];
    
    $url = "https://graph.facebook.com/v20.0/ads_archive?";
    $params = [
        'access_token' => $meta_access_token,
        'search_terms' => $searchTerm,
        'ad_reached_countries' => '["' . strtoupper($countryCode) . '"]',
        'ad_active_status' => 'ALL',  // or ACTIVE
        'fields' => 'id,ad_creation_time,ad_creative_bodies,page_name,page_id,ad_snapshot_url',
        'limit' => 5 // Keep limit low per entity to avoid rate limits
    ];
    
    $query = http_build_query($params);
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url . $query);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 15);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if($httpCode !== 200) {
        // Return a structured error so it can be handled if needed, or just log safely
        $errorMsg = "API Error (HTTP $httpCode)";
        $resObj = json_decode($response, true);
        if (isset($resObj['error']['message'])) {
            $errorMsg = $resObj['error']['message'];
        }
        throw new Exception($errorMsg);
    }
    
    $data = json_decode($response, true);
    return $data['data'] ?? [];
}

function safeCSVPath($relative) {
    $relative = str_replace('\\', '/', trim($relative, '/'));
    if (strpos($relative, '..') !== false) return null;
    $full = realpath(DATA_ROOT . '/' . dirname($relative));
    if (!$full) return null;
    return $full . '/' . basename($relative);
}

function writeMetaAdsCSV($filePath, $recordsList) {
    $exists = file_exists($filePath);
    $handle = fopen($filePath, 'a');
    if(!$handle) return count($recordsList); // fallback error assumption

    // Write header if new file
    if(!$exists) {
        fputcsv($handle, ['Parent ID', 'Ad ID', 'Creation Time', 'Ad Text', 'Snapshot URL', 'Page Name', 'Page ID', 'Status', 'Last Updated']);
    }

    $now = date('Y-m-d H:i:s');
    
    foreach($recordsList as $rec) {
        fputcsv($handle, [
            $rec['parent_id'],
            $rec['ad_id'],
            $rec['ad_creation_time'],
            $rec['ad_text'],
            $rec['snapshot_url'],
            $rec['page_name'],
            $rec['page_id'],
            $rec['status'],
            $now
        ]);
    }
    fclose($handle);
}

function getDatasetEntities($country, $category) {
    $sourceFile = DATA_ROOT . "/Countries/$country/$category/$category.csv";
    
    if(!file_exists($sourceFile)) {
         return null;
    }
    
    $handle = fopen($sourceFile, 'r');
    $headers = fgetcsv($handle);
    
    $nameIdx = -1;
    $idIdx = -1;
    
    foreach($headers as $i => $h) {
        $h = trim($h, "\xEF\xBB\xBF \t\n\r\0\x0B"); // strip BOM
        $h_lower = strtolower($h);
        if(in_array($h_lower, ['airline', 'name', 'airport', 'ident'])) $nameIdx = $i;
        if(in_array($h_lower, ['iata', 'ident', 'icao', 'id'])) $idIdx = $i;
    }
    
    if($nameIdx === -1) $nameIdx = 2; // Assuming standard schema
    if($idIdx === -1) $idIdx = 0;   // Assuming IATA/Ident is first
    
    $entities = [];
    while(($row = fgetcsv($handle)) !== false) {
        if(count($row) > $nameIdx && trim($row[$nameIdx]) !== '') {
            $entities[] = [
                'id' => $row[$idIdx],
                'name' => trim($row[$nameIdx])
            ];
        }
    }
    fclose($handle);
    return $entities;
}

function actionGetEntities() {
    $country = $_GET['country'] ?? '';
    $category = $_GET['category'] ?? ''; // airlines, airports, regulatory
    
    if(!$country || !$category) {
         jsonOut(['error' => 'Missing country or category'], 400);
    }
    
    $entities = getDatasetEntities($country, $category);
    if($entities === null) {
        jsonOut(['error' => "Source dataset not found"], 404);
    }
    
    jsonOut(['entities' => $entities]);
}

function actionSyncTarget() {
    $country = $_GET['country'] ?? '';
    $category = $_GET['category'] ?? ''; // airlines, airports, regulatory
    $targetName = $_GET['entity_name'] ?? ''; // specifically target one
    $targetId = $_GET['entity_id'] ?? '';
    
    if(!$country || !$category) {
         jsonOut(['error' => 'Missing country or category'], 400);
    }
    
    $entities = [];
    if (!empty($targetName)) {
        // Just sync this one
        $entities[] = ['id' => $targetId, 'name' => $targetName];
    } else {
        // Sync all for country
        $entities = getDatasetEntities($country, $category);
        if($entities === null) {
            jsonOut(['error' => "Source dataset not found"], 404);
        }
    }
    
    // Result arrays to push to Frontend and CSV
    $allAdsFetched = [];
    $csvRecords = [];
    $apiErrors = [];
    
    foreach($entities as $entity) {
        // Query Meta API
        try {
            $ads = fetchMetaAds($entity['name'], $country);
            
            foreach($ads as $ad) {
                $adText = '';
                if(isset($ad['ad_creative_bodies']) && is_array($ad['ad_creative_bodies'])) {
                    $adText = implode("\n", $ad['ad_creative_bodies']);
                }
                
                $formattedAd = [
                    'parent_id' => $entity['id'],
                    'ad_id' => $ad['id'] ?? '',
                    'ad_creation_time' => $ad['ad_creation_time'] ?? '',
                    'ad_text' => $adText,
                    'snapshot_url' => $ad['ad_snapshot_url'] ?? '',
                    'page_name' => $ad['page_name'] ?? '',
                    'page_id' => $ad['page_id'] ?? '',
                    'status' => 'ACTIVE'
                ];
                
                $allAdsFetched[] = $formattedAd;
                $csvRecords[] = $formattedAd;
            }
        } catch (Exception $e) {
            $apiErrors[] = "{$entity['name']}: " . $e->getMessage();
        }
    }
    
    // If we only have errors and nothing fetched, maybe return an error to show the user
    if(count($apiErrors) > 0 && count($csvRecords) === 0) {
        jsonOut(['error' => "Meta API Errors encountered: " . implode(" | ", $apiErrors)], 200);
    }
    
    // Save to meta_ads.csv
    $targetFile = DATA_ROOT . "/Countries/$country/$category/meta_ads.csv";
    // For safety ensure directory exists
    if(!is_dir(dirname($targetFile))) {
        mkdir(dirname($targetFile), 0777, true);
    }
    
    if(count($csvRecords) > 0) {
        // Here we could implement deduping against existing csv, but for now we append.
        writeMetaAdsCSV($targetFile, $csvRecords);
    }
    
    jsonOut([
        'success' => true,
        'country' => $country,
        'category' => $category,
        'entities_scanned' => count($entities),
        'saved_records' => count($csvRecords),
        'ads' => $allAdsFetched
    ]);
}
