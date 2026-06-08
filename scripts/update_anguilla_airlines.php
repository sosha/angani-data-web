<?php
require_once __DIR__ . '/../includes/db.php';
$log = fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_anguilla.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);

$airlines = [
    ['name'=>'Air Anguilla','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'1979','hubs'=>'The Valley Wallblake (AXA/TQPF)','legal'=>'Air Anguilla Incorporated','trading'=>'Air Anguilla','src'=>'https://www.planespotters.net/airline/Air-Anguilla','wiki'=>'https://en.wikipedia.org/?curid=60036371','logo'=>null],
    ['name'=>'Anguilla Air Services','iata'=>'Q3','icao'=>'AXL','callsign'=>null,'fleet'=>6,'bucket'=>'active','founded'=>'2006','hubs'=>'Clayton J. Lloyd International Airport (AXA/TQPF)','legal'=>'Anguilla Air Services','trading'=>'Anguilla Air Services','src'=>'https://en.wikipedia.org/wiki/Anguilla_Air_Services','wiki'=>'https://en.wikipedia.org/wiki/Anguilla_Air_Services','website'=>'https://anguillaairservices.com','logo'=>null],
    ['name'=>'Trans Anguilla Airways','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'active','founded'=>'1996','hubs'=>'Clayton J. Lloyd International Airport (AXA/TQPF)','legal'=>'Trans Anguilla Airways 2000 Limited','trading'=>'Trans Anguilla Airways','src'=>'https://www.planespotters.net/airline/Trans-Anguilla-Airways','wiki'=>'https://en.wikipedia.org/wiki/Trans_Anguilla_Airways','website'=>'https://www.transanguilla.com','logo'=>'trans-anguilla-airways.png'],
];

$db = db(); $u = 0; $i = 0;
$log("Starting Anguilla (AI) update...");
foreach ($airlines as $a) {
    $lp = $a['logo'] ? 'assets/airline_logos/'.$a['logo'] : null;
    $ex = row("SELECT id FROM airlines WHERE name=? AND country_code='AI'", [$a['name']]);
    if ($ex) {
        $s = "UPDATE airlines SET iata_code=COALESCE(NULLIF(?,''),iata_code), icao_code=COALESCE(NULLIF(?,''),icao_code), callsign=COALESCE(NULLIF(?,''),callsign), fleet_size=COALESCE(?,fleet_size), status_bucket=?, founded=COALESCE(NULLIF(?,''),founded), hubs=COALESCE(NULLIF(?,''),hubs), legal_name=COALESCE(NULLIF(?,''),legal_name), trading_name=COALESCE(NULLIF(?,''),trading_name), source_url=COALESCE(NULLIF(?,''),source_url), wikipedia_url=COALESCE(NULLIF(?,''),wikipedia_url), website_url=COALESCE(NULLIF(?,''),website_url), country_code='AI', data_source=COALESCE(data_source,'planespotters_country_csv')".($lp?", logo_url=COALESCE(NULLIF(logo_url,''),?)":"")." WHERE id=?";
        $p = [$a['iata']??'', $a['icao']??'', $a['callsign']??'', $a['fleet'], $a['bucket']??'unknown', $a['founded']??'', $a['hubs']??'', $a['legal']??'', $a['trading']??'', $a['src']??'', $a['wiki']??'', $a['website']??''];
        if ($lp) $p[] = $lp;
        $p[] = $ex['id'];
        exec_sql($s, $p);
        $log("UPDATED: {$a['name']} (id={$ex['id']})".($lp?" + logo":""));
        $u++;
    } else {
        $cols = ['name','country_code','data_source','status_bucket'];
        $vals = [$a['name'],'AI','planespotters_country_csv',$a['bucket']??'unknown'];
        $phs = ['?','?','?','?'];
        foreach (['iata_code','icao_code','callsign','fleet_size','founded','hubs','legal_name','trading_name','source_url','wikipedia_url','website_url','logo_url'] as $f) {
            $map = ['iata_code'=>'iata','icao_code'=>'icao','callsign'=>'callsign','fleet_size'=>'fleet','founded'=>'founded','hubs'=>'hubs','legal_name'=>'legal','trading_name'=>'trading','source_url'=>'src','wikipedia_url'=>'wiki','website_url'=>'website','logo_url'=>'logo'];
            $v = $f === 'logo_url' ? $lp : ($a[$map[$f]] ?? null);
            if ($v !== null && $v !== '') { $cols[] = $f; $vals[] = $v; $phs[] = '?'; }
        }
        exec_sql("INSERT INTO airlines (".implode(', ',$cols).") VALUES (".implode(', ',$phs).")", $vals);
        $nid = $db->lastInsertId();
        $log("INSERTED: {$a['name']} (id=$nid)".($lp?" + logo":""));
        $i++;
    }
}
$log("Done! Updated: $u, Inserted: $i");
