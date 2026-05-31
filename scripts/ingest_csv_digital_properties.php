<?php
/**
 * Ingests digital properties from airlines_db_export.csv into airline_digital_properties.
 *
 * Maps CSV columns:
 *   website_url   → Contact / Website
 *   wikipedia_url → External Link / Wikipedia
 *   alliance      → Alliance / Airline Alliance
 *   hubs          → Contact / Hub
 *   headquarters  → Contact / HQ Address
 *   key_personnel → Personnel / Key Personnel
 *
 * Usage: php scripts/ingest_csv_digital_properties.php
 * Environment: ANGANI_DB_PASS must be set
 */

$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$csvPath = __DIR__ . '/../data/data/airlines_db_export.csv';
if (!file_exists($csvPath)) {
    fwrite(STDERR, "ERROR: CSV not found at $csvPath\n"); exit(1);
}

function upsertDigitalProperty(PDO $db, string $icao, string $name, string $category, string $platform, string $value, string $countryCode): bool {
    $value = trim($value);
    if (!$value) return false;
    // Skip generic/default values
    $generic = ['americas', 'europe', 'asia', 'africa', 'other', 'north america', 'south america', 'oceania', 'antarctica'];
    if (in_array(strtolower($value), $generic)) return false;
    // Skip known default key_personnel
    if (stripos($value, 'Faisal Al-Turki') !== false && stripos($value, 'Karim Baky') !== false) return false;

    $exists = $db->prepare("SELECT id FROM airline_digital_properties WHERE icao_code=? AND category=? AND platform=? AND url_or_handle=?");
    $exists->execute([$icao, $category, $platform, $value]);
    if ($exists->fetch()) return false;

    $db->prepare("INSERT INTO airline_digital_properties (country_code, icao_code, airline_name, category, platform, url_or_handle, is_primary)
        VALUES (?, ?, ?, ?, ?, ?, 1)")
        ->execute([$countryCode, $icao, $name, $category, $platform, $value]);
    return true;
}

echo "Loading existing airlines from DB...\n";
$airlineMap = [];
$stmt = $db->query("SELECT icao_code, name, country_code FROM airlines WHERE icao_code IS NOT NULL");
foreach ($stmt as $row) {
    $airlineMap[$row['icao_code']] = ['name' => $row['name'], 'country_code' => $row['country_code'] ?? ''];
}
echo "Found " . count($airlineMap) . " airlines in DB.\n\n";

$fh = fopen($csvPath, 'r');
if (!$fh) { fwrite(STDERR, "ERROR: Cannot open CSV.\n"); exit(1); }

$header = fgetcsv($fh);
// Build column index map
$colIdx = array_flip($header);

$mappedCols = [
    'website_url'    => ['category' => 'Contact',      'platform' => 'Website'],
    'wikipedia_url'  => ['category' => 'External Link', 'platform' => 'Wikipedia'],
    'alliance'       => ['category' => 'Alliance',      'platform' => 'Airline Alliance'],
    'hubs'           => ['category' => 'Contact',       'platform' => 'Hub'],
    'headquarters'   => ['category' => 'Contact',       'platform' => 'HQ Address'],
    'key_personnel'  => ['category' => 'Personnel',     'platform' => 'Key Personnel'],
];

$totalRows = 0;
$matchedIcao = 0;
$inserted = 0;
$dupSkipped = 0;

echo "Processing CSV rows...\n\n";

while (($row = fgetcsv($fh)) !== false) {
    $totalRows++;
    $icaoCode = trim($row[$colIdx['icao_code']] ?? '');
    if (!$icaoCode) continue;

    // Look up in pre-loaded airline map
    if (!isset($airlineMap[$icaoCode])) continue;
    $matchedIcao++;

    $airlineName = $row[$colIdx['name']] ?? $airlineMap[$icaoCode]['name'];
    $countryCode = $airlineMap[$icaoCode]['country_code'];

    foreach ($mappedCols as $colName => $mapping) {
        $value = trim($row[$colIdx[$colName]] ?? '');
        if (!$value) continue;

        if (upsertDigitalProperty($db, $icaoCode, $airlineName, $mapping['category'], $mapping['platform'], $value, $countryCode)) {
            $inserted++;
        } else {
            $dupSkipped++;
        }
    }
}

fclose($fh);

echo "\n--- Summary ---\n";
echo "Total CSV rows: $totalRows\n";
echo "Rows with ICAO matching an airline in DB: $matchedIcao\n";
echo "Digital properties inserted: $inserted\n";
echo "Skipped (already exists or filtered): $dupSkipped\n";
echo "\nDone.\n";
