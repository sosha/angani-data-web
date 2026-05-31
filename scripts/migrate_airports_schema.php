<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

echo "Creating airports table if not exists...\n";

$db->exec("
    CREATE TABLE IF NOT EXISTS airports (
        ident VARCHAR(20) NOT NULL PRIMARY KEY,
        type VARCHAR(40) DEFAULT NULL,
        name VARCHAR(255) NOT NULL,
        latitude_deg DECIMAL(12,7) DEFAULT NULL,
        longitude_deg DECIMAL(12,7) DEFAULT NULL,
        elevation_ft INT DEFAULT NULL,
        continent VARCHAR(4) DEFAULT NULL,
        iso_country VARCHAR(6) DEFAULT NULL,
        municipality VARCHAR(190) DEFAULT NULL,
        scheduled_service TINYINT(1) DEFAULT 0,
        gps_code VARCHAR(8) DEFAULT NULL,
        iata_code VARCHAR(8) DEFAULT NULL,
        local_code VARCHAR(20) DEFAULT NULL,
        home_link TEXT DEFAULT NULL,
        wikipedia_link TEXT DEFAULT NULL,
        keywords TEXT DEFAULT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        KEY idx_airport_country (iso_country),
        KEY idx_airport_iata (iata_code),
        KEY idx_airport_gps (gps_code),
        KEY idx_airport_type (type),
        FULLTEXT KEY ft_airports (name, municipality, iata_code, gps_code, ident, keywords)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
");

echo "Table created.\n\n";

// Count legacy_airports
$count = $db->query("SELECT COUNT(*) FROM legacy_airports")->fetchColumn();
echo "legacy_airports rows: $count\n";

// Count already in airports
$existingCount = $db->query("SELECT COUNT(*) FROM airports")->fetchColumn();
echo "airports rows (before migration): $existingCount\n\n";

// Migrate legacy_airports → airports
$stmt = $db->query("SELECT * FROM legacy_airports");
$inserted = 0;
$skipped = 0;

$insertSql = "INSERT IGNORE INTO airports (ident, type, name, latitude_deg, longitude_deg, elevation_ft, iso_country, municipality, gps_code, iata_code)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$insertStmt = $db->prepare($insertSql);

foreach ($stmt as $row) {
    $ident = $row['ident'] ?: ($row['icao_code'] ?: $row['iata_code']);
    if (!$ident) {
        $skipped++;
        continue;
    }

    $name = $row['airport_name'] ?: ($row['trading_name'] ?: $row['city_name']);
    if (!$name) $name = $ident;

    $insertStmt->execute([
        $ident,
        $row['airport_type'] ?: null,
        $name,
        $row['latitude'] ?: null,
        $row['longitude'] ?: null,
        $row['elevation_ft'] ?: null,
        $row['country_code'] ?: null,
        $row['municipality'] ?: ($row['city_name'] ?: null),
        $row['icao_code'] ?: null,
        $row['iata_code'] ?: null,
    ]);

    if ($insertStmt->rowCount() > 0) $inserted++;
}

$finalCount = $db->query("SELECT COUNT(*) FROM airports")->fetchColumn();
echo "\n--- Migration Summary ---\n";
echo "Inserted into airports: $inserted\n";
echo "Skipped (no ident): $skipped\n";
echo "Total airports rows now: $finalCount\n";
echo "Done.\n";
