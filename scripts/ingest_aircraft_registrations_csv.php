<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$csvFile = __DIR__ . '/../data/data/aircraft_data_nov_2021.csv';
if (!file_exists($csvFile)) {
    fwrite(STDERR, "ERROR: CSV not found at $csvFile\n"); exit(1);
}

// Detect columns in aircraft_registrations
$cols = [];
$st = $db->query("SHOW COLUMNS FROM aircraft_registrations");
while ($r = $st->fetch(PDO::FETCH_ASSOC)) $cols[$r['Field']] = true;

$hasOperatorName = isset($cols['operator_name']);
$hasTypeCode = isset($cols['type_code']);
$hasConstructionNumber = isset($cols['construction_number']);
$hasAircraftType = isset($cols['aircraft_type']);
$hasCountryCode = isset($cols['country_code']);
$hasDataSource = isset($cols['data_source']);
$hasDateAdded = isset($cols['date_added']);
$hasDateModified = isset($cols['date_modified']);
$hasRecordStatus = isset($cols['record_status']);
$hasAge = isset($cols['age']);
$hasAdsHex = isset($cols['adshex']);
$hasOperatorIcao = isset($cols['operator_icao']);
$hasIcaoCode = isset($cols['icao_code']);

echo "Target table: aircraft_registrations\n\n";

// Parse CSV
$rows = [];
$handle = fopen($csvFile, 'r');
$rawHeader = fgetcsv($handle);

while (($data = fgetcsv($handle)) !== false) {
    if (count($data) < 4) continue;
    $rows[] = [
        'operator' => trim($data[0] ?? ''),
        'registration' => trim($data[1] ?? ''),
        'aircraft_type' => trim($data[2] ?? ''),
        'msn' => trim($data[3] ?? ''),
    ];
}
fclose($handle);

echo "Total CSV rows: " . count($rows) . "\n\n";

// Pre-fetch existing registrations (keyed by registration)
$existing = [];
$st = $db->query("SELECT registration, aircraft_type, construction_number, operator_name, country_code FROM aircraft_registrations WHERE registration IS NOT NULL AND registration != ''");
foreach ($st as $r) {
    $existing[$r['registration']] = $r;
}

$inserted = 0;
$updated = 0;
$skippedNoReg = 0;
$skippedDbWins = 0;

$now = date('Y-m-d H:i:s');

echo "Processing...\n\n";

foreach ($rows as $r) {
    $reg = $r['registration'];
    if (!$reg) {
        $skippedNoReg++;
        continue;
    }

    $e = $existing[$reg] ?? null;

    if ($e) {
        // DB record exists — only fill NULL/empty DB fields
        $updates = [];
        $params = [];

        if ($hasAircraftType && $r['aircraft_type'] && empty($e['aircraft_type'])) {
            $updates[] = "aircraft_type=?";
            $params[] = $r['aircraft_type'];
        }
        if ($hasConstructionNumber && $r['msn'] && empty($e['construction_number'])) {
            $updates[] = "construction_number=?";
            $params[] = $r['msn'];
        }
        if ($hasOperatorName && $r['operator'] && empty($e['operator_name'])) {
            $updates[] = "operator_name=?";
            $params[] = $r['operator'];
        }
        if ($hasDataSource) {
            $updates[] = "data_source=?";
            $params[] = "aircraft_data_nov_2021.csv";
        }
        if ($hasDateModified) {
            $updates[] = "date_modified=?";
            $params[] = $now;
        }

        if ($updates) {
            $params[] = $reg;
            $db->prepare("UPDATE aircraft_registrations SET " . implode(',', $updates) . " WHERE registration=?")
                ->execute($params);
            $updated++;
            echo "  ~ {$reg}: filled missing fields\n";
        } else {
            $skippedDbWins++;
        }
    } else {
        // New record — INSERT
        $insCols = ["registration"];
        $insVals = [$reg];
        $insPh = ["?"];

        if ($hasAircraftType && $r['aircraft_type']) {
            $insCols[] = "aircraft_type"; $insVals[] = $r['aircraft_type']; $insPh[] = "?";
        }
        if ($hasConstructionNumber && $r['msn']) {
            $insCols[] = "construction_number"; $insVals[] = $r['msn']; $insPh[] = "?";
        }
        if ($hasOperatorName && $r['operator']) {
            $insCols[] = "operator_name"; $insVals[] = $r['operator']; $insPh[] = "?";
        }
        if ($hasDataSource) {
            $insCols[] = "data_source"; $insVals[] = "aircraft_data_nov_2021.csv"; $insPh[] = "?";
        }
        if ($hasDateAdded) {
            $insCols[] = "date_added"; $insVals[] = $now; $insPh[] = "?";
        }
        if ($hasRecordStatus) {
            $insCols[] = "record_status"; $insVals[] = "active"; $insPh[] = "?";
        }

        $db->prepare("INSERT INTO aircraft_registrations (" . implode(',', $insCols) . ") VALUES (" . implode(',', $insPh) . ")")
            ->execute($insVals);
        $inserted++;
        echo "  + {$reg}: inserted\n";
    }
}

echo "\n--- Summary ---\n";
echo "Total CSV rows: " . count($rows) . "\n";
echo "Skipped (no registration): $skippedNoReg\n";
echo "Inserted (new): $inserted\n";
echo "Updated (filled missing): $updated\n";
echo "Skipped (DB had data): $skippedDbWins\n";
echo "\nDone.\n";
