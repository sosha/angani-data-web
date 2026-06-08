<?php
require_once __DIR__ . '/../includes/db.php';
$log=fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_algeria_fleet.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);

$db=db();
$log("=== Starting Algeria (DZ) fleet update ===");

// Fleet updates from planespotters saved pages
$updates = [
    ['id'=>8196, 'name'=>'Air Algérie',       'iata'=>'AH','icao'=>'DAH','callsign'=>'AIR ALGERIE','fleet'=>60,'bucket'=>'active','founded'=>'1947','hubs'=>'Algiers Houari Boumediene (ALG / DAAG)','legal'=>'Air Algérie SpA','web'=>'https://www.airalgerie.dz/','src'=>'https://www.planespotters.net/airline/Air-Algerie'],
    ['id'=>1788, 'name'=>'Antinea Airlines',    'iata'=>'HO','icao'=>'DJA','callsign'=>'ANTINEA','fleet'=>0,'bucket'=>'defunct','founded'=>'Jun 1999','hubs'=>null,'legal'=>null,'web'=>null,'src'=>'https://www.planespotters.net/airline/Antinea-Airlines'],
    ['id'=>1789, 'name'=>'Domestic Airlines',   'iata'=>'SF','icao'=>'DTH','callsign'=>'TASSILI AIR','fleet'=>15,'bucket'=>'active','founded'=>'2025','hubs'=>'Algiers Houari Boumediene (ALG / DAAG)','legal'=>null,'web'=>'https://www.tassiliairlines.dz/','src'=>'https://www.planespotters.net/airline/Domestic-Airlines'],
    ['id'=>1790, 'name'=>'Ecoair International','iata'=>'9H','icao'=>'DEI','callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'1999','hubs'=>null,'legal'=>null,'web'=>null,'src'=>'https://www.planespotters.net/airline/Ecoair-International'],
    ['id'=>1791, 'name'=>'Inter Air Services',  'iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>3,'bucket'=>'defunct','founded'=>'1984','hubs'=>null,'legal'=>null,'web'=>null,'src'=>'https://www.planespotters.net/airline/Inter-Air-Services'],
    ['id'=>1792, 'name'=>'Khalifa Airways',     'iata'=>'K6','icao'=>'KZW','callsign'=>'KHALIFA AIR','fleet'=>0,'bucket'=>'defunct','founded'=>'Jun 1999','hubs'=>'Algiers Houari Boumediene (ALG / DAAG)','legal'=>null,'web'=>'http://www.khalifaairways-dz.com/','src'=>'https://www.planespotters.net/airline/Khalifa-Airways'],
    ['id'=>1793, 'name'=>'Khalifa Airways Cargo','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>1,'bucket'=>'defunct','founded'=>null,'hubs'=>null,'legal'=>null,'web'=>null,'src'=>'https://www.planespotters.net/airline/Khalifa-Airways-Cargo'],
    ['id'=>1794, 'name'=>'Rym Airlines',        'iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>2,'bucket'=>'defunct','founded'=>'2003','hubs'=>null,'legal'=>null,'web'=>null,'src'=>'https://www.planespotters.net/airline/Rym-Airlines'],
    ['id'=>8461, 'name'=>'Star Aviation',       'iata'=>null,'icao'=>'DST','callsign'=>'STAR AVIATION','fleet'=>5,'bucket'=>'active','founded'=>'2001','hubs'=>'Hassi Messaoud Oued Irara–Krim Belkacem (HME / DAUH)','legal'=>null,'web'=>'http://www.redmed-group.com/','src'=>'https://www.planespotters.net/airline/Star-Aviation-Algeria'],
    ['id'=>8197, 'name'=>'Tassili Airlines',    'iata'=>'SF','icao'=>'DTH','callsign'=>'TASSILI AIR','fleet'=>0,'bucket'=>'defunct','founded'=>'1997','hubs'=>'Algiers Houari Boumediene (ALG / DAAG)','legal'=>null,'web'=>'http://www.tassiliairlines.dz/','src'=>'https://www.planespotters.net/airline/Tassili-Airlines'],
];

$c=0;
foreach ($updates as $a) {
    $sql = "UPDATE airlines SET 
        iata_code=COALESCE(NULLIF(?,''),iata_code),
        icao_code=COALESCE(NULLIF(?,''),icao_code),
        callsign=COALESCE(NULLIF(?,''),callsign),
        fleet_size=?,
        status_bucket=?,
        founded=COALESCE(NULLIF(?,''),founded),
        hubs=COALESCE(NULLIF(?,''),hubs),
        legal_name=COALESCE(NULLIF(?,''),legal_name),
        website_url=COALESCE(NULLIF(?,''),website_url),
        source_url=COALESCE(NULLIF(?,''),source_url)
        WHERE id=?";
    exec_sql($sql, [
        $a['iata']??'', $a['icao']??'', $a['callsign']??'',
        $a['fleet'], $a['bucket'],
        $a['founded']??'', $a['hubs']??'',
        $a['legal']??'', $a['web']??'', $a['src']??'',
        $a['id']
    ]);
    $log("UPDATED: {$a['name']} (id={$a['id']}) fleet={$a['fleet']} status={$a['bucket']}");
    $c++;
}

$log("=== Done! Updated $c Algeria airline fleet records ===");
