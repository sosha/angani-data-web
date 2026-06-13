<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=127.0.0.1;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

// Paths
$csvFile = __DIR__ . '/../fleet/integrated_fleet.csv';
$prefixesFile = __DIR__ . '/../fleet/registration_prefixes.json';

if (!file_exists($csvFile)) { fwrite(STDERR, "ERROR: CSV not found at $csvFile\n"); exit(1); }
if (!file_exists($prefixesFile)) { fwrite(STDERR, "ERROR: prefixes not found at $prefixesFile\n"); exit(1); }

// Load registration prefix -> country name mapping
$prefixMap = json_decode(file_get_contents($prefixesFile), true);
if (!$prefixMap) { fwrite(STDERR, "ERROR: failed to parse registration_prefixes.json\n"); exit(1); }

// Load ISO country map from DB: country name -> iso_alpha_2
$countryMap = [];
$st = $db->query("SELECT iso_alpha_2, LOWER(name_common) lc FROM countries WHERE iso_alpha_2 IS NOT NULL AND name_common IS NOT NULL");
foreach ($st as $r) $countryMap[$r['lc']] = $r['iso_alpha_2'];

function resolveCountryCode(string $reg, ?string $countryName, array $countryMap, array $prefixMap): ?string {
    if ($countryName) {
        $key = strtolower(trim($countryName));
        // Direct match
        if (isset($countryMap[$key])) return $countryMap[$key];
        // Try stripping leading "the "
        if (str_starts_with($key, 'the ')) {
            $trimmed = substr($key, 4);
            if (isset($countryMap[$trimmed])) return $countryMap[$trimmed];
        }
        // "the Republic of the Congo", "the Democratic Republic of the Congo" -> try partial
        foreach ($countryMap as $lk => $code) {
            if (str_contains($lk, $key) || str_contains($key, $lk)) return $code;
        }
    }
    // Infer from registration prefix
    $reg = trim($reg);
    // Try longest prefix first (e.g. "VH-" before "VH")
    $prefixes = array_keys($prefixMap);
    usort($prefixes, fn($a, $b) => strlen($b) - strlen($a));
    foreach ($prefixes as $prefix) {
        if (str_starts_with($reg, $prefix)) {
            $countryName = $prefixMap[$prefix];
            $key = strtolower(trim($countryName));
            if (isset($countryMap[$key])) return $countryMap[$key];
            if (str_starts_with($key, 'the ')) {
                $trimmed = substr($key, 4);
                if (isset($countryMap[$trimmed])) return $countryMap[$trimmed];
            }
            foreach ($countryMap as $lk => $code) {
                if (str_contains($lk, $key) || str_contains($key, $lk)) return $code;
            }
            break;
        }
    }
    return null;
}

// Verify column detection
$cols = [];
$st = $db->query("SHOW COLUMNS FROM aircraft_registrations");
while ($r = $st->fetch()) $cols[$r['Field']] = true;

echo "Target table: aircraft_registrations\n\n";

// Parse CSV
$rows = [];
$handle = fopen($csvFile, 'r');
$header = fgetcsv($handle);
if (!$header || count($header) < 3) { fwrite(STDERR, "ERROR: invalid CSV header\n"); exit(1); }

$hIdx = array_flip($header);
$needed = ['Registration', 'Aircraft Type', 'ICAO Code'];
foreach ($needed as $n) {
    if (!isset($hIdx[$n])) { fwrite(STDERR, "ERROR: missing column '$n' in CSV header\n"); exit(1); }
}

while (($data = fgetcsv($handle)) !== false) {
    if (count($data) < count($header)) continue;
    $reg = trim($data[$hIdx['Registration']] ?? '');
    if (!$reg) continue;
    $rows[] = [
        'icao_code' => trim($data[$hIdx['ICAO Code']] ?? ''),
        'aircraft_type' => trim($data[$hIdx['Aircraft Type']] ?? ''),
        'registration' => $reg,
        'adshex' => trim($data[$hIdx['ADSHEX'] ?? -1] ?? ''),
        'type_code' => trim($data[$hIdx['Type Code'] ?? -1] ?? ''),
        'construction_number' => trim($data[$hIdx['Construction Number'] ?? -1] ?? ''),
        'age' => trim($data[$hIdx['Age'] ?? -1] ?? ''),
        'registration_country' => trim($data[$hIdx['RegistrationCountry'] ?? -1] ?? ''),
        'source' => trim($data[$hIdx['Source'] ?? -1] ?? ''),
    ];
}
fclose($handle);
echo "Total CSV rows with registration: " . count($rows) . "\n\n";

// Pre-fetch existing registrations
$existing = [];
$st = $db->query("SELECT registration, aircraft_type, construction_number, operator_name, country_code, icao_code, adshex, type_code, age, data_source FROM aircraft_registrations WHERE registration IS NOT NULL AND registration != ''");
foreach ($st as $r) $existing[$r['registration']] = $r;

$inserted = 0; $updated = 0; $skippedNoReg = 0; $skippedDbComplete = 0; $countryResolved = 0; $countryMissing = 0;

$now = date('Y-m-d H:i:s');
echo "Processing...\n";

foreach ($rows as $r) {
    $reg = $r['registration'];
    $e = $existing[$reg] ?? null;

    // Resolve country code
    $country_code = resolveCountryCode($reg, $r['registration_country'] ?: null, $countryMap, $prefixMap);
    if ($country_code) $countryResolved++; else $countryMissing++;

    $dataSource = $r['source'] ?: 'integrated_fleet';

    if ($e) {
        // Fill missing fields only (non-destructive)
        $updates = []; $params = [];
        $fields = [
            'aircraft_type' => $r['aircraft_type'],
            'icao_code' => $r['icao_code'],
            'adshex' => $r['adshex'],
            'type_code' => $r['type_code'],
            'construction_number' => $r['construction_number'],
            'age' => $r['age'],
        ];
        foreach ($fields as $col => $val) {
            if ($val && empty($e[$col])) {
                $updates[] = "$col=?";
                $params[] = $val;
            }
        }
        if ($country_code && empty($e['country_code'])) {
            $updates[] = "country_code=?";
            $params[] = $country_code;
        }
        if ($dataSource && empty($e['data_source'])) {
            $updates[] = "data_source=?";
            $params[] = $dataSource;
        }
        if ($updates) {
            $params[] = $reg;
            $db->prepare("UPDATE aircraft_registrations SET " . implode(',', $updates) . ", date_modified=? WHERE registration=?")
                ->execute(array_merge($params, [$now, $reg]));
            $updated++;
        } else {
            $skippedDbComplete++;
        }
    } else {
        // New record
        $insCols = ['registration', 'record_status', 'date_added', 'date_modified', 'data_source'];
        $insVals = [$reg, 'active', $now, $now, $dataSource];
        $optFields = [
            'aircraft_type' => $r['aircraft_type'],
            'icao_code' => $r['icao_code'],
            'adshex' => $r['adshex'],
            'type_code' => $r['type_code'],
            'construction_number' => $r['construction_number'],
            'age' => $r['age'] ? (float)$r['age'] : null,
        ];
        foreach ($optFields as $col => $val) {
            if ($val !== null && $val !== '') {
                $insCols[] = $col;
                $insVals[] = $val;
            }
        }
        if ($country_code) {
            $insCols[] = 'country_code';
            $insVals[] = $country_code;
        }
        $ph = implode(',', array_fill(0, count($insCols), '?'));
        $db->prepare("INSERT INTO aircraft_registrations (" . implode(',', $insCols) . ") VALUES ($ph)")
            ->execute($insVals);
        $inserted++;
    }
}

echo "\n--- Summary ---\n";
echo "Total CSV rows: " . count($rows) . "\n";
echo "Inserted (new): $inserted\n";
echo "Updated (filled missing): $updated\n";
echo "Skipped (DB had data): $skippedDbComplete\n";
echo "Country resolved: $countryResolved\n";
echo "Country missing: $countryMissing\n";
echo "\nDone.\n";
