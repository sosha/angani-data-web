<?php
require_once __DIR__ . '/../includes/db.php';
$log = fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_angola.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);

$airlines = [
    ['name'=>'AeroJet','logo'=>'aerojet.png','src'=>'https://www.planespotters.net/airline/AeroJet'],
    ['name'=>'Air 26','logo'=>'air-26.png','src'=>'https://www.planespotters.net/airline/Air-26'],
    ['name'=>'Air Gemini','logo'=>null,'src'=>'https://www.planespotters.net/airline/Air-Gemini'],
    ['name'=>'AirJet Angola','logo'=>'airjet-angola.jpg','src'=>'https://www.planespotters.net/airline/Airjet-Angola'],
    ['name'=>'Angola Air Charter (AAC)','logo'=>'angola-air-charter.png','src'=>'https://www.planespotters.net/airline/Angola-Air-Charter'],
    ['name'=>'Angola Air Services','logo'=>'angola-air-services.png','src'=>'https://www.planespotters.net/airline/Angola-Air-Services'],
    ['name'=>'Bestfly','logo'=>'bestfly.jpg','src'=>'https://www.planespotters.net/airline/Bestfly'],
    ['name'=>'Diexim Expresso','logo'=>'diexim-expresso.png','src'=>'https://www.planespotters.net/airline/Diexim-Expresso'],
    ['name'=>'Fly Angola','logo'=>'fly-angola.png','src'=>'https://www.planespotters.net/airline/Fly-Angola'],
    ['name'=>'Fly540 Angola','logo'=>'fly540-angola.png','src'=>'https://www.planespotters.net/airline/Fly540-Angola'],
    ['name'=>'Guicango','logo'=>'guicango.jpg','src'=>'https://www.planespotters.net/airline/Guicango'],
    ['name'=>'HM - Heli Malongo Airways','logo'=>'hm-heli-malongo-airways.png','src'=>'https://www.planespotters.net/airline/HM-Heli-Malongo-Airways'],
    ['name'=>'SEAA - Serviços Executivos Aéreos de Angola','logo'=>null,'src'=>'https://www.planespotters.net/airline/SEAA-Servicos'],
    ['name'=>'Servisair','logo'=>'servisair-angola.png','src'=>'https://www.planespotters.net/airline/Servisair-%28Angola%29'],
    ['name'=>'SJL Aeronáutica','logo'=>'sjl-aeronautica.png','src'=>'https://www.planespotters.net/airline/SJL-Aeronautica'],
    ['name'=>'Sonair','logo'=>'sonair.jpg','src'=>'https://www.planespotters.net/airline/SonAir'],
    ['name'=>'Sonangol','logo'=>'sonangol.svg','src'=>'https://www.planespotters.net/airline/Sonangol'],
    ['name'=>'TAAG - Linhas Aereas de Angola Airlines','logo'=>'taag-linhas-aereas-de-angola-airline.svg','src'=>'https://www.planespotters.net/airline/TAAG-Linhas-Aereas-de-Angola-Airlines'],
];

$db = db(); $u = 0;
$log("Starting Angola (AO) update...");
foreach ($airlines as $a) {
    $lp = $a['logo'] ? 'assets/airline_logos/'.$a['logo'] : null;
    $ex = row("SELECT id, logo_url FROM airlines WHERE name=? AND country_code='AO'", [$a['name']]);
    if ($ex) {
        $sql = "UPDATE airlines SET source_url=COALESCE(NULLIF(source_url,''),?), data_source=COALESCE(data_source,'planespotters_country_csv')".($lp?", logo_url=COALESCE(NULLIF(logo_url,''),?)":"")." WHERE id=?";
        $p = [$a['src']];
        if ($lp) $p[] = $lp;
        $p[] = $ex['id'];
        exec_sql($sql, $p);
        $log("UPDATED: {$a['name']} (id={$ex['id']})".($lp?" + logo":""));
        $u++;
    } else { $log("SKIPPED: {$a['name']} - not found"); }
}
$log("Done! Updated: $u");
