<?php
require_once __DIR__ . '/../includes/db.php';
$log=fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_aruba.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);
$db=db();
$log("=== Starting Aruba (AW) airlines update ===");

// ===== FIX: Sunair id=809 wrongly assigned to EG instead of AW =====
$r = row("SELECT id, name, country_code FROM airlines WHERE id=809");
if ($r && $r['country_code'] === 'EG') {
    exec_sql("UPDATE airlines SET country_code='AW', icao_code=NULL, status_bucket='unknown', fleet_size=0, founded=NULL, source_url='https://www.planespotters.net/airline/Sunair-Aruba' WHERE id=809");
    $log("FIXED: Sunair id=809 country_code EG->AW, reset mock ICAO");
}

// ===== Airlines with real codes & fleet data from saved planespotters pages =====
$updates = [
    ['id'=>800, 'name'=>'Air Aruba',          'iata'=>'FQ','icao'=>'ARU','callsign'=>'ARUBA','fleet'=>0, 'bucket'=>'defunct','founded'=>'1986','hubs'=>'Oranjestad Reina Beatrix International (AUA / TNCA)'],
    ['id'=>801, 'name'=>'Aruba Airlines',     'iata'=>'AG','icao'=>'ARU','callsign'=>'ARUBA','fleet'=>1, 'bucket'=>'active',  'founded'=>'2012','hubs'=>'Oranjestad Reina Beatrix International (AUA / TNCA)'],
    ['id'=>802, 'name'=>'Bestfly Aruba',      'iata'=>null,'icao'=>'BFY','callsign'=>'MWANGO BEST','fleet'=>1, 'bucket'=>'active',  'founded'=>null,'hubs'=>''],
    ['id'=>803, 'name'=>'Comlux Aruba',       'iata'=>null,'icao'=>'CXB','callsign'=>'STARLUX','fleet'=>2, 'bucket'=>'active',  'founded'=>null,'hubs'=>''],
    ['id'=>804, 'name'=>'FIA - First International Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0, 'bucket'=>'defunct','founded'=>'1996','hubs'=>''],
    ['id'=>805, 'name'=>'FlyAruba',           'iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0, 'bucket'=>'unknown', 'founded'=>'2011','hubs'=>''],
    ['id'=>806, 'name'=>'Global Jet Aruba',   'iata'=>null,'icao'=>'GJW','callsign'=>'PLATA','fleet'=>3, 'bucket'=>'active',  'founded'=>'2022','hubs'=>''],
    ['id'=>807, 'name'=>'InselAir Aruba',     'iata'=>'8I','icao'=>'NLU','callsign'=>'INSEL ARUBA','fleet'=>0, 'bucket'=>'defunct','founded'=>'2012','hubs'=>'Oranjestad Reina Beatrix International (AUA / TNCA)'],
    ['id'=>808, 'name'=>'Royal Aruban Airlines','iata'=>'V5','icao'=>'RYL','callsign'=>'ROYAL ARUBAN','fleet'=>0, 'bucket'=>'unknown','founded'=>null,'hubs'=>''],
    ['id'=>810, 'name'=>'TBN Aircraft',       'iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0, 'bucket'=>'unknown', 'founded'=>null,'hubs'=>''],
    ['id'=>811, 'name'=>'Tiara Air',          'iata'=>'3P','icao'=>'TIA','callsign'=>'TIARA','fleet'=>0, 'bucket'=>'defunct','founded'=>'2006','hubs'=>''],
    ['id'=>812, 'name'=>'West Caribbean Aruba','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0, 'bucket'=>'unknown', 'founded'=>null,'hubs'=>''],
];
$c = 0;
foreach ($updates as $a) {
    exec_sql("UPDATE airlines SET iata_code=COALESCE(NULLIF(?,''),iata_code), icao_code=COALESCE(NULLIF(?,''),icao_code), callsign=COALESCE(NULLIF(?,''),callsign), fleet_size=?, status_bucket=?, founded=COALESCE(NULLIF(?,''),founded), hubs=COALESCE(NULLIF(?,''),hubs) WHERE id=?", [
        $a['iata']??'', $a['icao']??'', $a['callsign']??'',
        $a['fleet'], $a['bucket'],
        $a['founded']??'', $a['hubs']??'',
        $a['id']
    ]);
    $log("UPDATED: {$a['name']} (id={$a['id']}) {$a['iata']}/{$a['icao']} fleet={$a['fleet']} status={$a['bucket']}");
    $c++;
}

// ===== Insert missing airlines =====
$inserts = [
    ['name'=>'EZAir','iata'=>'EZ','icao'=>'EZR','callsign'=>'EZAIR','fleet'=>4,'bucket'=>'active','founded'=>'2000','hubs'=>'Oranjestad Reina Beatrix International (AUA / TNCA)','legal'=>'EZAir N.V.','trading'=>'EZAir','web'=>'https://www.ezairaruba.com','src'=>'https://en.wikipedia.org/wiki/EZAir'],
    ['name'=>'ILPO Airlines Cargo','iata'=>null,'icao'=>'ILP','callsign'=>null,'fleet'=>0,'bucket'=>'unknown','founded'=>null,'hubs'=>'','legal'=>null,'trading'=>null,'web'=>'','src'=>'https://www.planespotters.net/airline/ILPO-Airlines-Cargo'],
];
foreach ($inserts as $a) {
    $dup = row("SELECT id FROM airlines WHERE name = ? AND country_code = 'AW'", [$a['name']]);
    if ($dup) { $log("SKIP (exists id={$dup['id']}): {$a['name']}"); continue; }
    exec_sql("INSERT INTO airlines (name, iata_code, icao_code, callsign, fleet_size, status_bucket, founded, hubs, legal_name, trading_name, website_url, source_url, country_code) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,'AW')", [
        $a['name'], $a['iata'], $a['icao'], $a['callsign'],
        $a['fleet'], $a['bucket'], $a['founded'], $a['hubs'],
        $a['legal'], $a['trading'], $a['web'], $a['src']
    ]);
    $log("INSERTED: {$a['name']} ({$a['iata']}/{$a['icao']}) fleet={$a['fleet']} status={$a['bucket']}");
    $c++;
}

// ===== Assign logo URLs for uploaded logos =====
$logos = [
    ['name'=>'Air Aruba',              'logo'=>'assets/airline_logos/air-aruba.svg'],
    ['name'=>'Aruba Airlines',         'logo'=>'assets/airline_logos/aruba-airlines.png'],
    ['name'=>'Comlux Aruba',           'logo'=>'assets/airline_logos/comlux-aruba.png'],
    ['name'=>'FlyAruba',               'logo'=>'assets/airline_logos/flyaruba.gif'],
    ['name'=>'InselAir Aruba',         'logo'=>'assets/airline_logos/inselair-aruba.jpg'],
    ['name'=>'Tiara Air',              'logo'=>'assets/airline_logos/tiara-air.png'],
    ['name'=>'West Caribbean Aruba',   'logo'=>'assets/airline_logos/west-caribbean-aruba.png'],
];
foreach ($logos as $l) {
    $existing = row("SELECT id, logo_url FROM airlines WHERE name = ? AND country_code = 'AW'", [$l['name']]);
    if ($existing && !$existing['logo_url']) {
        exec_sql("UPDATE airlines SET logo_url = ? WHERE id = ?", [$l['logo'], $existing['id']]);
        $log("LOGO: {$l['name']} (id={$existing['id']}) -> {$l['logo']}");
        $c++;
    }
}

$log("=== Done! Processed: $c records ===");
