<?php
require_once __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/functions.php';

$log = fn($m)=>file_put_contents(__DIR__.'/../logs/update_as.log', '['.date('Y-m-d H:i:s')."] $m\n", FILE_APPEND)|printf("$m\n");

$airlines = [
    ['name'=>'Inter Island Air','iata'=>'JY','icao'=>'IWY','callsign'=>'INTER ISLAND','fleet'=>3,'bucket'=>'defunct','founded'=>'Aug 1993','hubs'=>'Pago Pago International Airport','legal'=>'Inter Island Air','trading'=>'Inter Island Air','src'=>'https://www.planespotters.net/airline/Inter-Island-Airways','wiki'=>'https://en.wikipedia.org/wiki/Inter_Island_Airways','logo'=>'inter-island-airways.png'],
    ['name'=>'Samoa Airlines','iata'=>'MB','icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>'1982','hubs'=>null,'legal'=>'Samoa Airlines','trading'=>'Samoa Airlines','src'=>'https://airlinehistory.co.uk/airline/samoa-airlines/','wiki'=>null,'logo'=>'samoa-air.png'], // No logo file for Samoa Airlines
    ['name'=>'Samoan Air Lines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>'1959','hubs'=>null,'legal'=>'Samoan Air Lines','trading'=>'Samoan Air Lines','src'=>'https://airlinehistory.co.uk/airline/samoan-air-lines/','wiki'=>null,'logo'=>null],
    ['name'=>'South Pacific Island Airways','iata'=>'HK','icao'=>'SPI','callsign'=>'SOUTH PACIFIC','fleet'=>8,'bucket'=>'defunct','founded'=>'1973','hubs'=>'Pago Pago International Airport, Honolulu International Airport','legal'=>'South Pacific Island Airways','trading'=>'South Pacific Island Airways','src'=>null,'wiki'=>'https://en.wikipedia.org/wiki/South_Pacific_Island_Airways','logo'=>null],
    ['name'=>'Pago Wings','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>'2023','hubs'=>null,'legal'=>'Pago Wings','trading'=>'Pago Wings','src'=>null,'wiki'=>null,'logo'=>null],
];

$log("Starting American Samoa (AS) airlines update...");
$db = db(); $u = 0; $i = 0;

foreach ($airlines as $a) {
    $ex = row("SELECT id FROM airlines WHERE name=? AND country_code='AS'", [$a['name']]);
    $lp = $a['logo'] ? 'assets/airline_logos/'.$a['logo'] : null;

    if ($ex) {
        $s = "UPDATE airlines SET iata_code=COALESCE(NULLIF(?,''),iata_code), icao_code=COALESCE(NULLIF(?,''),icao_code), callsign=COALESCE(NULLIF(?,''),callsign), fleet_size=COALESCE(?,fleet_size), status_bucket=?, founded=COALESCE(NULLIF(?,''),founded), hubs=COALESCE(NULLIF(?,''),hubs), legal_name=COALESCE(NULLIF(?,''),legal_name), trading_name=COALESCE(NULLIF(?,''),trading_name), source_url=COALESCE(NULLIF(?,''),source_url), wikipedia_url=COALESCE(NULLIF(?,''),wikipedia_url), country_code='AS', data_source=COALESCE(data_source,'planespotters_country_csv')".($lp?",logo_url=COALESCE(NULLIF(logo_url,''),?)":"")." WHERE id=?";
        $p = [$a['iata']??'', $a['icao']??'', $a['callsign']??'', $a['fleet'], $a['bucket']??'unknown', $a['founded']??'', $a['hubs']??'', $a['legal']??'', $a['trading']??'', $a['src']??'', $a['wiki']??''];
        if ($lp) $p[] = $lp;
        $p[] = $ex['id'];
        exec_sql($s, $p);
        $log("UPDATED: {$a['name']} (id={$ex['id']})".($lp?" + logo":""));
        $u++;
    } else {
        $cols = ['name','country_code','data_source','status_bucket'];
        $vals = [$a['name'],'AS','planespotters_country_csv',$a['bucket']??'unknown'];
        $phs = ['?','?','?','?'];
        foreach (['iata_code','icao_code','callsign','fleet_size','founded','hubs','legal_name','trading_name','source_url','wikipedia_url','logo_url'] as $f) {
            $v = $f === 'logo_url' ? $lp : ($a[['iata_code'=>'iata','icao_code'=>'icao','callsign'=>'callsign','fleet_size'=>'fleet','founded'=>'founded','hubs'=>'hubs','legal_name'=>'legal','trading_name'=>'trading','source_url'=>'src','wikipedia_url'=>'wiki'][$f] ?? null] ?? null);
            if ($v !== null && $v !== '') { $cols[] = $f; $vals[] = $v; $phs[] = '?'; }
        }
        exec_sql("INSERT INTO airlines (".implode(', ',$cols).") VALUES (".implode(', ',$phs).")", $vals);
        $nid = $db->lastInsertId();
        $log("INSERTED: {$a['name']} (id=$nid)".($lp?" + logo":""));
        $i++;
    }
}
$log("Done! Updated: $u, Inserted: $i");
