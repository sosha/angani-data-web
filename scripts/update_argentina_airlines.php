<?php
require_once __DIR__ . '/../includes/db.php';
$log=fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_argentina.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);

$db=db();

// Clean up duplicates first
$log("=== Cleaning up duplicates ===");
$dupes = [
    ["AeroChaco", 593, 592],          // keep Aerochaco (592)
    ["Aerolineas Argentinas", 594, 12], // keep id=12 (has real IATA/ICAO)
    ["Aerovip", 599, null],            // keep id=598; delete 599 only
    ["Aerovip", 598, null],
    ["Lapa", 624, null],              // keep LAPA (623); delete Lapa (624)
];
foreach ($dupes as $d) {
    if ($d[2]) {
        exec_sql("DELETE FROM airlines WHERE id=?", [$d[1]]);
        $log("DELETED duplicate: {$d[0]} (id={$d[1]}) kept id={$d[2]}");
    } else {
        // Just delete, both are Aerovip
        exec_sql("DELETE FROM airlines WHERE id=?", [$d[1]]);
        $log("DELETED duplicate: {$d[0]} (id={$d[1]})");
    }
}

$airlines = [
    // From Wikipedia CSV (7 airlines)
    ['name'=>'Aerolineas Argentinas','iata'=>'AR','icao'=>'ARG','callsign'=>'ARGENTINA','fleet'=>81,'bucket'=>'active','founded'=>'1949','hubs'=>'Ministro Pistarini International Airport', 'alliance'=>'SkyTeam','parent'=>'Government of Argentina','legal'=>'Aerolíneas Argentinas S.A.','trading'=>null,'src'=>'https://en.wikipedia.org/wiki/Aerol%C3%ADneas_Argentinas','wiki'=>'https://en.wikipedia.org/wiki/Aerol%C3%ADneas_Argentinas','web'=>'https://www.aerolineas.com.ar/','logo'=>'aerolineas-argentinas.png'],
    ['name'=>'Andes Líneas Aéreas','iata'=>'OY','icao'=>'ANS','callsign'=>'AEROANDES','fleet'=>4,'bucket'=>'active','founded'=>'2006','hubs'=>'Martín Miguel de Güemes International Airport', 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://en.wikipedia.org/wiki/Andes_L%C3%ADneas_A%C3%A9reas','wiki'=>'https://en.wikipedia.org/wiki/Andes_L%C3%ADneas_A%C3%A9reas','web'=>'http://www.andesonline.com/','logo'=>'andes-lineas-aereas.png'],
    ['name'=>'Flybondi','iata'=>'FO','icao'=>'FBZ','callsign'=>'BONDI','fleet'=>12,'bucket'=>'active','founded'=>'2016','hubs'=>'Aeroparque Jorge Newbery, Ministro Pistarini International Airport', 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://en.wikipedia.org/wiki/Flybondi','wiki'=>'https://en.wikipedia.org/wiki/Flybondi','web'=>'https://www.flybondi.com/','logo'=>'flybondi.png'],
    ['name'=>'jetSmart Argentina','iata'=>'WJ','icao'=>'JES','callsign'=>'SMARTBIRD','fleet'=>18,'bucket'=>'active','founded'=>'2019','hubs'=>'Aeroparque Jorge Newbery, Ministro Pistarini International Airport', 'alliance'=>null,'parent'=>'JetSmart','legal'=>null,'trading'=>null,'src'=>'https://en.wikipedia.org/wiki/JetSmart_Argentina','wiki'=>'https://en.wikipedia.org/wiki/JetSmart_Argentina','web'=>'https://www.jetsmart.com/','logo'=>'jetsmart-argentina.png'],
    ['name'=>'LADE','iata'=>'5U','icao'=>'LDE','callsign'=>'LADE','fleet'=>null,'bucket'=>'active','founded'=>'1944','hubs'=>'Aeroparque Jorge Newbery', 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://en.wikipedia.org/wiki/LADE','wiki'=>'https://en.wikipedia.org/wiki/LADE','web'=>null,'logo'=>'lade.png'],
    ['name'=>'American Jet','iata'=>null,'icao'=>'AJB','callsign'=>'AMJET','fleet'=>5,'bucket'=>'active','founded'=>'1983','hubs'=>'Aeroparque Jorge Newbery', 'alliance'=>null,'parent'=>null,'legal'=>'American Jet S.A.','trading'=>null,'src'=>'https://en.wikipedia.org/wiki/List_of_airlines_of_Argentina','wiki'=>'https://en.wikipedia.org/wiki/List_of_airlines_of_Argentina','web'=>'http://www.americanjet.com.ar/','logo'=>'american-jet.png'],
    // Additional airlines from DB (with logos)
    ['name'=>'Aerochaco','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>'2008','hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Aerochaco','wiki'=>null,'web'=>null,'logo'=>'aerochaco-2008.jpg'],
    ['name'=>'Aerotec','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>'1976','hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Aerotec','wiki'=>null,'web'=>null,'logo'=>'aerotec-lv.png'],
    ['name'=>'Aerotransportes Entre Rios','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>'1996','hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Aerotransportes-Entre-Rios','wiki'=>null,'web'=>null,'logo'=>'aerotransportes-entre-rios.jpg'],
    ['name'=>'Aerovip','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Aerovip','wiki'=>null,'web'=>null,'logo'=>'aerovip-argentina.png'],
    ['name'=>'AIRG','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/AIRG','wiki'=>null,'web'=>null,'logo'=>'airg.jpg'],
    ['name'=>'AIRG Express','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/AIRG-Express','wiki'=>null,'web'=>null,'logo'=>'airg-express.jpg'],
    ['name'=>'Alba Jet','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>1,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Alba-Jet','wiki'=>null,'web'=>null,'logo'=>'alba-jet.jpg'],
    ['name'=>'Andesmar Líneas Aéreas','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Andesmar-Lineas-Aereas','wiki'=>null,'web'=>null,'logo'=>null],
    ['name'=>'Austral Líneas Aéreas','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Austral-Lineas-Aereas','wiki'=>null,'web'=>null,'logo'=>null],
    ['name'=>'Avianca Argentina','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Avianca-Argentina','wiki'=>null,'web'=>null,'logo'=>null],
    ['name'=>'Dinar Líneas Aéreas','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Dinar-Lineas-Aereas','wiki'=>null,'web'=>null,'logo'=>null],
    ['name'=>'Flytec','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Flytec','wiki'=>null,'web'=>null,'logo'=>'flytech-argentina.png'],
    ['name'=>'Helicópteros Marinos','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Helicopteros-Marinos','wiki'=>null,'web'=>null,'logo'=>'helicopteros-marinos.jpg'],
    ['name'=>'Kaiken Líneas Aéreas','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Kaiken-Lineas-Aereas','wiki'=>null,'web'=>null,'logo'=>'kaiken-lineas-aereas.jpg'],
    ['name'=>'LAPA','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/LAPA','wiki'=>null,'web'=>null,'logo'=>'lapa-2002.jpg'],
    ['name'=>'LAN Argentina','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/LAN-Argentina','wiki'=>null,'web'=>null,'logo'=>null],
    ['name'=>'LATAM Airlines Argentina','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/LATAM-Airlines-Argentina','wiki'=>null,'web'=>null,'logo'=>null],
    ['name'=>'Norwegian Air Argentina','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/Norwegian-Air-Argentina','wiki'=>null,'web'=>null,'logo'=>null],
    ['name'=>'SOL Lineas Aereas','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/SOL-Lineas-Aereas','wiki'=>null,'web'=>null,'logo'=>'sol-lineas-aereas.png'],
    ['name'=>'TAPSA Aviación','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/TAPSA-Aviacion','wiki'=>null,'web'=>null,'logo'=>'tapsa.svg'],
    ['name'=>'TAR - Transporte Aéreo Rioplatense','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/TAR-Transporte-Aereo-Rioplatense','wiki'=>null,'web'=>null,'logo'=>'transporte-aereo-rioplatense.png'],
    ['name'=>'XFlight','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>1,'bucket'=>'defunct','founded'=>null,'hubs'=>null, 'alliance'=>null,'parent'=>null,'legal'=>null,'trading'=>null,'src'=>'https://www.planespotters.net/airline/XFlight','wiki'=>null,'web'=>null,'logo'=>'xflight.png'],
];

$u=0;$i=0;
$log("=== Starting Argentina (AR) update ===");
foreach($airlines as $a){
    $lp=$a['logo']?'assets/airline_logos/'.$a['logo']:null;
    $ex=row("SELECT id FROM airlines WHERE BINARY name=? AND country_code='AR'",[$a['name']]);
    if($ex){
        $p=[$a['iata']??'', $a['icao']??'', $a['callsign']??'', $a['fleet'], $a['bucket'], $a['founded']??'', $a['hubs']??'', $a['parent']??'', $a['legal']??'', $a['trading']??'', $a['src']??'', $a['wiki']??'', $a['web']??''];
        $lpSet=$lp?",logo_url=COALESCE(NULLIF(logo_url,''),?)":"";
        exec_sql("UPDATE airlines SET iata_code=COALESCE(NULLIF(?,''),iata_code),icao_code=COALESCE(NULLIF(?,''),icao_code),callsign=COALESCE(NULLIF(?,''),callsign),fleet_size=COALESCE(?,fleet_size),status_bucket=?,founded=COALESCE(NULLIF(?,''),founded),hubs=COALESCE(NULLIF(?,''),hubs),parent_company=COALESCE(NULLIF(?,''),parent_company),legal_name=COALESCE(NULLIF(?,''),legal_name),trading_name=COALESCE(NULLIF(?,''),trading_name),source_url=COALESCE(NULLIF(?,''),source_url),wikipedia_url=COALESCE(NULLIF(?,''),wikipedia_url),website_url=COALESCE(NULLIF(?,''),website_url),country_code='AR',data_source=COALESCE(data_source,'planespotters_country_csv'){$lpSet} WHERE id=?",
            $lp?[...$p,$lp,$ex['id']]:[...$p,$ex['id']]);
        $log("UPDATED: {$a['name']} (id={$ex['id']})".($lp?" + logo":""));
        $u++;
    }else{
        $c=['name','country_code','data_source','status_bucket'];$v=[$a['name'],'AR','planespotters_country_csv',$a['bucket']];$q=['?','?','?','?'];
        foreach(['iata_code'=>'iata','icao_code'=>'icao','callsign'=>'callsign','fleet_size'=>'fleet','founded'=>'founded','hubs'=>'hubs','parent_company'=>'parent','legal_name'=>'legal','trading_name'=>'trading','source_url'=>'src','wikipedia_url'=>'wiki','website_url'=>'web','logo_url'=>'logo'] as $col=>$k){
            $vv=$col==='logo_url'?$lp:($a[$k]??null);
            if($vv!==null&&$vv!==''){$c[]=$col;$v[]=$vv;$q[]='?';}
        }
        exec_sql("INSERT INTO airlines (".implode(', ',$c).") VALUES (".implode(', ',$q).")",$v);
        $nid=$db->lastInsertId();
        $log("INSERTED: {$a['name']} (id=$nid)".($lp?" + logo":""));
        $i++;
    }
}
$log("=== Done! Updated: $u, Inserted: $i ===");
