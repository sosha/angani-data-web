<?php
declare(strict_types=1);

/**
 * Merge airlines DB data into country CSV files.
 * 
 * Usage:
 *   php scripts/merge_country_csvs.php <csv_dir>
 * 
 * For each country CSV in csv_dir:
 *   1. Reads existing rows (planespotters data)
 *   2. Matches with DB airlines by source_url
 *   3. Appends new DB airlines not in the CSV
 *   4. Writes back with extended columns
 */

$csvDir = $argv[1] ?? null;
if (!$csvDir || !is_dir($csvDir)) {
    echo "Usage: php merge_country_csvs.php <path_to_airlines_by_country_dir>\n";
    exit(1);
}

require_once __DIR__ . '/../includes/db.php';

// --- Step 1: Load all DB airlines ---
echo "Loading DB airlines...\n";
$dbAirlines = rows("SELECT id, name, country_code, iata_code, icao_code, callsign, 
    fleet_size, status_bucket, status, source_url, founded, hubs, alliance, 
    parent_company, legal_name, trading_name, data_source, prefix, destinations_count,
    logo_url, wikipedia_url, website_url
    FROM airlines ORDER BY country_code, name");

$byCountry = [];
foreach ($dbAirlines as $a) {
    $cc = $a['country_code'] ?? '';
    if ($cc === '') continue;
    $byCountry[$cc][] = $a;
}
echo "Loaded " . count($dbAirlines) . " airlines across " . count($byCountry) . " countries\n";

// --- Step 2: Load country name → code mapping ---
echo "Building country mapping...\n";
$countryToCode = [];

// Try legacy_countries (code, name)
if (table_exists('legacy_countries')) {
    $rows = rows("SELECT code, name FROM legacy_countries WHERE code IS NOT NULL");
    foreach ($rows as $r) {
        $code = strtoupper(trim($r['code']));
        if ($r['name']) $countryToCode[strtolower(trim($r['name']))] = $code;
    }
    echo "  Loaded " . count($rows) . " from legacy_countries\n";
}

// Try ref_country_codes
if (table_exists('ref_country_codes')) {
    $rows = rows("SELECT country_name, alpha_2 FROM ref_country_codes WHERE alpha_2 IS NOT NULL");
    foreach ($rows as $r) {
        $code = strtoupper(trim($r['alpha_2']));
        if ($r['country_name']) $countryToCode[strtolower(trim($r['country_name']))] = $code;
    }
    echo "  Loaded " . count($rows) . " from ref_country_codes\n";
}

// Overrides for common filename patterns
$overrides = [
    'usa' => 'US', 'united states' => 'US',
    'uk' => 'GB', 'great britain' => 'GB',
    'uae' => 'AE',
    'türkiye' => 'TR', 'turkiye' => 'TR',
    'trkiye' => 'TR',
    'czechia' => 'CZ', 'czech republic' => 'CZ',
    'côte d\'ivoire' => 'CI', 'cote d\'ivoire' => 'CI',
    'réunion' => 'RE', 'reunion' => 'RE',
    'palestinian territory' => 'PS', 'palestine' => 'PS',
    'bosnia and herzegovina' => 'BA',
    'timor-leste' => 'TL',
    'viet nam' => 'VN', 'vietnam' => 'VN',
    'venezuela (bolivarian republic of)' => 'VE',
    'korea (republic of)' => 'KR', 'south korea' => 'KR',
    'korea (democratic people\'s republic of)' => 'KP', 'north korea' => 'KP',
    'iran (islamic republic of)' => 'IR',
    'moldova (republic of)' => 'MD',
    'syrian arab republic' => 'SY',
    'tanzania (united republic of)' => 'TZ',
    'lao people\'s democratic republic' => 'LA',
    'russian federation' => 'RU',
    'cote d\'ivoire' => 'CI', 'cote divoire' => 'CI',
    'iran islamic republic of' => 'IR', 'iran (islamic republic of)' => 'IR',
    'korea democratic peoples republic of' => 'KP', 'north korea' => 'KP',
    'korea republic of' => 'KR', 'south korea' => 'KR',
    'lao peoples democratic republic' => 'LA', 'laos' => 'LA',
    'moldova republic of' => 'MD', 'moldova (republic of)' => 'MD',
    'north macedonia' => 'MK',
    'tanzania united republic of' => 'TZ', 'tanzania (united republic of)' => 'TZ',
    'virgin islands british' => 'VG', 'british virgin islands' => 'VG',
    'virgin islands us' => 'VI', 'us virgin islands' => 'VI',
];
foreach ($overrides as $k => $v) {
    $countryToCode[$k] = $v;
}

// --- Step 3: Process each CSV file ---
echo "\nProcessing CSV files...\n";

$files = glob($csvDir . DIRECTORY_SEPARATOR . '*.csv');
// Exclude the combined file
$files = array_filter($files, fn($f) => !str_contains(basename($f), '_All_Airlines_Combined'));

$totalUpdated = 0;
$totalAdded = 0;
$totalFiles = 0;

foreach ($files as $filePath) {
    $filename = basename($filePath);
    $totalFiles++;
    
    // Derive country name from filename
    $countryNameFromFile = str_replace('.csv', '', $filename);
    $countryNameFromFile = str_replace('_', ' ', $countryNameFromFile);
    
    $csvCode = null;
    // Try to get country code from filename
    $key = strtolower($countryNameFromFile);
    if (isset($countryToCode[$key])) {
        $csvCode = $countryToCode[$key];
    } else {
        // Try partial match
        foreach ($countryToCode as $name => $code) {
            if (strpos($key, $name) !== false || strpos($name, $key) !== false) {
                $csvCode = $code;
                break;
            }
        }
    }
    
    if (!$csvCode) {
        echo "  WARNING: Cannot map country code for $filename (name: $countryNameFromFile)\n";
        $csvCode = 'XX';
    }
    
    // Read existing CSV
    $existing = [];
    $header = [];
    if (($fh = fopen($filePath, 'r')) !== false) {
        $header = fgetcsv($fh);
        if ($header) {
            $hdrMap = array_flip($header);
            while (($row = fgetcsv($fh)) !== false) {
                if (count($row) < 6) continue;
                $name = trim($row[4] ?? '');
                $url = trim($row[6] ?? '');
                if ($name === '') continue;
                $existing[$url] = [
                    'csv_name' => $name,
                    'csv_fleet' => $row[5] ?? '',
                    'csv_url' => $url,
                ];
            }
        }
        fclose($fh);
    }
    
    // Get DB airlines for this country
    $dbRows = $byCountry[$csvCode] ?? [];
    
    // Build merged set
    $merged = [];
    $seenUrls = [];
    
    // First pass: existing CSV entries, update with DB data if available
    foreach ($existing as $url => $csvRow) {
        $dbMatch = null;
        // Match by source_url first
        foreach ($dbRows as $dbRow) {
            if ($dbRow['source_url'] === $url) {
                $dbMatch = $dbRow;
                break;
            }
        }
        // Match by name if no URL match
        if (!$dbMatch) {
            foreach ($dbRows as $dbRow) {
                if (strcasecmp($dbRow['name'], $csvRow['csv_name']) === 0) {
                    $dbMatch = $dbRow;
                    break;
                }
            }
        }
        
        $merged[] = buildRow($csvRow['csv_name'], $url, $csvRow['csv_fleet'], $dbMatch, $countryNameFromFile, $csvCode);
        $seenUrls[$url] = true;
        if ($dbMatch) $seenUrls['db_' . $dbMatch['id']] = true;
    }
    
    // Second pass: add DB airlines not in CSV
    foreach ($dbRows as $dbRow) {
        $key = 'db_' . $dbRow['id'];
        if (isset($seenUrls[$key])) continue;
        // Also check by source_url
        $urlKey = $dbRow['source_url'] ?: 'db_' . $dbRow['id'];
        if (isset($seenUrls[$urlKey])) continue;
        // Also check by name
        $nameMatched = false;
        foreach ($existing as $eUrl => $eRow) {
            if (strcasecmp($eRow['csv_name'], $dbRow['name']) === 0) {
                $nameMatched = true;
                break;
            }
        }
        if ($nameMatched) continue;
        
        $merged[] = buildRow($dbRow['name'], $dbRow['source_url'] ?? '', '', $dbRow, $countryNameFromFile, $csvCode);
        $totalAdded++;
    }
    
    // Write CSV
    if (($fh = fopen($filePath, 'w')) === false) {
        echo "  ERROR: Cannot write $filename\n";
        continue;
    }
    
    // Extended header
    $newHeader = [
        'Country', 'Country_Code', 'Total_Airlines', 'Total_Aircraft', 'Avg_Aircraft_Age',
        'Airline_Name', 'IATA_Code', 'ICAO_Code', 'Callsign', 'Fleet_Size',
        'Status_Bucket', 'Status', 'Founded', 'Hubs', 'Alliance', 'Parent_Company',
        'Legal_Name', 'Trading_Name', 'Source_URL', 'Data_Source',
        'Prefix', 'Destinations_Count', 'Logo_URL', 'Wikipedia_URL', 'Website_URL',
    ];
    fputcsv($fh, $newHeader);
    
    // Determine totals from header (roughly keep original, but update count)
    $origTotalAirlines = count($existing);
    $totalAirlines = count($merged);
    
    foreach ($merged as $row) {
        fputcsv($fh, $row);
    }
    
    fclose($fh);
    $totalUpdated += count($existing);
    
    if ($totalFiles % 20 === 0) {
        echo "  Processed $totalFiles files...\n";
    }
}

echo "\n=== DONE ===\n";
echo "Files processed: $totalFiles\n";
echo "Existing rows updated: $totalUpdated\n";
echo "New rows added from DB: $totalAdded\n";

function buildRow(string $name, string $url, string $csvFleet, ?array $db, string $countryName, string $countryCode): array {
    $fleet = $db ? ($db['fleet_size'] ?? null) : ($csvFleet !== '' ? (int)$csvFleet : null);
    $dataSource = $db ? ($db['data_source'] ?? '') : 'planespotters_csv';
    
    return [
        $countryName,
        $countryCode,
        '', // Total_Airlines (filled per-file)
        '', // Total_Aircraft
        '', // Avg_Aircraft_Age
        $db ? $db['name'] : $name,
        $db['iata_code'] ?? '',
        $db['icao_code'] ?? '',
        $db['callsign'] ?? '',
        $fleet !== null ? (string)$fleet : '',
        $db['status_bucket'] ?? 'unknown',
        $db['status'] ?? '',
        $db['founded'] ?? '',
        $db['hubs'] ?? '',
        $db['alliance'] ?? '',
        $db['parent_company'] ?? '',
        $db['legal_name'] ?? '',
        $db['trading_name'] ?? '',
        $url,
        $dataSource,
        $db['prefix'] ?? '',
        $db['destinations_count'] ?? '',
        $db['logo_url'] ?? '',
        $db['wikipedia_url'] ?? '',
        $db['website_url'] ?? '',
    ];
}
