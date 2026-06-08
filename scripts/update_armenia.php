<?php
require_once __DIR__ . '/../includes/db.php';
$log=fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_armenia.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);
$db=db();
$log("=== Starting Armenia (AM) airlines update ===");

// ===== FIX: Atlantis European Airways wrongly assigned to DE instead of AM =====
$row = row("SELECT id, name, country_code FROM airlines WHERE id=548");
if ($row && $row['country_code'] === 'DE') {
    exec_sql("UPDATE airlines SET country_code='AM', iata_code='TD', icao_code='LUR', callsign=NULL, fleet_size=0, status_bucket='defunct', founded='1999', hubs='Yerevan Zvartnots International (EVN / UDYZ)', legal_name='Atlantis European Airways', trading_name='Atlantis European Airways', website_url='http://atlantis.am/', source_url='https://www.planespotters.net/airline/Atlantis-European-Airways' WHERE id=548");
    $log("FIXED: Atlantis European Airways id={$row['id']} country_code DE->AM, set TD/LUR/defunct");
}

// ===== FIX: Two "Armenian Airlines" - id=545 (old defunct M-AM-104), id=546 (new JI/AAG) =====
$old = row("SELECT id, name FROM airlines WHERE id=545 AND country_code='AM'");
if ($old) {
    exec_sql("UPDATE airlines SET fleet_size=2, status_bucket='defunct', founded=NULL, source_url='https://www.planespotters.net/airline/Armenian-Airlines' WHERE id=545");
    $log("UPDATED: Armenian Airlines (old defunct) id=545 fleet=2 status=defunct (keeping mock ICAO M-AM-104)");
}
$new = row("SELECT id, name, iata_code, icao_code FROM airlines WHERE id=546 AND country_code='AM'");
if ($new) {
    exec_sql("UPDATE airlines SET iata_code='JI', icao_code='AAG', callsign='APRICOT', fleet_size=2, status_bucket='inactive', founded='2022', hubs='Zvartnots International Airport (EVN)', source_url='https://www.planespotters.net/airline/Armenian-Airlines-2022', logo_url='assets/airline_logos/armenian-airlines.svg' WHERE id=546");
    $log("UPDATED: Armenian Airlines (current) id={$new['id']} codes JI/AAG/APRICOT fleet=2 status=inactive");
}

// ===== Bulk update remaining existing airlines by name + country_code 'AM' =====
$updates = [
    ['name'=>'Air Armenia','iata'=>'QN','icao'=>'ARR','callsign'=>'AIR ARMENIA','fleet'=>0,'bucket'=>'active','founded'=>'2003','hubs'=>'Yerevan Zvartnots International (EVN / UDYZ)','logo'=>'air-armenia.gif'],
    ['name'=>'Armenia Airways','iata'=>'6A','icao'=>'AMW','callsign'=>'ARMENIA','fleet'=>3,'bucket'=>'active','founded'=>'2013','hubs'=>'Zvartnots International Airport (EVN)','logo'=>'armenia-airways.png'],
    ['name'=>'FLYONE Armenia','iata'=>'3F','icao'=>'FIE','callsign'=>'ARMRIDER','fleet'=>5,'bucket'=>'active','founded'=>'2021','hubs'=>'Zvartnots International Airport (EVN)','logo'=>'flyone-armenia.png'],
    ['name'=>'Shirak Avia','iata'=>'5G','icao'=>'SHS','callsign'=>'SHIRAK','fleet'=>3,'bucket'=>'active','founded'=>'2019','hubs'=>'Zvartnots International Airport (EVN)','logo'=>'shirak-avia.png'],
    ['name'=>'Hayways','iata'=>'Y5','icao'=>'HYY','callsign'=>'HAYWAYS','fleet'=>1,'bucket'=>'active','founded'=>'2019','hubs'=>'Zvartnots International Airport (EVN)','logo'=>'hayways.png'],
    ['name'=>'Taron-Avia','iata'=>'H7','icao'=>'TRV','callsign'=>'TARONAVIA','fleet'=>0,'bucket'=>'defunct','founded'=>'2016','hubs'=>'Gyumri Shirak Airport (LWN / UDSG)','logo'=>'taron-avia.png'],
    ['name'=>'Veteran Avia','iata'=>'VB','icao'=>'VTF','callsign'=>'VETERAN','fleet'=>0,'bucket'=>'defunct','founded'=>'2009','hubs'=>'Yerevan Zvartnots International (EVN / UDYZ); Sharjah International (SHJ / OMSJ)','logo'=>'veteran-avia.gif'],
    ['name'=>'Vertir Airlines','iata'=>null,'icao'=>'VRZ','callsign'=>'VERTIR','fleet'=>0,'bucket'=>'defunct','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Air Dilijans','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Air Wings','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'unknown','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Air-Van','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'unknown','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Aircompany Armenia','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Ararat Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Ark Airways','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Armavia','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Armenian International Airways','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Blue Sky','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Fly Armenia Airways','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'unknown','founded'=>null,'hubs'=>'','logo'=>null],
    ['name'=>'Fly Arna','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>'2021','hubs'=>'','logo'=>null],
];

$c = ['updated'=>0, 'skipped'=>0];
foreach ($updates as $a) {
    $existing = row("SELECT id, name, fleet_size, status_bucket, logo_url FROM airlines WHERE name = ? AND country_code = 'AM'", [$a['name']]);
    if (!$existing) {
        $c['skipped']++;
        $log("SKIP (not found in DB): {$a['name']}");
        continue;
    }
    $logo = $a['logo'] ? 'assets/airline_logos/'.$a['logo'] : $existing['logo_url'];
    $sql = "UPDATE airlines SET 
        iata_code=COALESCE(NULLIF(?,''),iata_code),
        icao_code=COALESCE(NULLIF(?,''),icao_code),
        callsign=COALESCE(NULLIF(?,''),callsign),
        fleet_size=?,
        status_bucket=?,
        founded=COALESCE(NULLIF(?,''),founded),
        hubs=COALESCE(NULLIF(?,''),hubs),
        logo_url=?
        WHERE id=?";
    exec_sql($sql, [
        $a['iata']??'', $a['icao']??'', $a['callsign']??'',
        $a['fleet']!==null ? $a['fleet'] : $existing['fleet_size'],
        $a['bucket']!==null ? $a['bucket'] : $existing['status_bucket'],
        $a['founded']??'', $a['hubs']??'',
        $logo, $existing['id']
    ]);
    $c['updated']++;
    $log("UPDATED: {$a['name']} (id={$existing['id']}) -> fleet={$a['fleet']} status={$a['bucket']}");
}

// ===== INSERT missing airlines =====
$inserts = [
    ['name'=>'South Airlines','iata'=>null,'icao'=>'STH','callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'2001','hubs'=>'','logo'=>null],
    ['name'=>'Sky Net Airline','iata'=>null,'icao'=>'SKJ','callsign'=>'SKYNET AIR','fleet'=>0,'bucket'=>'defunct','founded'=>'2011','hubs'=>'Yerevan Zvartnots International (EVN)','logo'=>null],
];
foreach ($inserts as $a) {
    $dup = row("SELECT id FROM airlines WHERE name = ? AND country_code = 'AM'", [$a['name']]);
    if ($dup) {
        $log("SKIP (already exists id={$dup['id']}): {$a['name']}");
        continue;
    }
    exec_sql("INSERT INTO airlines (name, iata_code, icao_code, callsign, fleet_size, status_bucket, founded, hubs, country_code) VALUES (?,?,?,?,?,?,?,?,'AM')", [
        $a['name'], $a['iata'], $a['icao'], $a['callsign'],
        $a['fleet'], $a['bucket'], $a['founded'], $a['hubs']
    ]);
    $log("INSERTED: {$a['name']} ({$a['icao']})");
    $c['updated']++; // counting as change
}

$log("=== Done! Fixed: 2, Updated: {$c['updated']}, Skipped: {$c['skipped']} ===");
