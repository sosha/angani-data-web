<?php
require_once __DIR__ . '/../includes/db.php';
$log=fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_afghanistan.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);
$db=db();

$log("=== Starting Afghanistan (AF) airlines update ===");

// Fix: Kam Air (id=443) was incorrectly assigned country_code='US' in initial ingestion
$kam = row("SELECT id, name, country_code FROM airlines WHERE name = 'Kam Air' AND country_code = 'US'");
if ($kam) {
    exec_sql("UPDATE airlines SET country_code='AF', fleet_size=13, status_bucket='active', founded='2003', callsign='KAMGAR', hubs='Kabul International Airport (Kabul); Mazar-i-Sharif International Airport (Mazar-i-Sharif)', legal_name='Kam Air', trading_name='Kam Air', website_url='https://www.kamair.com', source_url='https://www.planespotters.net/airline/Kam-Air', logo_url='assets/airline_logos/kam-air.png' WHERE id=?", [$kam['id']]);
    $log("FIXED: Kam Air id={$kam['id']} country_code US->AF, updated fleet=13 status=active");
}

$airlines = [
    ['name'=>'Ariana Afghan Airlines','iata'=>'FG','icao'=>'AFG','callsign'=>'ARIANA','fleet'=>6,'bucket'=>'active','founded'=>'1955','hubs'=>'Kabul International Airport (Kabul); Kandahar International Airport (Kandahar)','legal'=>'Ariana Afghan Airlines Co. Ltd.','trading'=>'Ariana','web'=>'http://www.flyariana.com','src'=>'https://en.wikipedia.org/wiki/Ariana_Afghan_Airlines','logo'=>'ariana-afghan-airlines.png'],
    ['name'=>'Kam Air','iata'=>'RQ','icao'=>'KMF','callsign'=>'KAMGAR','fleet'=>13,'bucket'=>'active','founded'=>'2003','hubs'=>'Kabul International Airport (Kabul); Mazar-i-Sharif International Airport (Mazar-i-Sharif)','legal'=>'Kam Air','trading'=>'Kam Air','web'=>'https://www.kamair.com','src'=>'https://www.planespotters.net/airline/Kam-Air','logo'=>'kam-air.png'],
    ['name'=>'Bakhtar Afghan Airlines (2020)','iata'=>'BM','icao'=>'BFO','callsign'=>'BAKHTAR','fleet'=>1,'bucket'=>'defunct','founded'=>'2020','hubs'=>'Kabul International Airport (Kabul)','legal'=>'Bakhtar Afghan Airlines','trading'=>'Bakhtar Afghan Airlines','web'=>'https://bakhtarairline.com','src'=>'https://www.planespotters.net/airline/Bakhtar-Afghan-Airlines-2020','logo'=>'bakhtar-afghan-airlines-2020.png'],
    ['name'=>'East Horizon Airlines','iata'=>'EA','icao'=>'EHN','callsign'=>'EAST HORIZON','fleet'=>3,'bucket'=>'defunct','founded'=>'2013','hubs'=>'Herat International Airport (Herat); Kabul International Airport (Kabul)','legal'=>'East Horizon Airlines','trading'=>'East Horizon Airlines','web'=>'http://flyeasthorizon.com','src'=>'https://www.planespotters.net/airline/East-Horizon-Airlines','logo'=>'east-horizon-airlines.png'],
    ['name'=>'Safi Airways','iata'=>'4Q','icao'=>'SFW','callsign'=>'SAFI AIRWAYS','fleet'=>0,'bucket'=>'defunct','founded'=>'2006','hubs'=>'Kabul International Airport (Kabul)','legal'=>'Safi Airways','trading'=>'Safi Airways','web'=>'http://www.safiairways.com','src'=>'https://www.planespotters.net/airline/Safi-Airways','logo'=>'safi-airways.png'],
    ['name'=>'Pamir Airways','iata'=>'NR','icao'=>'PIR','callsign'=>'PAMIR','fleet'=>5,'bucket'=>'defunct','founded'=>'1995','hubs'=>'Kabul International Airport (Kabul)','legal'=>'Pamir Airways','trading'=>'Pamir Airways','web'=>'http://www.pamirairways.af','src'=>'https://www.planespotters.net/airline/Pamir-Airways','logo'=>'pamir-airways.png'],
    ['name'=>'Bakhtar Afghan Airlines (1985-1988)','iata'=>'BJ','icao'=>'BYJ','callsign'=>'BAKHTAR','fleet'=>0,'bucket'=>'defunct','founded'=>'1985','hubs'=>'Kabul International Airport (Kabul)','legal'=>'Bakhtar Afghan Airlines','trading'=>'Bakhtar Afghan Airlines','web'=>'','src'=>'https://en.wikipedia.org/wiki/Bakhtar_Afghan_Airlines','logo'=>null],
    ['name'=>'Bakhtar Airlines (1967-1985)','iata'=>'BJ','icao'=>'BYJ','callsign'=>'BAKHTAR','fleet'=>0,'bucket'=>'defunct','founded'=>'1967','hubs'=>'Kabul International Airport (Kabul)','legal'=>'Bakhtar Airlines','trading'=>'Bakhtar Airlines','web'=>'','src'=>'https://en.wikipedia.org/wiki/Bakhtar_Afghan_Airlines','logo'=>null],
    ['name'=>'Khyber Afghan Airlines','iata'=>null,'icao'=>'KHY','callsign'=>'KHYBER','fleet'=>0,'bucket'=>'defunct','founded'=>'2001','hubs'=>'Jalalabad Airport (Jalalabad)','legal'=>'Khyber Afghan Airlines','trading'=>'Khyber Afghan Airlines','web'=>'','src'=>'https://en.wikipedia.org/wiki/Khyber_Afghan_Airlines','logo'=>null],
    ['name'=>'Afghan Jet International','iata'=>'HN','icao'=>'AJA','callsign'=>'AFGHAN JET','fleet'=>2,'bucket'=>'defunct','founded'=>'2014','hubs'=>'Kabul International Airport (Kabul)','legal'=>'Afghan Jet International Airlines','trading'=>'Afghan Jet International','web'=>'http://www.flyaji.com','src'=>'https://www.planespotters.net/airline/Afghan-Jet-International','logo'=>null],
    ['name'=>'Balkh Airlines','iata'=>null,'icao'=>'BHI','callsign'=>'SHARIF','fleet'=>1,'bucket'=>'defunct','founded'=>'1996','hubs'=>'Mazari Sharif Airport (Mazar-i-Sharif)','legal'=>'Balkh Airlines','trading'=>'Balkh Airlines','web'=>'','src'=>'https://en.wikipedia.org/wiki/Balkh_Airlines','logo'=>null],
    ['name'=>'Bamiyan Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'1997','hubs'=>'','legal'=>'Bamiyan Airlines','trading'=>'Bamiyan Airlines','web'=>'','src'=>'https://en.wikipedia.org/wiki/List_of_defunct_airlines_of_Afghanistan','logo'=>null],
    ['name'=>'Kabul Air','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'2007','hubs'=>'Kabul International Airport (Kabul)','legal'=>'Kabul Air','trading'=>'Kabul Air','web'=>'','src'=>'https://en.wikipedia.org/wiki/List_of_defunct_airlines_of_Afghanistan','logo'=>null],
    ['name'=>'MarcoPolo Airways','iata'=>null,'icao'=>'MCP','callsign'=>'MARCOPOLO','fleet'=>0,'bucket'=>'defunct','founded'=>'2003','hubs'=>'Kabul International Airport (Kabul)','legal'=>'MarcoPolo Airways','trading'=>'MarcoPolo Airways','web'=>'','src'=>'https://en.wikipedia.org/wiki/List_of_defunct_airlines_of_Afghanistan','logo'=>null],
    ['name'=>'Photros Air','iata'=>null,'icao'=>'KHP','callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'2006','hubs'=>'','legal'=>'Photros Air','trading'=>'Photros Air','web'=>'','src'=>'https://en.wikipedia.org/wiki/List_of_defunct_airlines_of_Afghanistan','logo'=>null],
];

$inserted = 0;
$updated = 0;
$skipped = 0;

foreach ($airlines as $a) {
    // Check if already exists by name + country code
    $existing = row("SELECT id, iata_code, icao_code, fleet_size, logo_url FROM airlines WHERE name = ? AND country_code = 'AF'", [$a['name']]);
    if ($existing) {
        $log("SKIP (already exists, id={$existing['id']}): {$a['name']}");
        $skipped++;
        continue;
    }
    // Also check by IATA or ICAO to avoid conflicts
    if ($a['iata'] && $a['icao']) {
        $dup = row("SELECT id, name FROM airlines WHERE (iata_code = ? OR icao_code = ?) AND country_code = 'AF'", [$a['iata'], $a['icao']]);
        if ($dup) {
            $log("SKIP (duplicate code, exists id={$dup['id']}): {$a['name']} matches existing {$dup['name']}");
            $skipped++;
            continue;
        }
    }
    if ($a['icao'] && strlen($a['icao']) == 3) {
        $dup = row("SELECT id, name FROM airlines WHERE icao_code = ? AND name LIKE ?", [$a['icao'], '%'.$a['name'].'%']);
        if ($dup) {
            $log("SKIP (similar match, exists id={$dup['id']}): {$a['name']} matches {$dup['name']}");
            $skipped++;
            continue;
        }
    }
    $logo = $a['logo'] ? 'assets/airline_logos/'.$a['logo'] : null;
    exec_sql("INSERT INTO airlines (name, iata_code, icao_code, callsign, fleet_size, status_bucket, founded, hubs, legal_name, trading_name, website_url, source_url, logo_url, country_code) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,'AF')", [
        $a['name'], $a['iata'], $a['icao'], $a['callsign'],
        $a['fleet'], $a['bucket'], $a['founded'], $a['hubs'],
        $a['legal'], $a['trading'], $a['web'], $a['src'], $logo
    ]);
    $inserted++;
    $log("INSERTED: {$a['name']} ({$a['iata']}/{$a['icao']}) fleet={$a['fleet']} status={$a['bucket']} logo=$logo");
}

$log("=== Done! Inserted: $inserted, Updated: $updated, Skipped: $skipped ===");
