<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$csvFile = __DIR__ . '/../ultimate_airports.csv';
if (!file_exists($csvFile)) {
    fwrite(STDERR, "ERROR: CSV not found at $csvFile\n"); exit(1);
}

// Lookup table for airports with missing names
$missingNames = [
    'RKZ' => 'Shigatse Peace Airport',
    'TFU' => 'Chengdu Tianfu International Airport',
    'UBN' => 'Chinggis Khaan International Airport',
    'EHU' => 'Ezhou Huahu Airport',
    'WSI' => 'Western Sydney International Airport',
    'WTB' => 'Toowoomba Wellcamp Airport',
    'KNO' => 'Kualanamu International Airport',
    'YIA' => 'Yogyakarta International Airport',
    'LOP' => 'Lombok International Airport',
    'GOX' => 'Manohar International Airport',
    'NMF' => 'Maafaru International Airport',
    'HWR' => 'Halwara International Airport',
    'LTH' => 'Long Thanh International Airport',
];

echo "Reading CSV...\n";
$handle = fopen($csvFile, 'r');
$header = fgetcsv($handle);
$colIdx = array_flip($header);

$rows = [];
while (($data = fgetcsv($handle)) !== false) {
    if (count($data) < 14) continue;
    $iata = trim($data[$colIdx['IATA']] ?? '');
    $icao = trim($data[$colIdx['ICAO']] ?? '');
    $name = trim($data[$colIdx['Name']] ?? '');

    if (!$name && $iata && isset($missingNames[$iata])) {
        $name = $missingNames[$iata];
    }

    $rows[] = [
        'iata' => $iata,
        'icao' => $icao,
        'faa' => trim($data[$colIdx['FAA']] ?? ''),
        'name' => $name,
        'location' => trim($data[$colIdx['Location']] ?? ''),
        'elevation' => trim($data[$colIdx['Elevation']] ?? ''),
        'latitude' => trim($data[$colIdx['Latitude']] ?? ''),
        'longitude' => trim($data[$colIdx['Longitude']] ?? ''),
        'website' => trim($data[$colIdx['Website']] ?? ''),
        'wikipedia' => trim($data[$colIdx['Wikipedia']] ?? ''),
        'airport_type' => trim($data[$colIdx['Airport Type']] ?? ''),
        'iso_country' => trim($data[$colIdx['ISO Country']] ?? ''),
    ];
}
fclose($handle);

echo "Total CSV rows: " . count($rows) . "\n\n";

$inserted = 0;
$updated = 0;
$skipped = 0;

$sql = "INSERT INTO airports (ident, type, name, latitude_deg, longitude_deg, elevation_ft, iso_country, municipality, gps_code, iata_code, local_code, home_link, wikipedia_link)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE
        type = VALUES(type),
        name = VALUES(name),
        latitude_deg = VALUES(latitude_deg),
        longitude_deg = VALUES(longitude_deg),
        elevation_ft = VALUES(elevation_ft),
        iso_country = VALUES(iso_country),
        municipality = VALUES(municipality),
        gps_code = VALUES(gps_code),
        iata_code = VALUES(iata_code),
        local_code = VALUES(local_code),
        home_link = VALUES(home_link),
        wikipedia_link = VALUES(wikipedia_link)";

$stmt = $db->prepare($sql);

echo "Processing...\n\n";

foreach ($rows as $r) {
    $ident = $r['icao'] ?: ($r['iata'] ?: $r['faa']);
    if (!$ident) {
        $skipped++;
        continue;
    }
    if (!$r['name']) {
        $skipped++;
        continue;
    }

    $elevFt = null;
    if ($r['elevation']) {
        $elevFt = (int)str_replace([' feet', ' ft', ','], '', $r['elevation']);
    }

    $lat = $r['latitude'] ? (float)$r['latitude'] : null;
    $lon = $r['longitude'] ? (float)$r['longitude'] : null;

    $stmt->execute([
        $ident,
        $r['airport_type'] ?: null,
        $r['name'],
        $lat,
        $lon,
        $elevFt,
        $r['iso_country'] ?: null,
        $r['location'] ?: null,
        $r['icao'] ?: null,
        $r['iata'] ?: null,
        $r['faa'] ?: null,
        $r['website'] ?: null,
        $r['wikipedia'] ?: null,
    ]);

    if ($stmt->rowCount() === 1) {
        $inserted++;
    } else {
        $updated++;
    }
}

$finalCount = $db->query("SELECT COUNT(*) FROM airports")->fetchColumn();

echo "\n--- Summary ---\n";
echo "Total CSV rows: " . count($rows) . "\n";
echo "Inserted: $inserted\n";
echo "Updated: $updated\n";
echo "Skipped (no ident or no name): $skipped\n";
echo "Total airports in DB: $finalCount\n";
echo "\nDone.\n";
