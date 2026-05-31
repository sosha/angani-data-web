<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$csvFile = __DIR__ . '/../data/data/aircraft_types.csv';
if (!file_exists($csvFile)) { fwrite(STDERR, "ERROR: CSV not found at $csvFile\n"); exit(1); }

$rows = [];
if (($handle = fopen($csvFile, 'r')) !== false) {
    $headers = fgetcsv($handle);
    if ($headers === false || count($headers) < 4) { fwrite(STDERR, "ERROR: Invalid CSV header\n"); exit(1); }
    while (($data = fgetcsv($handle)) !== false) {
        if (count($data) >= 4) {
            $rows[] = ['iata' => trim($data[0]), 'icao' => trim($data[1]), 'type' => trim($data[2]), 'wtc' => trim($data[3])];
        }
    }
    fclose($handle);
}

echo "Loaded " . count($rows) . " rows from CSV\n\n";

$manufacturerMap = [
    '/^Airbus Industrie\b/i' => 'Airbus',
    '/^Airbus\b/i' => 'Airbus',
    '/^Boeing\b/i' => 'Boeing',
    '/^McDonnell Douglas\b/i' => 'McDonnell Douglas',
    '/^Douglas\b/i' => 'Douglas',
    '/^Lockheed\b/i' => 'Lockheed',
    '/^Fokker\b/i' => 'Fokker',
    '/^Embraer\b/i' => 'Embraer',
    '/^Canadair\b/i' => 'Bombardier',
    '/^Bombardier\b/i' => 'Bombardier',
    '/^De Havilland Canada\b/i' => 'De Havilland Canada',
    '/^De Havilland\b/i' => 'De Havilland',
    '/^British Aerospace\b/i' => 'British Aerospace',
    '/^BAe\b/i' => 'British Aerospace',
    '/^Hawker Siddeley\b/i' => 'Hawker Siddeley',
    '/^Avro\b/i' => 'Avro',
    '/^Short\w*\b/i' => 'Shorts',
    '/^Fairchild Dornier\b/i' => 'Fairchild Dornier',
    '/^Fairchild\b/i' => 'Fairchild',
    '/^Dornier\b/i' => 'Fairchild Dornier',
    '/^Aerospatiale\/Alenia\b/i' => 'ATR',
    '/^Aerospatiale\/BAC\b/i' => 'Aerospatiale',
    '/^Aerospatiale\b/i' => 'Aerospatiale',
    '/^ATR\b/i' => 'ATR',
    '/^CASA \/ IPTN\b/i' => 'CASA',
    '/^CASA\b/i' => 'CASA',
    '/^ANTONOV\b/i' => 'Antonov',
    '/^Antonov\b/i' => 'Antonov',
    '/^Ilyushin\b/i' => 'Ilyushin',
    '/^Tupolev\b/i' => 'Tupolev',
    '/^Yakovlev\b/i' => 'Yakovlev',
    '/^Sukhoi\b/i' => 'Sukhoi',
    '/^COMAC\b/i' => 'COMAC',
    '/^Harbin\b/i' => 'Harbin',
    '/^Xian\b/i' => 'Xian',
    '/^NAMC\b/i' => 'NAMC',
    '/^Gulfstream Aerospace\b/i' => 'Gulfstream',
    '/^Gulfstream\/Rockwell\b/i' => 'Gulfstream',
    '/^Cessna\b/i' => 'Cessna',
    '/^Beechcraft\b/i' => 'Beechcraft',
    '/^Beechcfrat\b/i' => 'Beechcraft',
    '/^Pilatus Britten-Norman\b/i' => 'Britten-Norman',
    '/^Pilatus\b/i' => 'Pilatus',
    '/^Piper\b/i' => 'Piper',
    '/^Mitsubishi\b/i' => 'Mitsubishi',
    '/^Israel Aircraft\b/i' => 'Israel Aircraft Industries',
    '/^Government Aircraft\b/i' => 'Government Aircraft Factories',
    '/^Convair\b/i' => 'Convair',
    '/^Curtiss\b/i' => 'Curtiss',
    '/^Grumman\b/i' => 'Grumman',
    '/^Helio\b/i' => 'Helio',
    '/^Junkers\b/i' => 'Junkers',
    '/^Vickers\b/i' => 'Vickers',
    '/^Partenavia\b/i' => 'Partenavia',
    '/^LET\b/i' => 'LET',
    '/^Dassault\b/i' => 'Dassault',
    '/^Gates Learjet\b/i' => 'Gates Learjet',
    '/^Saab\b/i' => 'Saab',
    '/^Ayres\b/i' => 'Ayres',
];

function parseAircraft(string $type): array {
    global $manufacturerMap;
    foreach ($manufacturerMap as $pattern => $mfr) {
        if (preg_match($pattern, $type)) {
            $model = trim(preg_replace($pattern, '', $type));
            $model = preg_replace('/^\s+-\s+/', '', $model);
            $model = preg_replace('/\s+/', ' ', $model);
            return [$mfr, $model];
        }
    }
    $parts = explode(' ', $type, 2);
    return [trim($parts[0]), trim($parts[1] ?? '')];
}

$inserted = 0;
$updated = 0;
$skipped = 0;

foreach ($rows as $r) {
    $icao = $r['icao'];
    $iata = $r['iata'];
    $type = $r['type'];
    $wtc = $r['wtc'];

    if (!$icao || strtolower($icao) === 'n/a') { $skipped++; continue; }

    [$mfr, $model] = parseAircraft($type);
    if (!$mfr) $mfr = 'Unknown';
    if (!$model) $model = $type;

    $exists = $db->prepare("SELECT 1 FROM aircraft_types WHERE icao_code=?");
    $exists->execute([$icao]);
    if ($exists->fetch()) {
        $db->prepare("UPDATE aircraft_types SET iata_code=?, manufacturer=?, model=?, description=?, wtc=?, updated_at=NOW() WHERE icao_code=?")
            ->execute([$iata, $mfr, $model, $type, $wtc, $icao]);
        $updated++;
    } else {
        $db->prepare("INSERT INTO aircraft_types (icao_code, iata_code, manufacturer, model, description, wtc, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())")
            ->execute([$icao, $iata, $mfr, $model, $type, $wtc]);
        $inserted++;
    }
}

echo "\n--- Summary ---\n";
echo "Total CSV rows: " . count($rows) . "\n";
echo "Inserted: $inserted\n";
echo "Updated: $updated\n";
echo "Skipped (no ICAO): $skipped\n";
echo "\nDone.\n";
