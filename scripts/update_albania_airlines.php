<?php
require_once __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/functions.php';

$logFile = __DIR__ . '/../logs/update_albania.log';
$logDir = dirname($logFile);
if (!is_dir($logDir)) mkdir($logDir, 0755, true);
function log_msg(string $msg): void {
    global $logFile;
    $line = '[' . date('Y-m-d H:i:s') . '] ' . $msg;
    echo $line . "\n";
    file_put_contents($logFile, $line . "\n", FILE_APPEND);
}

// CSV data for Albanian airlines
$airlines = [
    [
        'name' => 'Ada Air',
        'iata_code' => 'ZY',
        'icao_code' => 'ADE',
        'callsign' => 'ADA AIR',
        'fleet_size' => 2,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '1991',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => 'Ada Air Sh.p.k',
        'trading_name' => null,
        'source_url' => 'https://www.planespotters.net/airline/Ada-Air',
        'destinations_count' => 2,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Ada_Air',
        'website_url' => 'http://www.adaair.com/',
        'logo_file' => null,
    ],
    [
        'name' => 'Air Albania',
        'iata_code' => 'ZB',
        'icao_code' => 'ABN',
        'callsign' => 'AIR ALBANIA',
        'fleet_size' => 8,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '2018',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => 'Air Albania shpk',
        'trading_name' => null,
        'source_url' => 'https://www.planespotters.net/airline/Air-Albania',
        'destinations_count' => 11,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Air_Albania',
        'website_url' => 'https://airalbania.com.al/',
        'logo_file' => 'air-albania.png',
    ],
    [
        'name' => 'Albanian Airlines',
        'iata_code' => 'LV',
        'icao_code' => 'LBC',
        'callsign' => 'ALBANIAN',
        'fleet_size' => 14,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '1992',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => 'Advanced Construction Group (ACG)',
        'legal_name' => 'Albanian Airlines MAK Sh.p.k',
        'trading_name' => null,
        'source_url' => 'https://www.planespotters.net/airline/Albanian-Airlines',
        'destinations_count' => 9,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Albanian_Airlines',
        'website_url' => 'http://www.albanianair.com/',
        'logo_file' => 'albanian-airlines.svg',
    ],
    [
        'name' => 'Albanian Airways',
        'iata_code' => null,
        'icao_code' => 'LBN',
        'callsign' => 'ALBANAIR',
        'fleet_size' => 1,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '2015?',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => null,
        'trading_name' => 'Albanian Airways',
        'source_url' => 'https://www.planespotters.net/airline/Albanian-Airways',
        'destinations_count' => null,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Albanian_Airways',
        'website_url' => null,
        'logo_file' => 'albanian-airways.png',
    ],
    [
        'name' => 'Albatros Airways',
        'iata_code' => '4H',
        'icao_code' => 'LBW',
        'callsign' => 'ALBANWAYS',
        'fleet_size' => 1,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '2004',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => null,
        'trading_name' => 'Albatros Airways',
        'source_url' => 'https://www.planespotters.net/airline/Albatros-Airways',
        'destinations_count' => 8,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Albatros_Airways',
        'website_url' => 'http://www.albatrosairways.info/',
        'logo_file' => null,
    ],
    [
        'name' => 'Albawings',
        'iata_code' => '2B',
        'icao_code' => 'AWT',
        'callsign' => 'ALBAWINGS',
        'fleet_size' => 6,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '2015',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => 'Albawings sh.p.k',
        'trading_name' => null,
        'source_url' => 'https://www.planespotters.net/airline/Albawings',
        'destinations_count' => 7,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Albawings',
        'website_url' => 'https://www.albawings.com/',
        'logo_file' => 'albawings.png',
    ],
    [
        'name' => 'Belle Air',
        'iata_code' => 'LZ',
        'icao_code' => 'LBY',
        'callsign' => 'ALBAN-BELLE',
        'fleet_size' => 17,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '2005',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => 'Belle Air Sh. p.k.',
        'trading_name' => null,
        'source_url' => 'https://www.planespotters.net/airline/Belle-Air',
        'destinations_count' => 24,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Belle_Air',
        'website_url' => 'http://belleair.al/en/index.php',
        'logo_file' => 'belle-air.gif',
    ],
    [
        'name' => 'Star Airways',
        'iata_code' => '4S',
        'icao_code' => 'STB',
        'callsign' => null,
        'fleet_size' => 1,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '2008',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => null,
        'trading_name' => 'Star Airways',
        'source_url' => 'https://www.planespotters.net/airline/Star-Airways',
        'destinations_count' => 4,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Star_Airways',
        'website_url' => null,
        'logo_file' => 'star-airways.png',
    ],
    [
        'name' => 'Albtransport',
        'iata_code' => null,
        'icao_code' => null,
        'callsign' => null,
        'fleet_size' => null,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '1957',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => null,
        'trading_name' => 'Albtransport',
        'source_url' => 'https://en.wikipedia.org/wiki/Albtransport',
        'destinations_count' => null,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Albtransport',
        'website_url' => null,
        'logo_file' => null,
    ],
    [
        'name' => 'Tafa Air',
        'iata_code' => null,
        'icao_code' => null,
        'callsign' => null,
        'fleet_size' => 1,
        'status_bucket' => 'defunct',
        'status' => 'defunct',
        'founded' => '2009',
        'hubs' => 'Tirana International Airport Nënë Tereza',
        'alliance' => null,
        'parent_company' => null,
        'legal_name' => null,
        'trading_name' => 'Tafa Air',
        'source_url' => 'https://en.wikipedia.org/wiki/Tafa_Air',
        'destinations_count' => null,
        'logo_url' => null,
        'wikipedia_url' => 'https://en.wikipedia.org/wiki/Tafa_Air',
        'website_url' => null,
        'logo_file' => 'Tafa_Air.svg.png',
    ],
];

log_msg("Starting Albanian airlines update...");

$db = db();
$inserted = 0;
$updated = 0;
$skipped = 0;

foreach ($airlines as $a) {
    $name = $a['name'];

    // Check if airline exists in DB
    $existing = row("SELECT id, icao_code, logo_url FROM airlines WHERE name = ?", [$name]);

    $logoPath = $a['logo_file'] ? 'assets/airline_logos/' . $a['logo_file'] : ($a['logo_url'] ?? null);

    if ($existing) {
        // Update existing
        $sql = "UPDATE airlines SET
            iata_code = COALESCE(NULLIF(?, ''), iata_code),
            icao_code = COALESCE(NULLIF(?, ''), icao_code),
            callsign = COALESCE(NULLIF(?, ''), callsign),
            fleet_size = COALESCE(?, fleet_size),
            status_bucket = COALESCE(NULLIF(?, ''), status_bucket),
            status = COALESCE(NULLIF(?, ''), status),
            founded = COALESCE(NULLIF(?, ''), founded),
            hubs = COALESCE(NULLIF(?, ''), hubs),
            alliance = COALESCE(NULLIF(?, ''), alliance),
            parent_company = COALESCE(NULLIF(?, ''), parent_company),
            legal_name = COALESCE(NULLIF(?, ''), legal_name),
            trading_name = COALESCE(NULLIF(?, ''), trading_name),
            source_url = COALESCE(NULLIF(?, ''), source_url),
            wikipedia_url = COALESCE(NULLIF(?, ''), wikipedia_url),
            website_url = COALESCE(NULLIF(?, ''), website_url),
            country_code = 'AL',
            data_source = COALESCE(data_source, 'planespotters_country_csv')
            " . ($logoPath ? ", logo_url = COALESCE(NULLIF(logo_url, ''), ?)" : "") . "
            WHERE id = ?";

        $params = [
            $a['iata_code'] ?? '',
            $a['icao_code'] ?? '',
            $a['callsign'] ?? '',
            $a['fleet_size'],
            $a['status_bucket'] ?? '',
            $a['status'] ?? '',
            $a['founded'] ?? '',
            $a['hubs'] ?? '',
            $a['alliance'] ?? '',
            $a['parent_company'] ?? '',
            $a['legal_name'] ?? '',
            $a['trading_name'] ?? '',
            $a['source_url'] ?? '',
            $a['wikipedia_url'] ?? '',
            $a['website_url'] ?? '',
        ];
        if ($logoPath) {
            $params[] = $logoPath;
        }
        $params[] = $existing['id'];

        exec_sql($sql, $params);
        log_msg("UPDATED: {$name} (id={$existing['id']})" . ($logoPath ? " + logo" : ""));
        $updated++;
    } else {
        // Insert new
        $cols = ['name', 'country_code', 'data_source'];
        $vals = [$name, 'AL', 'planespotters_country_csv'];
        $phs = ['?', '?', '?'];

        $fieldMap = [
            'iata_code', 'icao_code', 'callsign', 'fleet_size', 'status_bucket',
            'status', 'founded', 'hubs', 'alliance', 'parent_company',
            'legal_name', 'trading_name', 'source_url', 'logo_url',
            'wikipedia_url', 'website_url',
        ];
        foreach ($fieldMap as $f) {
            $v = $a[$f] ?? ($f === 'logo_url' ? $logoPath : null);
            if ($f === 'logo_url') $v = $logoPath;
            if ($v !== null && $v !== '') {
                $cols[] = $f;
                $vals[] = $v;
                $phs[] = '?';
            }
        }

        $sql = "INSERT INTO airlines (" . implode(', ', $cols) . ") VALUES (" . implode(', ', $phs) . ")";
        exec_sql($sql, $vals);
        $newId = $db->lastInsertId();
        log_msg("INSERTED: {$name} (id={$newId})" . ($logoPath ? " + logo" : ""));
        $inserted++;
    }
}

log_msg("Done! Updated: {$updated}, Inserted: {$inserted}");
