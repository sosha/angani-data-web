<?php
declare(strict_types=1);

require __DIR__ . '/../includes/db.php';

$csvFile = $argv[1] ?? __DIR__ . '/../data/_All_Airlines_Combined.csv';
if (!file_exists($csvFile)) {
    echo "ERROR: CSV file not found: $csvFile\n";
    exit(1);
}

echo "=== AIRLINES CSV INGESTION REPORT ===\n\n";

// --- Step 1: Ensure airlines table exists ---
echo "--- Step 1: Checking/Creating airlines table ---\n";
$tableExists = table_exists('airlines');
if (!$tableExists) {
    echo "Creating airlines table from schema...\n";
    $schema = file_get_contents(__DIR__ . '/../database/01_schema.sql');
    if (preg_match('/CREATE TABLE IF NOT EXISTS airlines\s*\(.+?\) ENGINE=InnoDB[^;]+;/s', $schema, $m)) {
        db()->exec($m[0]);
        echo "  airlines table created.\n";
    } else {
        echo "WARNING: Could not extract airlines CREATE from schema. Creating manually...\n";
        db()->exec("CREATE TABLE IF NOT EXISTS airlines (
          id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
          source_scope VARCHAR(40) DEFAULT NULL,
          country_code VARCHAR(8) DEFAULT NULL,
          region VARCHAR(80) DEFAULT NULL,
          name VARCHAR(255) NOT NULL,
          legal_name VARCHAR(255) DEFAULT NULL,
          trading_name VARCHAR(255) DEFAULT NULL,
          iata_code VARCHAR(16) DEFAULT NULL,
          icao_code VARCHAR(16) DEFAULT NULL,
          prefix VARCHAR(32) DEFAULT NULL,
          callsign VARCHAR(120) DEFAULT NULL,
          fleet_size INT DEFAULT NULL,
          destinations_count INT DEFAULT NULL,
          logo_url TEXT DEFAULT NULL,
          wikipedia_url TEXT DEFAULT NULL,
          website_url TEXT DEFAULT NULL,
          status VARCHAR(80) DEFAULT NULL,
          status_bucket ENUM('active','defunct','unknown') NOT NULL DEFAULT 'unknown',
          source_url TEXT DEFAULT NULL,
          founded VARCHAR(80) DEFAULT NULL,
          hubs TEXT DEFAULT NULL,
          alliance VARCHAR(120) DEFAULT NULL,
          parent_company VARCHAR(190) DEFAULT NULL,
          ownership_type VARCHAR(120) DEFAULT NULL,
          ceo_accountable_manager VARCHAR(255) DEFAULT NULL,
          record_status VARCHAR(80) DEFAULT NULL,
          date_added VARCHAR(32) DEFAULT NULL,
          date_modified VARCHAR(32) DEFAULT NULL,
          data_source VARCHAR(120) DEFAULT NULL,
          last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
          FULLTEXT KEY ft_airlines (name, callsign, iata_code, icao_code, alliance, hubs, parent_company),
          INDEX idx_airlines_status (status_bucket),
          INDEX idx_airlines_country (country_code),
          INDEX idx_airlines_region (region),
          INDEX idx_airlines_icao (icao_code),
          INDEX idx_airlines_iata (iata_code)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
    }
}

// --- Step 2: Populate airlines from backup if empty ---
$count = (int) scalar('SELECT COUNT(*) FROM airlines');
echo "\n--- Step 2: Checking airline data ---\n";
echo "  Airlines table has $count records.\n";
if ($count === 0) {
    echo "  Populating from airlines_backup_20260602...\n";
    $backupCount = (int) scalar('SELECT COUNT(*) FROM airlines_backup_20260602');
    echo "  Backup has $backupCount records.\n";
    if ($backupCount > 0) {
        db()->exec("INSERT INTO airlines (name, iata_code, icao_code, callsign, country_code)
            SELECT name, iata_code, icao_code, callsign, country_code
            FROM airlines_backup_20260602
            WHERE name IS NOT NULL AND name != ''");
        $inserted = (int) scalar('SELECT COUNT(*) FROM airlines');
        echo "  Populated: $inserted records.\n";
    }
}

// --- Step 3: Load country mapping ---
echo "\n--- Step 3: Building country name → code mapping ---\n";
$countryMap = [];

// Try v2 countries table
$hasV2 = table_exists('countries');
if ($hasV2) {
    $rows = rows("SELECT iso_alpha_2, name_common, name_official FROM countries WHERE iso_alpha_2 IS NOT NULL");
    foreach ($rows as $r) {
        $code = strtoupper(trim($r['iso_alpha_2']));
        if ($r['name_common']) $countryMap[strtolower(trim($r['name_common']))] = $code;
        if ($r['name_official']) $countryMap[strtolower(trim($r['name_official']))] = $code;
    }
    echo "  Loaded " . count($rows) . " countries from v2 table.\n";
}

// Try ref_country_codes
$hasRef = table_exists('ref_country_codes');
if ($hasRef) {
    $rows = rows("SELECT country_name, alpha_2 FROM ref_country_codes WHERE alpha_2 IS NOT NULL");
    foreach ($rows as $r) {
        $code = strtoupper(trim($r['alpha_2']));
        if ($r['country_name']) $countryMap[strtolower(trim($r['country_name']))] = $code;
    }
    echo "  Loaded " . count($rows) . " from ref_country_codes.\n";
}

// Hardcoded overrides
$overrides = [
    'usa' => 'US', 'united states' => 'US', 'united states of america' => 'US',
    'uk' => 'GB', 'united kingdom' => 'GB', 'great britain' => 'GB',
    'uae' => 'AE', 'united arab emirates' => 'AE',
    'russia' => 'RU', 'russian federation' => 'RU',
    'vietnam' => 'VN',
    'laos' => 'LA',
    'iran' => 'IR',
    'north korea' => 'KP', 'south korea' => 'KR', 'korea' => 'KR',
    'syria' => 'SY',
    'venezuela' => 'VE',
    'bolivia' => 'BO',
    'czech republic' => 'CZ', 'czechia' => 'CZ',
    'myanmar' => 'MM', 'burma' => 'MM',
    'ivory coast' => 'CI', "côte d'ivoire" => 'CI', "cote d'ivoire" => 'CI',
    'timor-leste' => 'TL', 'east timor' => 'TL',
    'swaziland' => 'SZ', 'eswatini' => 'SZ',
    'cabo verde' => 'CV', 'cape verde' => 'CV',
    'macau' => 'MO', 'macao' => 'MO',
    'falkland islands' => 'FK',
    'cayman islands' => 'KY',
    'bahamas' => 'BS',
    'netherlands' => 'NL',
    'congo' => 'CG', 'congo (kinshasa)' => 'CD', 'congo (brazzaville)' => 'CG',
    'dr congo' => 'CD', 'democratic republic of the congo' => 'CD',
    'south sudan' => 'SS',
    'north macedonia' => 'MK',
    'bosnia' => 'BA', 'bosnia and herzegovina' => 'BA',
    'türkiye' => 'TR', 'turkiye' => 'TR',
    'palestinian territory, occupied' => 'PS', 'palestinian territory' => 'PS', 'palestine' => 'PS',
    'réunion' => 'RE', 'reunion' => 'RE',
];
foreach ($overrides as $k => $v) {
    $countryMap[$k] = $v;
}

echo "  Total mapping entries: " . count($countryMap) . "\n";

// --- Step 4: Read CSV ---
echo "\n--- Step 4: Reading CSV ---\n";
$fh = fopen($csvFile, 'r');
if (!$fh) { echo "ERROR: Cannot open CSV\n"; exit(1); }

$header = fgetcsv($fh);
if (!$header) { echo "ERROR: Empty CSV\n"; exit(1); }

$csvAirlines = [];
$lineNum = 1;
while (($row = fgetcsv($fh)) !== false) {
    $lineNum++;
    if (count($row) < 7) continue;
    $country = trim($row[0]);
    $airlineName = trim($row[4]);
    $fleetSize = trim($row[5]);
    $url = trim($row[6]);
    if ($airlineName === '') continue;
    
    // Extract name from URL as canonical identifier
    $urlName = '';
    if (preg_match('#/airline/([^/]+)$#', $url, $m)) {
        $urlName = str_replace('-', ' ', urldecode($m[1]));
    }
    
    $csvAirlines[] = [
        'country_name' => $country,
        'name' => $airlineName,
        'fleet_size' => $fleetSize !== '' ? (int)$fleetSize : null,
        'source_url' => $url,
        'url_name' => $urlName,
        'country_code' => null,
    ];
}
fclose($fh);
echo "  Read " . count($csvAirlines) . " airlines from CSV.\n";

// --- Step 5: Resolve country codes ---
echo "\n--- Step 5: Resolving country codes ---\n";
$unmappedCountries = [];
foreach ($csvAirlines as &$ca) {
    $key = strtolower($ca['country_name']);
    $code = $countryMap[$key] ?? null;
    if (!$code) {
        // Try partial matching
        foreach ($countryMap as $name => $c) {
            if (strpos($key, $name) !== false || strpos($name, $key) !== false) {
                $code = $c;
                break;
            }
        }
    }
    if ($code) {
        $ca['country_code'] = $code;
    } else {
        $unmappedCountries[$ca['country_name']] = true;
    }
}
unset($ca);
echo "  Resolved " . (count($csvAirlines) - count($unmappedCountries)) . " / " . count($csvAirlines) . "\n";
if ($unmappedCountries) {
    echo "  Unmapped countries:\n";
    foreach (array_keys($unmappedCountries) as $uc) {
        echo "    - $uc\n";
    }
}

// --- Step 6: Match and update ---
echo "\n--- Step 6: Matching and updating airlines ---\n";
$matched = 0;
$updated = 0;
$inserted = 0;
$skipped = [];

foreach ($csvAirlines as $ca) {
    // Try to find existing airline by: URL name > name > source_url
    $existing = null;
    
    // 1. Try by source_url
    if ($ca['source_url']) {
        $existing = row("SELECT id, name, country_code, fleet_size, source_url FROM airlines WHERE source_url = ?", [$ca['source_url']]);
    }
    
    // 2. Try by URL-derived name
    if (!$existing && $ca['url_name']) {
        $existing = row("SELECT id, name, country_code, fleet_size, source_url FROM airlines WHERE name = ?", [$ca['url_name']]);
    }
    
    // 3. Try by exact CSV name
    if (!$existing) {
        $existing = row("SELECT id, name, country_code, fleet_size, source_url FROM airlines WHERE name = ?", [$ca['name']]);
    }
    
    // 4. Try by LIKE (name contains CSV name or vice versa)
    if (!$existing) {
        $existing = row("SELECT id, name, country_code, fleet_size, source_url FROM airlines WHERE name LIKE ? LIMIT 1", ['%' . $ca['name'] . '%']);
    }
    
    if ($existing) {
        $matched++;
        $updates = [];
        $params = [];
        
        // Update country_code if different or null
        if ($ca['country_code'] && ($existing['country_code'] === null || $existing['country_code'] === '' || $existing['country_code'] !== $ca['country_code'])) {
            $updates[] = 'country_code = ?';
            $params[] = $ca['country_code'];
        }
        
        // Update fleet_size if CSV has data and existing is null/empty
        if ($ca['fleet_size'] !== null && $existing['fleet_size'] === null) {
            $updates[] = 'fleet_size = ?';
            $params[] = $ca['fleet_size'];
        }
        
        // Update source_url if not set
        if ($ca['source_url'] && !$existing['source_url']) {
            $updates[] = 'source_url = ?';
            $params[] = $ca['source_url'];
        }
        
        if ($updates) {
            $params[] = $existing['id'];
            db()->prepare("UPDATE airlines SET " . implode(', ', $updates) . " WHERE id = ?")->execute($params);
            $updated++;
        }
    } else {
        // Insert new airline
        $inserted++;
        $stmt = db()->prepare("INSERT INTO airlines (name, country_code, fleet_size, source_url, data_source) VALUES (?, ?, ?, ?, 'planespotters_country_csv')");
        $stmt->execute([
            $ca['name'],
            $ca['country_code'],
            $ca['fleet_size'],
            $ca['source_url'],
        ]);
    }
}

echo "  Matched existing: $matched\n";
echo "  Updated records: $updated\n";
echo "  Inserted new: $inserted\n";

// --- Step 7: Summary ---
$totalAfter = (int) scalar('SELECT COUNT(*) FROM airlines');
$withCountry = (int) scalar("SELECT COUNT(*) FROM airlines WHERE country_code IS NOT NULL AND country_code != ''");
$withoutCountry = (int) scalar("SELECT COUNT(*) FROM airlines WHERE country_code IS NULL OR country_code = ''");
$withFleet = (int) scalar("SELECT COUNT(*) FROM airlines WHERE fleet_size IS NOT NULL AND fleet_size > 0");

echo "\n=== FINAL SUMMARY ===\n";
echo "  Total airlines in DB: $totalAfter\n";
echo "  With country code: $withCountry\n";
echo "  Without country code: $withoutCountry\n";
echo "  With fleet size: $withFleet\n";
echo "  Unmapped countries: " . count($unmappedCountries) . "\n";

echo "\n=== SAMPLE UPDATED RECORDS ===\n";
$samples = rows("SELECT name, country_code, fleet_size, source_url FROM airlines WHERE data_source = 'planespotters_country_csv' OR (country_code IS NOT NULL AND country_code != '') ORDER BY last_modified DESC LIMIT 15");
foreach ($samples as $s) {
    echo "  {$s['name']} | {$s['country_code']} | fleet={$s['fleet_size']} | {$s['source_url']}\n";
}
