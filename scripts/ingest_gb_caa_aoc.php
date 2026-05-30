<?php
/**
 * Ingests UK CAA AOC holders list (April 2026).
 *
 * - Matches existing GB airlines by name
 * - Updates matched airlines: active='Y'
 * - Inserts website URL into airline_digital_properties
 * - Inserts aircraft types into airline_fleet_summary
 * - Seeds regulatory_licensing_categories with UK CAA AOC definitions
 *
 * Usage: php scripts/ingest_gb_caa_aoc.php
 * Environment: ANGANI_DB_PASS must be set
 */

$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$rows = [
    ['company'=>'2 EXCEL AVIATION LIMITED', 'trading'=>'THE BLADES, BROADSWORD, SCIMITAR, SABRE and T2', 'website'=>'www.2excelaviation.com', 'aoc'=>'2299', 'fleet'=>['BEECH 200','BOEING 727-200','BOEING 737-300','BOEING 737-700','EXTRA EA300','PIPER PA31']],
    ['company'=>'247 AVIATION LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2482', 'fleet'=>['DIAMOND DA62','PILATUS PC-12','PILATUS PC-24']],
    ['company'=>'A2B HELI (CHARTERS) LIMITED', 'trading'=>'A2B AERIAL FILM', 'website'=>'www.thelondonhelicopter.com', 'aoc'=>'2441', 'fleet'=>['AIRBUS HELICOPTERS AS355']],
    ['company'=>'ACROPOLIS AVIATION LIMITED', 'trading'=>'', 'website'=>'www.acropolis-aviation.com', 'aoc'=>'2363', 'fleet'=>['AIRBUS A320-200']],
    ['company'=>'AER LINGUS (UK) LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2471', 'fleet'=>['AIRBUS A330-300']],
    ['company'=>'AIR ALDERNEY', 'trading'=>'', 'website'=>'', 'aoc'=>'', 'fleet'=>[], 'see'=>'WESSEX AVIATION LIMITED'],
    ['company'=>'AIR CAERNARFON LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2478', 'fleet'=>['ROBINSON R44']],
    ['company'=>'AIR CHARTER SCOTLAND LIMITED', 'trading'=>'', 'website'=>'www.aircharterscotland.com', 'aoc'=>'1291', 'fleet'=>['CESSNA 525A','CESSNA 680A','EMBRAER EMB135 BJ','EMBRAER EMB550']],
    ['company'=>'AIR KILROE LIMITED', 'trading'=>'EASTERN AIRWAYS', 'website'=>'www.easternairways.com', 'aoc'=>'2068', 'fleet'=>['ATR 72-212A','BAe JETSTREAM 41','EMBRAER EMB170','EMBRAER EMB190']],
    ['company'=>'AIRTANKER SERVICES LIMITED', 'trading'=>'', 'website'=>'www.airtanker.co.uk', 'aoc'=>'2388', 'fleet'=>['AIRBUS A330-200']],
    ['company'=>'AIRTASK GROUP', 'trading'=>'', 'website'=>'', 'aoc'=>'', 'fleet'=>[], 'see'=>'DIRECTFLIGHT LIMITED'],
    ['company'=>'APOLLO AIR SERVICES LIMITED', 'trading'=>'', 'website'=>'www.apolloairservices.com', 'aoc'=>'2420', 'fleet'=>['AGUSTA AW109','AIRBUS HELICOPTERS AS350']],
    ['company'=>'ASCEND AIRWAYS LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2279', 'fleet'=>['BOEING 737-800','BOEING 737-8 (MAX)']],
    ['company'=>'ASL AIRLINES UK LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2468', 'fleet'=>['ATR 72-200','BOEING 737-82R']],
    ['company'=>'ATLAS HELICOPTERS LTD', 'trading'=>'', 'website'=>'www.atlashelicopters.co.uk', 'aoc'=>'2201', 'fleet'=>['AIRBUS HELICOPTERS AS355','LEONARDO AW109']],
    ['company'=>'AURIGNY AIR SERVICES LTD', 'trading'=>'', 'website'=>'www.aurigny.com', 'aoc'=>'0373', 'fleet'=>['ATR 72-200','DORNIER DO228-200','EMBRAER ERJ190-1000']],
    ['company'=>'BA CITYFLYER LIMITED', 'trading'=>'', 'website'=>'www.ba.com', 'aoc'=>'2314', 'fleet'=>['EMBRAER ERJ190-100']],
    ['company'=>'BA EUROFLYER LIMITED', 'trading'=>'BRITISH AIRWAYS', 'website'=>'', 'aoc'=>'2488', 'fleet'=>['AIRBUS A320-200','AIRBUS A321-200']],
    ['company'=>'BABCOCK MISSION CRITICAL SERVICES ONSHORE LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2153', 'fleet'=>['AIRBUS HELICOPTERS EC135','AIRBUS HELICOPTERS BK117']],
    ['company'=>'BAE SYSTEMS (CORPORATE AIR TRAVEL) LIMITED', 'trading'=>'', 'website'=>'www.baesystems.com', 'aoc'=>'2171', 'fleet'=>['BOEING 737-800','EMBRAER EMB135','EMBRAER EMB145']],
    ['company'=>'BLISS AVIATION LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2446', 'fleet'=>['ROBINSON R44','AIRBUS HELICOPTER EC120B']],
    ['company'=>'BOOKAJET LIMITED', 'trading'=>'', 'website'=>'www.bookajet.com', 'aoc'=>'2026', 'fleet'=>['HONDAJET HA-420']],
    ['company'=>'BOULTBEE FLIGHT ACADEMY LIMITED', 'trading'=>'SPITFIRES.COM', 'website'=>'', 'aoc'=>'2490', 'fleet'=>['GIPPSAERO GA8']],
    ['company'=>'BRISTOW HELICOPTERS LIMITED', 'trading'=>'', 'website'=>'www.bristowgroup.com', 'aoc'=>'0253', 'fleet'=>['LEONARDO AW139','LEONARDO AW189','SIKORSKY S92A']],
    ['company'=>'BRITISH AIRWAYS PLC', 'trading'=>'', 'website'=>'www.ba.com', 'aoc'=>'0441', 'fleet'=>['AIRBUS A319-100','AIRBUS A320-200','AIRBUS A321-200','AIRBUS A350-1000','AIRBUS A380-800','BOEING 777-200','BOEING 777-300','BOEING 787-8','BOEING 787-9']],
    ['company'=>'CAPITAL AIR SERVICES LIMITED', 'trading'=>'', 'website'=>'www.capitalairservices.co.uk', 'aoc'=>'2049', 'fleet'=>['AIRBUS HELICOPTERS EC135','AIRBUS HELICOPTERS BK117']],
    ['company'=>'CARDINAL HELICOPTER SERVICES LIMITED', 'trading'=>'', 'website'=>'www.cardinal.im', 'aoc'=>'2428', 'fleet'=>['SIKORSKY S76','SIKORSKY SK76']],
    ['company'=>'CASTLE AIR LIMITED', 'trading'=>'', 'website'=>'www.castleair.co.uk', 'aoc'=>'0912', 'fleet'=>['AIRBUS HELICOPTER BK117','AIRBUS HELICOPTERS EC135','LEONARDO AW109','LEONARDO AW139','LEONARDO AW169']],
    ['company'=>'CATREUS AOC LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2400', 'fleet'=>['CESSNA 525','BOMBARDIER BD-700-1A10']],
    ['company'=>'CENTRELINE AV LIMITED', 'trading'=>'CENTRELINE', 'website'=>'www.centreline.co.uk', 'aoc'=>'1311', 'fleet'=>['DASSAULT FALCON 7X','DASSAULT FALCON 900LX']],
    ['company'=>'CHC SCOTIA LIMITED', 'trading'=>'', 'website'=>'www.chc.ca', 'aoc'=>'0465', 'fleet'=>['AIRBUS HELICOPTERS EC175','LEONARDO AW139','SIKORSKY S92']],
    ['company'=>'CHESHIRE FLYING SERVICES LIMITED', 'trading'=>'RAVENAIR', 'website'=>'www.ravenair.co.uk', 'aoc'=>'1071', 'fleet'=>['PARTENAVIA P68','PILATUS PC-12','PIPER PA34']],
    ['company'=>'CIRRUS AVIATION LIMITED', 'trading'=>'CLASSIC WINGS', 'website'=>'www.classic-wings.co.uk', 'aoc'=>'2158', 'fleet'=>['CESSNA 172','DE HAVILLAND DH89']],
    ['company'=>'CONCIERGE U LIMITED', 'trading'=>'JET CONCIERGE CLUB', 'website'=>'', 'aoc'=>'2447', 'fleet'=>['BOMBARDIER BD-100-1A-10','BOMBARDIER BD-100-1A-11','BOMBARDIER BD-100-2A-12','DASSULT FALCON 7X','GULFSTREAM GV']],
    ['company'=>'CUTTING EDGE HELICOPTERS LIMITED', 'trading'=>'CUTTING EDGE HELICOPTERS', 'website'=>'', 'aoc'=>'2401', 'fleet'=>['AIRBUS HELICOPTERS AS350','AIRBUS HELICOPTERS EC130','ROBINSON R44']],
    ['company'=>'DEA AVIATION LIMITED', 'trading'=>'DEA AVIATION', 'website'=>'www.dea.aero', 'aoc'=>'2339', 'fleet'=>['BEECH 90','DIAMOND DA42']],
    ['company'=>'DEVELOPING ASSETS (UK) LIMITED', 'trading'=>'HELIOPERATIONS', 'website'=>'', 'aoc'=>'2479', 'fleet'=>['LEONARDO AW139']],
    ['company'=>'DEVON AIR AMBULANCE TRADING COMPANY LIMITED', 'trading'=>'', 'website'=>'www.daat.org', 'aoc'=>'2421', 'fleet'=>['AIRBUS HELICOPTERS BK117','AIRBUS HELICOPTER EC135']],
    ['company'=>'DHL AIR (UK) LIMITED', 'trading'=>'', 'website'=>'www.dhl.com', 'aoc'=>'2176', 'fleet'=>['BOEING 757-200','BOEING 767-300','BOEING 777-200F']],
    ['company'=>'DIRECTFLIGHT LIMITED', 'trading'=>'AIRTASK GROUP', 'website'=>'www.directflight.co.uk', 'aoc'=>'1060', 'fleet'=>['BAe 146','BRITTEN NORMAN BN2A/B','CESSNA F406']],
    ['company'=>'DOWNLOCK LIMITED', 'trading'=>'', 'website'=>'www.flyaspitfire.com', 'aoc'=>'2450', 'fleet'=>['PIPER PA32R-301']],
    ['company'=>'DRAGONFLY AVIATION SERVICES LIMITED', 'trading'=>'DRAGONFLY EXECUTIVE AIR CHARTER', 'website'=>'www.dragonflyac.com', 'aoc'=>'2431', 'fleet'=>['BEECH 200']],
    ['company'=>'E.B.G. (HELICOPTERS) LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2163', 'fleet'=>['ROBINSON R44']],
    ['company'=>'EASYJET UK LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2448', 'fleet'=>['AIRBUS A319-100','AIRBUS A320-200','AIRBUS A321-200']],
    ['company'=>'ELEVATE AIR LIMITED', 'trading'=>'ELEVATE AIR', 'website'=>'', 'aoc'=>'2492', 'fleet'=>['DIAMOND DA62']],
    ['company'=>'EMERALD AIRLINES UK LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2487', 'fleet'=>['ATR 72-212A']],
    ['company'=>'ESSEX & HERTS AIR AMBULANCE TRUST', 'trading'=>'', 'website'=>'https://ehata.org', 'aoc'=>'2504', 'fleet'=>['LEONARDO AW169']],
    ['company'=>'EUROPEAN CARGO LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2473', 'fleet'=>['AIRBUS A340-600']],
    ['company'=>'EXECUTIVE JET CHARTER LIMITED', 'trading'=>'', 'website'=>'www.execjet.co.uk', 'aoc'=>'2043', 'fleet'=>['AGUSTA WESTLAND AW139','DASSAULT FALCON 7X','GULFSTREAM GIV','GULFSTREAM GVI']],
    ['company'=>'FLEXJET OPERATIONS LIMITED', 'trading'=>'FLEXJET OPERATIONS AND FLEXJET HELICOPTERS', 'website'=>'', 'aoc'=>'2369', 'fleet'=>['EMBRAER EMB550','LEONARDO AW139','SIKORSKY S-76C','SIKORSKY S-92A']],
    ['company'=>'FR AVIATION LIMITED', 'trading'=>'DRAKEN EUROPE', 'website'=>'www.fraviation.com', 'aoc'=>'1000', 'fleet'=>['DASSAULT FALCON 2000']],
    ['company'=>'GAMA AVIATION (UK) LIMITED', 'trading'=>'', 'website'=>'www.gamaaviation.com', 'aoc'=>'1068', 'fleet'=>['AIRBUS HELICOPTERS BK117','BEECH 200','CANADAIER CL600-2B16','LEONARDO AW139','LEONARDO AW169']],
    ['company'=>'HAVERFORDWEST AIR CHARTER SERVICES LIMITED', 'trading'=>'FLYWALES', 'website'=>'www.flywales.co.uk', 'aoc'=>'2273', 'fleet'=>['BEECH 200','CESSNA 525']],
    ['company'=>'HELI AIR LIMITED', 'trading'=>'', 'website'=>'www.heliair.com', 'aoc'=>'2407', 'fleet'=>['ROBINSON R44']],
    ['company'=>'HELI AIR LIMITED', 'trading'=>'HELI AIR OR ESCAPE TIME', 'website'=>'www.heliair.com', 'aoc'=>'2197', 'fleet'=>['BELL 206','PIPER PA-46-600TP (M600)','ROBINSON R44','ROBINSON R66']],
    ['company'=>'HELICENTRE AVIATION LIMITED', 'trading'=>'', 'website'=>'www.flyheli.co.uk', 'aoc'=>'2236', 'fleet'=>['ROBINSON R44']],
    ['company'=>'HELIFLIGHT AOC LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2346', 'fleet'=>['AIRBUS HELICOPTERS AS350','AIRBUS HELICOPTERS AS355','BELL 206','ROBINSON R44']],
    ['company'=>'HELISERVICE U.K. LIMITED', 'trading'=>'HELISERVICE', 'website'=>'www.heliservice.uk', 'aoc'=>'2497', 'fleet'=>['LEONARDO AW169']],
    ['company'=>'IAS MEDICAL LIMITED', 'trading'=>'', 'website'=>'www.iasmedical.com', 'aoc'=>'2392', 'fleet'=>['BEECH 200','DIAMOND DA62']],
    ['company'=>'ISLES OF SCILLY SKYBUS LIMITED', 'trading'=>'', 'website'=>'www.ios-travel.co.uk/air', 'aoc'=>'1086', 'fleet'=>['BRITTEN NORMAN BN2A/B','DE HAVILLAND DHC6']],
    ['company'=>'JET2.COM LIMITED', 'trading'=>'', 'website'=>'www.jet2.com', 'aoc'=>'0598', 'fleet'=>['AIRBUS A321-200','BOEING 737-300','BOEING 737-800']],
    ['company'=>'JETFLY AVIATION UK LIMITED', 'trading'=>'JETFLY UK', 'website'=>'www.Jetfly.com', 'aoc'=>'2500', 'fleet'=>['Pilatus PC-12/47E']],
    ['company'=>'KINGMOOR AVIATION LIMITED', 'trading'=>'HELICENTRE LIVERPOOL', 'website'=>'', 'aoc'=>'2208', 'fleet'=>['AIRBUS HELICOPTERS AS350','AIRBUS HELICOPTERS AS355N','ROBINSON R44']],
    ['company'=>'LOGANAIR LTD', 'trading'=>'', 'website'=>'www.loganair.co.uk', 'aoc'=>'2105', 'fleet'=>['ATR 42-500','ATR 42-600','ATR 72-212A','ATR 72-212A \'600\' VERSION','BRITTEN NORMAN BN2A/BN2B','DE HAVILLAND DHC6','EMBRAER EMB135','EMBRAER EMB145']],
    ['company'=>'LONDON EXECUTIVE AVIATION LIMITED', 'trading'=>'LUXAVIATION UNITED KINGDOM', 'website'=>'www.flylea.com', 'aoc'=>'2070', 'fleet'=>['BOMBARDIER BD-700-1A10','BOMBARDIER CL600-2B16','CESNA 560','DASSAULT FALCON 2000EX','EMBRAER EMB135 BJ','EMBRAER EMB505','EMBRAER EMB550']],
    ['company'=>'LONDON\'S AIR AMBULANCE LIMITED', 'trading'=>'', 'website'=>'www.londonsairambulance.org.uk', 'aoc'=>'1318', 'fleet'=>['AIRBUS HELICOPTERS EC135','MD902']],
    ['company'=>'LOOPORDER LIMITED', 'trading'=>'EAST MIDLANDS HELICOPTERS', 'website'=>'www.helicopter-services.co.uk', 'aoc'=>'1207', 'fleet'=>['BELL 206','LEONARDO AW109']],
    ['company'=>'OFFSHORE HELICOPTER SERVICES UK LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2243', 'fleet'=>['AGUSTA AW139','AIRBUS HELICOPTERS EC175','LEONARDO AW139','SIKORSKY S-92A']],
    ['company'=>'ONE AIR LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2485', 'fleet'=>['BOEING 747-400']],
    ['company'=>'ORIENS FLIGHT OPERATIONS LIMITED', 'trading'=>'ORIENS AVIATION', 'website'=>'', 'aoc'=>'2480', 'fleet'=>['PILATUS PC-12NGX']],
    ['company'=>'PLM DOLLAR GROUP LIMITED', 'trading'=>'PDG HELICOPTERS OR PDG AVIATION SERVICES', 'website'=>'www.pdg-helicopters.co.uk', 'aoc'=>'2071', 'fleet'=>['AIRBUS HELICOPTERS AS350','AIRBUS HELICOPTERS AS355','AIRBUS HELICOPTERS EC135','AIRBUS HELICOPTERS SA365']],
    ['company'=>'REGENCY JET LIMITED', 'trading'=>'', 'website'=>'www.thelittlejetcompany.com', 'aoc'=>'2463', 'fleet'=>['BEECHCRAFT B350','CESSNA 550','PILATUS PC-24']],
    ['company'=>'RVL AVIATION LIMITED', 'trading'=>'', 'website'=>'www.rvl-group.com', 'aoc'=>'0540', 'fleet'=>['BEECH 200','CESSNA F406']],
    ['company'=>'RYANAIR UK LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2451', 'fleet'=>['BOEING 737-800','BOEING 737-8200']],
    ['company'=>'TAG AVIATION (UK) LIMITED', 'trading'=>'', 'website'=>'www.tagaviation.com', 'aoc'=>'2131', 'fleet'=>['BOMBARDIER BD-700-1A10','FALCON 6X','PILATUS PC-24']],
    ['company'=>'THAMES VALLEY AIR AMBULANCE', 'trading'=>'', 'website'=>'', 'aoc'=>'2489', 'fleet'=>['AIRBUS HELICOPTERS EC135 T2+']],
    ['company'=>'TITAN AIRWAYS LIMITED', 'trading'=>'', 'website'=>'www.titan-airways.com', 'aoc'=>'1212', 'fleet'=>['AIRBUS A320-200','AIRBUS A321-200','AIRBUS A321-200N','AIRBUS A321-211','AIRBUS A330-300','EMBRAER E190']],
    ['company'=>'TUI AIRWAYS LIMITED', 'trading'=>'TUI', 'website'=>'www.tui.com', 'aoc'=>'0294', 'fleet'=>['BOEING 737-800','BOEING 737-8','BOEING 787-8','BOEING 787-9']],
    ['company'=>'UN PIED SUR TERRE LIMITED', 'trading'=>'WHIZZARD HELICOPTERS', 'website'=>'www.whizzardhelicopters.co.uk', 'aoc'=>'2284', 'fleet'=>['ROBINSON R44']],
    ['company'=>'UNI-FLY HELIWORX LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2486', 'fleet'=>['LEONARDO HELICOPTERS AW139','LEONARDO HELICOPTERS AW169']],
    ['company'=>'V21 LIMITED', 'trading'=>'HELICOPTER SERVICES', 'website'=>'www.helicopterservices.co.uk', 'aoc'=>'2128', 'fleet'=>['BELL 206','EUROCOPTER AS355','ROBINSON R44']],
    ['company'=>'VIRGIN ATLANTIC AIRWAYS LIMITED', 'trading'=>'', 'website'=>'www.virgin-atlantic.com', 'aoc'=>'0534', 'fleet'=>['AIRBUS A330-300','AIRBUS A330-900','AIRBUS A350-1000','BOEING 787-9']],
    ['company'=>'VIRGIN ATLANTIC INTERNATIONAL LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2435', 'fleet'=>['AIRBUS A330-300','AIRBUS A330-900']],
    ['company'=>'VLL LIMITED', 'trading'=>'GB HELICOPTERS', 'website'=>'', 'aoc'=>'2312', 'fleet'=>['AIRBUS HELICOPTERS AW350','AIRBUS HELICOPTERS AS355','AIRBUS HELICOPTERS EC130','AIRBUS HELICOPTERS EC155','BELL 429','LEONARDO AW109']],
    ['company'=>'VOLUXIS LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'0851', 'fleet'=>['BOMBARDIER BD-700-1A10','EMBRAER EMB5550']],
    ['company'=>'WESSEX AVIATION', 'trading'=>'AIR ALDERNEY', 'website'=>'', 'aoc'=>'2446', 'fleet'=>['BN2N-26 ISLANDER']],
    ['company'=>'WEST ATLANTIC UK LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2290', 'fleet'=>['ATR 72-200','BOEING 737-400','BOEING 737-800']],
    ['company'=>'WILTSHIRE AND BATH AIR AMBULANCE CHARITY', 'trading'=>'', 'website'=>'', 'aoc'=>'2454', 'fleet'=>['BELL 429']],
    ['company'=>'WIZZ AIR UK LIMITED', 'trading'=>'WIZZ AIR UK', 'website'=>'www.wizzair.com', 'aoc'=>'2449', 'fleet'=>['AIRBUS A321-200']],
    ['company'=>'WOODGATE AVIATION (NI) LIMITED', 'trading'=>'', 'website'=>'www.woodair.com', 'aoc'=>'2378', 'fleet'=>['BEECH 200','PIPER PA31']],
    ['company'=>'YORKSHIRE AIR AMBULANCE LIMITED', 'trading'=>'', 'website'=>'www.yaa.org.uk', 'aoc'=>'2398', 'fleet'=>['AIRBUS HELICOPTERS BK117']],
    ['company'=>'ZENITH AVIATION LIMITED', 'trading'=>'', 'website'=>'', 'aoc'=>'2390', 'fleet'=>['LEARJET 40','LEARJET 75']],
];

function cleanName(string $name): string {
    $name = preg_replace('/\s*LIMITED\s*$/i', '', $name);
    $name = preg_replace('/\s*LTD\s*$/i', '', $name);
    $name = preg_replace('/\s*PLC\s*$/i', '', $name);
    $name = preg_replace('/\s*\(UK\)\s*$/i', '', $name);
    $name = preg_replace('/\s*\(CORPORATE AIR TRAVEL\)\s*$/i', '', $name);
    $name = preg_replace('/\s*\(CHARTERS\)\s*/i', '', $name);
    $name = preg_replace('/\s*\(HELICOPTERS\)\s*/i', '', $name);
    $name = preg_replace('/\bS\.?r\.?l\.?\b/i', '', $name);
    $name = preg_replace('/\bS\.?p\.?A\.?\b/i', '', $name);
    $name = preg_replace('/[",.]/', '', $name);
    $name = preg_replace('/\s+/', ' ', $name);
    return trim(strtolower($name));
}

function namesMatch(string $caaName, string $dbName): bool {
    $a = cleanName($caaName);
    $b = cleanName($dbName);
    if (!$a || !$b) return false;
    if ($a === $b) return true;
    // Remove common aviation stopwords and retry
    $stopwords = ['air', 'airways', 'aviation', 'airlines', 'services', 'helicopter', 'helicopters', 'flight', 'fly', 'aero', 'limited', 'ltd', 'plc', 'international', 'group', 'company'];
    $wa = array_diff(explode(' ', $a), $stopwords);
    $wb = array_diff(explode(' ', $b), $stopwords);
    return implode(' ', $wa) === implode(' ', $wb);
}

function upsertFleet(PDO $db, string $icao, string $aircraftType): void {
    $exists = $db->prepare("SELECT id FROM airline_fleet_summary WHERE icao_code=? AND aircraft_type=?");
    $exists->execute([$icao, $aircraftType]);
    if ($exists->fetch()) return;
    $db->prepare("INSERT INTO airline_fleet_summary (country_code, icao_code, aircraft_type) VALUES ('GB', ?, ?)")
        ->execute([$icao, $aircraftType]);
}

function upsertDigitalProperty(PDO $db, string $icao, string $name, string $category, string $platform, string $value): void {
    if (!$value) return;
    $exists = $db->prepare("SELECT id FROM airline_digital_properties WHERE icao_code=? AND category=? AND platform=? AND url_or_handle=?");
    $exists->execute([$icao, $category, $platform, $value]);
    if ($exists->fetch()) return;
    $db->prepare("INSERT INTO airline_digital_properties (country_code, icao_code, airline_name, category, platform, url_or_handle, is_primary)
        VALUES ('GB', ?, ?, ?, ?, ?, 1)")->execute([$icao, $name, $category, $platform, $value]);
}

$updated = 0;
$matched = 0;
$fleetInserted = 0;
$digitalInserted = 0;
$skipped = 0;

echo "Processing " . count($rows) . " UK AOC holders...\n\n";

foreach ($rows as $r) {
    $companyName = $r['company'];
    $website = $r['website'];
    $fleet = $r['fleet'] ?? [];
    $see = $r['see'] ?? null;

    if ($see) {
        echo "  ↪ '{$companyName}' → see '{$see}' — skipping\n";
        continue;
    }

    // Helper: query GB airlines
    $gbAirlines = function() use ($db) {
        $s = $db->prepare("SELECT icao_code, name, active FROM airlines WHERE country_code='GB'");
        $s->execute();
        return $s;
    };

    // Try name matching against all GB airlines
    $matchedAirline = null;
    $matchLabel = '';
    foreach ($gbAirlines() as $a) {
        if (namesMatch($companyName, $a['name'])) {
            $matchedAirline = $a;
            break;
        }
    }

    // Try matching by trading name as fallback
    $trading = $r['trading'] ?? '';
    if (!$matchedAirline && $trading) {
        foreach ($gbAirlines() as $a) {
            if (namesMatch($trading, $a['name'])) {
                $matchedAirline = $a;
                $matchLabel = " (matched via trading name '{$trading}')";
                break;
            }
        }
    }

    if ($matchedAirline) {
        $icao = $matchedAirline['icao_code'];
        $label = $matchLabel;
        if ($matchedAirline['active'] !== 'Y') {
            $db->prepare("UPDATE airlines SET active='Y', updated_at=NOW() WHERE icao_code=?")
                ->execute([$icao]);
            echo "  ✓ Updated {$icao}: active=Y{$label}\n";
            $updated++;
        } else {
            echo "  • {$icao}: already active{$label}\n";
        }
        $matched++;

        if ($website) {
            upsertDigitalProperty($db, $icao, $companyName, 'Contact', 'Website', 'https://' . $website);
            $digitalInserted++;
        }
        foreach ($fleet as $ac) {
            upsertFleet($db, $icao, $ac);
            $fleetInserted++;
        }
    } else {
        echo "  ⚠ No match found for '{$companyName}'\n";
        $skipped++;
    }
}

echo "\n--- Updating UK AOC licensing categories ---\n";
$db->prepare("DELETE FROM regulatory_licensing_categories WHERE iso_country='GB'")->execute();

$licenses = [
    ['iso_country'=>'GB', 'category'=>'AOC', 'name'=>'Fixed-Wing (Category A)', 'validity'=>'Standard', 'cost'=>'', 'requirements'=>'Aeroplanes — passenger, cargo, or combined operations', 'description'=>'Full AOC for fixed-wing aircraft operations, including scheduled and non-scheduled flights.'],
    ['iso_country'=>'GB', 'category'=>'AOC', 'name'=>'Helicopter (Category H)', 'validity'=>'Standard', 'cost'=>'', 'requirements'=>'Helicopters — passenger, cargo, or specialised operations', 'description'=>'Full AOC for helicopter operations, including offshore, EMS, and charter flights.'],
    ['iso_country'=>'GB', 'category'=>'AOC', 'name'=>'Cargo Only', 'validity'=>'Standard', 'cost'=>'', 'requirements'=>'Limited to cargo-only operations', 'description'=>'AOC restricted to cargo and mail carriage only, no passengers.'],
    ['iso_country'=>'GB', 'category'=>'AOC', 'name'=>'Aerial Work / Specialised', 'validity'=>'Standard', 'cost'=>'', 'requirements'=>'Aerial work, survey, ambulance, or other specialised ops', 'description'=>'AOC for non-transport specialised operations including air ambulance, survey, and filming.'],
    ['iso_country'=>'GB', 'category'=>'AOC', 'name'=>'Seasonal / Limited Period', 'validity'=>'Seasonal', 'cost'=>'', 'requirements'=>'Summer-only or limited-period pleasure flight operations', 'description'=>'AOC valid only during a limited period each year (typically summer pleasure flights).'],
];
$insLic = $db->prepare("INSERT INTO regulatory_licensing_categories (iso_country, category, name, validity, cost, requirements, description) VALUES (?,?,?,?,?,?,?)");
foreach ($licenses as $l) {
    $insLic->execute([$l['iso_country'], $l['category'], $l['name'], $l['validity'], $l['cost'], $l['requirements'], $l['description']]);
    echo "  + Added licensing category: {$l['name']}\n";
}

echo "\n--- Summary ---\n";
echo "Total AOC holders: " . count($rows) . "\n";
echo "Airlines updated (active=Y): $updated\n";
echo "Airlines matched (total): $matched\n";
echo "Fleet entries inserted: $fleetInserted\n";
echo "Digital properties inserted: $digitalInserted\n";
echo "No match found: $skipped\n";
echo "\nDone.\n";