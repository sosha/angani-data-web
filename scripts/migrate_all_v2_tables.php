<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

// Helper to get count
function cnt(PDO $db, string $table): int {
    try { return (int)$db->query("SELECT COUNT(*) FROM `$table`")->fetchColumn(); }
    catch (Throwable $e) { return 0; }
}

$tables = [];

// ============================================================
// 1. Countries
// ============================================================
if (!tableExists($db, 'countries')) {
    echo "Creating countries table...\n";
    $db->exec("
        CREATE TABLE countries (
            iso_alpha_2 VARCHAR(6) NOT NULL PRIMARY KEY,
            iso_alpha_3 VARCHAR(3) DEFAULT NULL,
            name_common VARCHAR(190) NOT NULL,
            name_official VARCHAR(255) DEFAULT NULL,
            continent VARCHAR(40) DEFAULT NULL,
            un_region VARCHAR(120) DEFAULT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            KEY idx_continent (continent),
            KEY idx_region (un_region)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    ");
    $tables[] = 'countries';
}

if (tableExists($db, 'legacy_countries') && cnt($db, 'countries') == 0) {
    echo "Migrating legacy_countries → countries...\n";
    $legacy = $db->query("SELECT * FROM legacy_countries");
    $stmt = $db->prepare("INSERT IGNORE INTO countries (iso_alpha_2, name_common, un_region, name_official)
        VALUES (?, ?, ?, ?)");
    $count = 0;
    foreach ($legacy as $row) {
        $stmt->execute([
            $row['code'],
            $row['name'],
            $row['region'] ?: null,
            $row['name'],
        ]);
        if ($stmt->rowCount() > 0) $count++;
    }
    echo "  Inserted $count countries\n";
}

// ============================================================
// 2. Airlines
// ============================================================
if (!tableExists($db, 'airlines')) {
    echo "Creating airlines table...\n";
    $db->exec("
        CREATE TABLE airlines (
            icao_code VARCHAR(16) NOT NULL PRIMARY KEY,
            iata_code VARCHAR(8) DEFAULT NULL,
            name VARCHAR(255) NOT NULL,
            alias VARCHAR(255) DEFAULT NULL,
            callsign VARCHAR(120) DEFAULT NULL,
            country VARCHAR(190) DEFAULT NULL,
            country_code VARCHAR(6) DEFAULT NULL,
            active VARCHAR(10) DEFAULT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            KEY idx_airlines_country (country_code),
            KEY idx_airlines_iata (iata_code),
            FULLTEXT KEY ft_airlines (name, alias, callsign, iata_code, icao_code)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    ");
    $tables[] = 'airlines';
}

if (tableExists($db, 'legacy_airlines') && cnt($db, 'airlines') == 0) {
    echo "Migrating legacy_airlines → airlines...\n";
    $legacy = $db->query("SELECT * FROM legacy_airlines");
    $stmt = $db->prepare("INSERT IGNORE INTO airlines (icao_code, iata_code, name, alias, callsign, country, country_code, active)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $count = 0;
    foreach ($legacy as $row) {
        $icao = $row['icao_code'];
        if (!$icao) continue;

        $name = $row['name'] ?: ($row['trading_name'] ?: $row['legal_name']);
        if (!$name) $name = $icao;

        $alias = null;
        if ($row['legal_name'] && $row['legal_name'] !== $name) {
            $alias = $row['legal_name'];
        } elseif ($row['trading_name'] && $row['trading_name'] !== $name) {
            $alias = $row['trading_name'];
        }

        $active = null;
        if ($row['status_bucket'] === 'active') $active = 'Y';
        elseif ($row['status_bucket'] === 'defunct') $active = 'N';

        $countryName = null;
        if ($row['country_code']) {
            try {
                $cr = $db->prepare("SELECT name_common FROM countries WHERE iso_alpha_2=?");
                $cr->execute([$row['country_code']]);
                $cn = $cr->fetchColumn();
                if ($cn) $countryName = $cn;
            } catch (Throwable $e) {}
        }

        $stmt->execute([
            $icao,
            $row['iata_code'] ?: null,
            $name,
            $alias,
            $row['callsign'] ?: null,
            $countryName,
            $row['country_code'] ?: null,
            $active,
        ]);
        if ($stmt->rowCount() > 0) $count++;
    }
    echo "  Inserted $count airlines\n";
}

// ============================================================
// 3. Aircraft Types
// ============================================================
if (!tableExists($db, 'aircraft_types')) {
    echo "Creating aircraft_types table...\n";
    $db->exec("
        CREATE TABLE aircraft_types (
            icao_code VARCHAR(16) NOT NULL PRIMARY KEY,
            iata_code VARCHAR(8) DEFAULT NULL,
            manufacturer VARCHAR(190) NOT NULL,
            model VARCHAR(190) DEFAULT NULL,
            type VARCHAR(40) DEFAULT NULL,
            description VARCHAR(255) DEFAULT NULL,
            engine_type VARCHAR(40) DEFAULT NULL,
            engine_count INT DEFAULT NULL,
            wtc VARCHAR(10) DEFAULT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            KEY idx_type_iata (iata_code),
            KEY idx_type_manufacturer (manufacturer),
            FULLTEXT KEY ft_aircraft_types (manufacturer, model, type, iata_code, icao_code)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    ");
    $tables[] = 'aircraft_types';
}

if (tableExists($db, 'legacy_aircraft_types') && cnt($db, 'aircraft_types') == 0) {
    echo "Migrating legacy_aircraft_types → aircraft_types...\n";
    $legacy = $db->query("SELECT * FROM legacy_aircraft_types");
    $stmt = $db->prepare("INSERT IGNORE INTO aircraft_types (icao_code, iata_code, manufacturer, model, type, description, engine_type, engine_count, wtc)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $count = 0;
    foreach ($legacy as $row) {
        $icao = $row['icao_code'];
        if (!$icao) continue;

        $manufacturer = $row['manufacturer'] ?: 'Unknown';
        $desc = $row['full_designation'] ?: ($row['common_name'] ?: null);
        if ($desc && $row['aircraft_type'] && strlen($desc) < strlen($row['aircraft_type'])) {
            $desc = $row['aircraft_type'];
        } elseif (!$desc) {
            $desc = $row['aircraft_type'] ?: null;
        }
        if ($desc && strlen($desc) > 255) $desc = substr($desc, 0, 255);

        $stmt->execute([
            $icao,
            $row['iata_code'] ?: null,
            $manufacturer,
            $row['model'] ?: null,
            $row['category'] ?: null,
            $desc,
            $row['engine_type'] ?: null,
            $row['engine_count'] ?: null,
            $row['wtc'] ?: null,
        ]);
        if ($stmt->rowCount() > 0) $count++;
    }
    echo "  Inserted $count aircraft_types\n";
}

echo "\n--- Summary ---\n";
echo "Tables created: " . implode(', ', $tables) . "\n";
foreach (['countries', 'airlines', 'aircraft_types'] as $t) {
    echo "$t: " . cnt($db, $t) . " rows\n";
}
echo "Done.\n";

function tableExists(PDO $db, string $name): bool {
    try {
        $db->query("SELECT 1 FROM `$name` LIMIT 1");
        return true;
    } catch (Throwable $e) {
        return false;
    }
}
