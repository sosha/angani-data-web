<?php
require_once __DIR__ . '/../includes/db.php';
$log=fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_australia.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);
$db=db();
$log("=== Starting Australia (AU) airlines update ===");

// Fix mis-assigned airlines that got AU country_code incorrectly
$fixCountry = [
    [5090, 'UZ', 'Qanot Sharq is Uzbek'],
    [5094, 'QA', 'Qatar Airways is Qatari'],
    [5095, 'US', 'Horizon Air is US'],
    [5453, 'CN', 'Suparna Airlines is Chinese'],
];
foreach ($fixCountry as $f) {
    $r = row("SELECT id, country_code FROM airlines WHERE id=?", [$f[0]]);
    if ($r && $r['country_code'] === 'AU') {
        exec_sql("UPDATE airlines SET country_code=? WHERE id=?", [$f[1], $f[0]]);
        $log("FIXED: id={$f[0]} country_code AU->{$f[1]} ({$f[2]})");
    }
}

// All Australia airlines from CSV with real data
$airlines = [
    ['name'=>'Air Link','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>21,'bucket'=>'active','founded'=>'1974','hubs'=>'Dubbo Regional Airport','legal'=>'Air Link Pty Ltd','trading'=>'Air Link','web'=>'https://www.airlinkairlines.com.au/'],
    ['name'=>'Airnorth','iata'=>'TL','icao'=>'ANO','callsign'=>'TOPEND','fleet'=>13,'bucket'=>'active','founded'=>'4 Jul 1978','hubs'=>'Darwin International (DRW / YPDN); Maningrida (MNG / YMGD)','legal'=>'Capiteq Pty Limited','trading'=>'Airnorth','web'=>'https://airnorth.com.au/'],
    ['name'=>'Alliance Airlines','iata'=>'QQ','icao'=>'UTY','callsign'=>'UNITY','fleet'=>89,'bucket'=>'active','founded'=>'5 Apr 2002','hubs'=>'Brisbane International (BNE / YBBN); Adelaide International (ADL / YPAD); Cairns International (CNS / YBCS); Melbourne Essendon (MEB / YMEN); Perth International (PER / YPPH); Townsville (TSV / YBTL)','legal'=>'Alliance Airlines Pty Ltd','trading'=>'Alliance Airlines','web'=>'https://allianceairlines.com.au/'],
    ['name'=>'ASL Airlines Australia','iata'=>'PH','icao'=>'SFZ','callsign'=>'SKYFORCE','fleet'=>10,'bucket'=>'active','founded'=>'3 Apr 2023','hubs'=>'Bankstown (BWU / YSBK)','legal'=>'Pionair Australia Pty Ltd','trading'=>'ASL Airlines Australia','web'=>'https://aslairlines.com.au/'],
    ['name'=>'Aviair','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>6,'bucket'=>'active','founded'=>null,'hubs'=>'Kununurra (KNX / YPKU); Broome International (BME / YBRM)','legal'=>'Aviair Proprietary Limited','trading'=>'Aviair','web'=>'https://aviair.com.au/'],
    ['name'=>'Eastern Air Services','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>9,'bucket'=>'active','founded'=>'2019','hubs'=>'Port Macquarie Airport','legal'=>'Eastern Air Pty Ltd','trading'=>'Eastern Air Services','web'=>'https://easternairservices.com.au/'],
    ['name'=>'FlyPelican','iata'=>'FP','icao'=>'FRE','callsign'=>'PELICAN','fleet'=>5,'bucket'=>'active','founded'=>'16 Dec 2013','hubs'=>'Newcastle RAAF Base Williamtown (NTL / YWLM)','legal'=>'Pelican Airlines Propriety Limited','trading'=>'FlyPelican','web'=>'https://flypelican.com.au/'],
    ['name'=>'Fly Tiwi','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>32,'bucket'=>'active','founded'=>'2008','hubs'=>'Darwin International Airport','legal'=>'Hardy Aviation','trading'=>'Fly Tiwi','web'=>'https://www.flytiwi.com.au/'],
    ['name'=>'Hinterland Aviation','iata'=>'OI','icao'=>'HND','callsign'=>'HINTERLAND','fleet'=>14,'bucket'=>'active','founded'=>'11 May 1984','hubs'=>'Cairns Airport; Townsville Airport; Horn Island','legal'=>null,'trading'=>'Hinterland Aviation','web'=>'http://www.hinterlandaviation.com.au'],
    ['name'=>'Jetstar Airways','iata'=>'JQ','icao'=>'JST','callsign'=>'JETSTAR','fleet'=>99,'bucket'=>'active','founded'=>'1 Dec 2003','hubs'=>'Melbourne Tullamarine (MEL / YMML)','legal'=>'Jetstar Airways Pty Ltd','trading'=>'Jetstar','web'=>'https://jetstar.com/'],
    ['name'=>'King Island Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>5,'bucket'=>'active','founded'=>null,'hubs'=>'Moorabbin Airport','legal'=>'Matakana Nominees Pty Ltd','trading'=>'King Island Airlines','web'=>'https://kingislandair.com.au/'],
    ['name'=>'Link Airways','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>11,'bucket'=>'active','founded'=>'11 Aug 2020','hubs'=>'Brisbane Airport','legal'=>'Corporate Air','trading'=>'Link Airways','web'=>'https://linkairways.com/'],
    ['name'=>'Nexus Airlines','iata'=>null,'icao'=>null,'callsign'=>'CONNECT','fleet'=>6,'bucket'=>'active','founded'=>'17 May 2023','hubs'=>'Geraldton Airport; Broome Airport','legal'=>'HM Consolidated Group','trading'=>'Nexus Airlines','web'=>'https://nexusairlines.com.au/'],
    ['name'=>'Par Avion','iata'=>'FO','icao'=>'ATM','callsign'=>'AIRTAS','fleet'=>13,'bucket'=>'active','founded'=>'1978','hubs'=>'Launceston Airport; Cambridge Aerodrome','legal'=>'Airlines of Tasmania Pty Ltd','trading'=>'Par Avion','web'=>'https://www.paravion.com.au/'],
    ['name'=>'Qantas Airways','iata'=>'QF','icao'=>'QFA','callsign'=>'QANTAS','fleet'=>137,'bucket'=>'active','founded'=>'16 Nov 1920','hubs'=>'Sydney Kingsford Smith (SYD / YSSY); Adelaide International (ADL / YPAD); Brisbane International (BNE / YBBN); Melbourne Tullamarine (MEL / YMML); Perth International (PER / YPPH)','legal'=>'Qantas Airways Limited','trading'=>'Qantas','web'=>'https://qantas.com/'],
    ['name'=>'QantasLink','iata'=>'QF','icao'=>null,'callsign'=>null,'fleet'=>92,'bucket'=>'active','founded'=>'2001','hubs'=>'Sydney Airport; Melbourne Airport; Brisbane Airport; Perth Airport','legal'=>'Qantas','trading'=>'QantasLink','web'=>'https://www.qantas.com/en-au/where-we-fly/qantaslink'],
    ['name'=>'Queensland Regional Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'4 Apr 2002','hubs'=>'','legal'=>'Queensland Regional Airlines Pty Ltd.','trading'=>'Queensland Regional Airlines','web'=>'https://qra.com.au/'],
    ['name'=>'Qwestair','iata'=>'QH','icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'Jan 1989','hubs'=>'Perth International (PER / YPPH)','legal'=>null,'trading'=>'Qwestair','web'=>''],
    ['name'=>'RACQ LifeFlight Rescue','iata'=>null,'icao'=>'GDY','callsign'=>'GUARDIAN','fleet'=>0,'bucket'=>'defunct','founded'=>'11 Jul 2016','hubs'=>'','legal'=>'LifeFlight Australia Limited','trading'=>'RACQ LifeFlight Rescue','web'=>'https://lifeflight.org.au/'],
    ['name'=>'Reefwatch Air Tours','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'27 May 2005','hubs'=>'Cairns International (CNS / YBCS)','legal'=>'GAM Group','trading'=>'Reefwatch Air Tours','web'=>''],
    ['name'=>'Regional Pacific Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'May 2001','hubs'=>'Cairns International (CNS / YBCS)','legal'=>'Regional Pacific Airlines Pty Ltd','trading'=>'Regional Pacific Airlines','web'=>''],
    ['name'=>'Rex Airlines','iata'=>'ZL','icao'=>'RXA','callsign'=>'REX','fleet'=>56,'bucket'=>'active','founded'=>'11 Jul 2002','hubs'=>'','legal'=>'Regional Express Pty Limited','trading'=>'Rex Airlines','web'=>'https://rex.com.au/'],
    ['name'=>'Rossair Charter','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'19 Oct 1963','hubs'=>'Adelaide International (ADL / YPAD)','legal'=>'Rossair Charter Pty Limited','trading'=>'Rossair Charter','web'=>'https://rossaircharter.com.au/'],
    ['name'=>'Seair Pacific','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>1,'bucket'=>'active','founded'=>'1971','hubs'=>'Bilinga Gold Coast (Coolangatta) (OOL / YBCG)','legal'=>null,'trading'=>'Seair Pacific','web'=>'https://seairpacific.com.au/'],
    ['name'=>'Skippers Aviation','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>12,'bucket'=>'active','founded'=>'1990','hubs'=>'Perth International (PER / YPPH); Broome International (BME / YBRM)','legal'=>'Skippers Aviation Pty Ltd','trading'=>'Skippers Aviation','web'=>'https://skippers.com.au/'],
    ['name'=>'Sky Air World','iata'=>'S9','icao'=>'SYW','callsign'=>'SKY AIR','fleet'=>0,'bucket'=>'defunct','founded'=>'Oct 2006','hubs'=>'Brisbane International (BNE / YBBN)','legal'=>'Sky Air World Pty Limited','trading'=>'Sky Air World','web'=>'https://skyairworld.com/'],
    ['name'=>'Skyforce Aviation','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>null,'hubs'=>'','legal'=>null,'trading'=>'Skyforce Aviation','web'=>'https://skyforce.com.au/'],
    ['name'=>'Skyport','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>null,'hubs'=>'Alice Springs (ASP / YBAS)','legal'=>null,'trading'=>'Skyport','web'=>''],
    ['name'=>'Skytraders','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>1,'bucket'=>'active','founded'=>'1979','hubs'=>'Melbourne Tullamarine (MEL / YMML)','legal'=>null,'trading'=>'Skytraders','web'=>'https://skytraders.com.au/'],
    ['name'=>'Skytrans Airlines','iata'=>'QN','icao'=>'SKP','callsign'=>'SKYTRANS','fleet'=>0,'bucket'=>'defunct','founded'=>'May 1980','hubs'=>'Cairns International (CNS / YBCS); Brisbane International (BNE / YBBN)','legal'=>'Skytrans Regional Proprietary Limited','trading'=>'Skytrans Airlines','web'=>'https://skytrans.com.au/'],
    ['name'=>'Skytrans Australia','iata'=>'QN','icao'=>'SKP','callsign'=>'SKYTRANS','fleet'=>10,'bucket'=>'active','founded'=>'23 Dec 2025','hubs'=>'Brisbane International (BNE / YBBN); Cairns International (CNS / YBCS)','legal'=>'Skytrans Australia Propriety Limited','trading'=>'Skytrans Australia','web'=>'https://skytrans.au/'],
    ['name'=>'Skywest Airlines','iata'=>'XR','icao'=>null,'callsign'=>'OZWEST','fleet'=>0,'bucket'=>'defunct','founded'=>'1963','hubs'=>'Perth International (PER / YPPH)','legal'=>'Skywest Airlines Pty Ltd','trading'=>'Skywest Airlines','web'=>'https://skywest.com.au/'],
    ['name'=>'Skywest Aviation','iata'=>'YT','icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>null,'hubs'=>'Perth International (PER / YPPH)','legal'=>'Skywest Aviation Pty Limited','trading'=>'Skywest Aviation','web'=>''],
    ['name'=>'SmartLynx Australia','iata'=>'QN','icao'=>'SKP','callsign'=>'SKYTRANS','fleet'=>0,'bucket'=>'defunct','founded'=>'24 Jun 2025','hubs'=>'Brisbane International (BNE / YBBN); Cairns International (CNS / YBCS)','legal'=>'SmartLynx Australia Propriety Limited','trading'=>'SmartLynx Australia','web'=>'https://smartlynx.au/'],
    ['name'=>'Southern Australia Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'9 Nov 1986','hubs'=>'Mildura (MQL / YMIA)','legal'=>'Southern Australia Airlines Pty Limited','trading'=>'Southern Australia Airlines','web'=>''],
    ['name'=>'Southern Cross International','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'23 Dec 1966','hubs'=>'','legal'=>'Southern Cross International Airways Pty Ltd','trading'=>'Southern Cross International','web'=>''],
    ['name'=>'Strategic Airlines','iata'=>'VC','icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>null,'hubs'=>'','legal'=>null,'trading'=>'Strategic Airlines','web'=>'https://flystrategic.com/'],
    ['name'=>'Sunshine Express Airlines','iata'=>'CQ','icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'13 Jun 1997','hubs'=>'Sunshine Coast (MCY / YBSU)','legal'=>'Sunshine Express Airlines Pty Limited','trading'=>'Sunshine Express Airlines','web'=>'https://sunshineexpress.com.au/'],
    ['name'=>'Sunstate Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>41,'bucket'=>'active','founded'=>'Dec 1981','hubs'=>'Brisbane International (BNE / YBBN); Cairns International (CNS / YBCS)','legal'=>'Sunstate Airlines Pty Limited','trading'=>'Sunstate Airlines','web'=>'https://qantas.com/'],
    ['name'=>'Tasair','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'1965','hubs'=>'Hobart (HBA / YMHB); Devonport (DPO / YDPO)','legal'=>'Tas-Air Propriety Limited','trading'=>'Tasair','web'=>'https://tasair.com.au/'],
    ['name'=>'Tasman Cargo Airlines','iata'=>'HJ','icao'=>'TMN','callsign'=>'TASMAN','fleet'=>3,'bucket'=>'active','founded'=>'1 Oct 2008','hubs'=>'Melbourne Tullamarine (MEL / YMML)','legal'=>'Tasman Cargo Airlines Pty Ltd','trading'=>'Tasman Cargo Airlines','web'=>'https://tasmancargo.com/'],
    ['name'=>'Team Global Express','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>3,'bucket'=>'active','founded'=>'Sep 2022','hubs'=>'','legal'=>'Team Global Express Proprietary Limited','trading'=>'Team Global Express','web'=>'https://teamglobalexp.com/'],
    ['name'=>'Tiger Airways Australia','iata'=>'TT','icao'=>'TGG','callsign'=>'TIGGOZ','fleet'=>0,'bucket'=>'defunct','founded'=>'16 Mar 2007','hubs'=>'Melbourne Tullamarine (MEL / YMML)','legal'=>'Tiger Airways Australia Pty Ltd','trading'=>'Tiger Airways Australia','web'=>''],
    ['name'=>'Tigerair Australia','iata'=>'TT','icao'=>'TGG','callsign'=>'TIGGOZ','fleet'=>0,'bucket'=>'defunct','founded'=>'16 Mar 2007','hubs'=>'Melbourne Tullamarine (MEL / YMML)','legal'=>'Tiger Airways Australia Pty Ltd','trading'=>'Tigerair Australia','web'=>'https://tigerair.com/'],
    ['name'=>'Toll Aviation','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'Feb 2008','hubs'=>'Brisbane International (BNE / YBBN)','legal'=>'Toll Aviation Proprietary Limited','trading'=>'Toll Aviation','web'=>'https://tollgroup.com/'],
    ['name'=>'Torres Strait Air','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>13,'bucket'=>'active','founded'=>'1 Jul 2013','hubs'=>'Horn Island Airport','legal'=>'Torres Strait Air Pty Ltd','trading'=>'Torres Strait Air','web'=>'https://www.torresair.com/'],
    ['name'=>'Trans Australia Airlines (TAA)','iata'=>'TN','icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'8 Feb 1946','hubs'=>'Melbourne Tullamarine (MEL / YMML)','legal'=>'Trans Australia Airlines Limited','trading'=>'Trans Australia Airlines (TAA)','web'=>''],
    ['name'=>'Trans Pacific Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>null,'hubs'=>'Cairns International (CNS / YBCS); Brisbane International (BNE / YBBN)','legal'=>null,'trading'=>'Trans Pacific Airlines','web'=>''],
    ['name'=>'Trans West Airlines','iata'=>'WW','icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'1979','hubs'=>'Perth Jandakot (JAD / YPJT); Carnarvon (CVQ / YCAR)','legal'=>'Trans-West Airlines Pty Limited','trading'=>'Trans West Airlines','web'=>''],
    ['name'=>'Transaustralian Air Express','iata'=>'HW','icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'2000','hubs'=>'Melbourne Tullamarine (MEL / YMML)','legal'=>'Transaustralian Air Express Pty Ltd','trading'=>'Transaustralian Air Express','web'=>''],
    ['name'=>'Transtate Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'1996','hubs'=>'Cairns International (CNS / YBCS)','legal'=>'Transtate Airlines Pty Limited','trading'=>'Transtate Airlines','web'=>''],
    ['name'=>'V Australia','iata'=>'VA','icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'25 Jul 2007','hubs'=>'Sydney Kingsford Smith (SYD / YSSY)','legal'=>'V Australia Airlines Pty Ltd','trading'=>'V Australia','web'=>'https://vaustralia.com.au/'],
    ['name'=>'Vincent Aviation Australia','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>null,'hubs'=>'Darwin International (DRW / YPDN)','legal'=>'Vincent Aviation (Australia) Pty Ltd','trading'=>'Vincent Aviation Australia','web'=>''],
    ['name'=>'Virgin Australia','iata'=>'VA','icao'=>'VOZ','callsign'=>'VELOCITY','fleet'=>109,'bucket'=>'active','founded'=>'4 May 2011','hubs'=>'Brisbane International (BNE / YBBN)','legal'=>'Virgin Australia Airlines Pty Ltd','trading'=>'Virgin Australia','web'=>'https://virginaustralia.com/'],
    ['name'=>'Virgin Australia Regional','iata'=>'XR','icao'=>'VRA','callsign'=>'RAPID','fleet'=>7,'bucket'=>'active','founded'=>'1963','hubs'=>'Perth International (PER / YPPH)','legal'=>'Virgin Australia Regional Airlines Pty Ltd','trading'=>'Virgin Australia Regional','web'=>'https://virginaustralia.com/'],
    ['name'=>'Virgin Blue','iata'=>'DJ','icao'=>'VOZ','callsign'=>'VIRGIN','fleet'=>0,'bucket'=>'defunct','founded'=>'3 Aug 2000','hubs'=>'','legal'=>'Virgin Blue Airlines Pty Ltd','trading'=>'Virgin Blue','web'=>'https://virginblue.com.au/'],
    ['name'=>'Whitaker Air Charter','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>null,'hubs'=>'','legal'=>null,'trading'=>'Whitaker Air Charter','web'=>''],
    ['name'=>'Wings Australia','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>0,'bucket'=>'defunct','founded'=>'Nov 1981','hubs'=>'Melbourne Essendon (MEB / YMEN); Sydney Kingsford Smith (SYD / YSSY)','legal'=>'Wings Australia Proprietary Limited','trading'=>'Wings Australia','web'=>''],
    ['name'=>'Wiseway Cargo Airlines','iata'=>null,'icao'=>null,'callsign'=>null,'fleet'=>null,'bucket'=>'active','founded'=>null,'hubs'=>'','legal'=>null,'trading'=>'Wiseway Cargo Airlines','web'=>'https://www.wiseway.com.au/'],
];

$c = ['updated'=>0, 'inserted'=>0, 'skipped'=>0, 'fixed'=>4];

foreach ($airlines as $a) {
    // Try to find existing by name (exact match) + AU
    $existing = row("SELECT id, iata_code, icao_code, fleet_size, status_bucket, logo_url FROM airlines WHERE name = ? AND country_code = 'AU'", [$a['name']]);
    
    if (!$existing && $a['icao']) {
        // Try by ICAO
        $existing = row("SELECT id, name, iata_code, icao_code, fleet_size, status_bucket, logo_url FROM airlines WHERE icao_code = ? AND country_code = 'AU'", [$a['icao']]);
    }
    
    if ($existing) {
        // Update
        exec_sql("UPDATE airlines SET iata_code=COALESCE(NULLIF(?,''),iata_code), icao_code=COALESCE(NULLIF(?,''),icao_code), callsign=COALESCE(NULLIF(?,''),callsign), fleet_size=?, status_bucket=?, founded=COALESCE(NULLIF(?,''),founded), hubs=COALESCE(NULLIF(?,''),hubs), legal_name=COALESCE(NULLIF(?,''),legal_name), trading_name=COALESCE(NULLIF(?,''),trading_name), website_url=COALESCE(NULLIF(?,''),website_url) WHERE id=?", [
            $a['iata']??'', $a['icao']??'', $a['callsign']??'',
            $a['fleet']!==null ? $a['fleet'] : $existing['fleet_size'],
            $a['bucket'], $a['founded']??'', $a['hubs']??'',
            $a['legal']??'', $a['trading']??'', $a['web']??'',
            $existing['id']
        ]);
        $c['updated']++;
        $log("UPDATED: {$a['name']} (id={$existing['id']}) {$a['iata']}/{$a['icao']} fleet={$a['fleet']} status={$a['bucket']}");
    } else {
        // Insert
        exec_sql("INSERT INTO airlines (name, iata_code, icao_code, callsign, fleet_size, status_bucket, founded, hubs, legal_name, trading_name, website_url, country_code) VALUES (?,?,?,?,?,?,?,?,?,?,?,'AU')", [
            $a['name'], $a['iata'], $a['icao'], $a['callsign'],
            $a['fleet'], $a['bucket'], $a['founded'], $a['hubs'],
            $a['legal'], $a['trading'], $a['web']
        ]);
        $c['inserted']++;
        $log("INSERTED: {$a['name']} ({$a['iata']}/{$a['icao']}) fleet={$a['fleet']} status={$a['bucket']}");
    }
}

// Assign logos for airlines that have matching files
$logos = [
    ['name'=>'Aerlink','file'=>'aerlink.png'],
    ['name'=>'Aeropelican','file'=>'aeropelican-air-services.svg'],
    ['name'=>'AeroRescue','file'=>'aerorescue.png'],
    ['name'=>'Aerotech Australia','file'=>'aerotech-australia.png'],
    ['name'=>'Agile Aviation','file'=>'agile-aviation.png'],
    ['name'=>'Air Australia','file'=>'air-australia.jpg'],
    ['name'=>'Air N.S.W.','file'=>'air-n-s-w.jpg'],
    ['name'=>'Air Queensland','file'=>'air-queensland.png'],
    ['name'=>'Airlines of Tasmania','file'=>'airlines-of-tasmania.jpg'],
    ['name'=>'Airnorth','file'=>'airnorth-regional.jpg'],
    ['name'=>'Alliance Airlines','file'=>'alliance-airlines-australia.svg'],
    ['name'=>'Ansett Airlines','file'=>'ansett-airlines.jpg'],
    ['name'=>'Ansett-ANA','file'=>'ansett-ana.png'],
    ['name'=>'Ansett Australia','file'=>'ansett-australia.png'],
    ['name'=>'Ansett Express','file'=>'ansett-express.jpg'],
    ['name'=>'Ansett N.S.W.','file'=>'ansett-n-s-w.jpg'],
    ['name'=>'Ansett W.A.','file'=>'ansett-wa.jpg'],
    ['name'=>'ASL Airlines Australia','file'=>'asl-airlines-australia.png'],
    ['name'=>'Australian airExpress','file'=>'australian-air-express.png'],
    ['name'=>'Australian Airlines','file'=>'australian-airlines-ao.png'],
    ['name'=>'Australian Regional','file'=>'australian-regional-airlines.png'],
    ['name'=>'Aviair','file'=>'aviair.png'],
    ['name'=>'Brindabella Airlines','file'=>'brindabella-airlines.png'],
    ['name'=>'Charrak Air','file'=>'charrak-air.jpg'],
    ['name'=>'Chartair','file'=>'chartair-australia.png'],
    ['name'=>'Compass Airlines','file'=>'compass-airlines.png'],
    ['name'=>'Corporate Air','file'=>'corporate-air-australia.jpg'],
    ['name'=>'Curry-Kenny Aviation','file'=>'curry-kenny-aviation-group.png'],
    ['name'=>'De Bruin Air','file'=>'de-bruin-air.png'],
    ['name'=>'East-West Airlines','file'=>'east-west-airlines-australia.png'],
    ['name'=>'Eastern Australia Airlines','file'=>'eastern-australia-airlines.png'],
    ['name'=>'Express Freighters','file'=>'express-freighters.jpg'],
    ['name'=>'Field Air','file'=>'field-air.png'],
    ['name'=>'Flight West Airlines','file'=>'flight-west-airlines.png'],
    ['name'=>'FlyPelican','file'=>'flypelican.png'],
    ['name'=>'Hallmarc Aviation','file'=>'hallmarc-aviation.webp'],
    ['name'=>'Hardy Aviation','file'=>'hardy-aviation.png'],
    ['name'=>'HeavyLift Cargo Airlines','file'=>'heavylift-cargo-airlines-australia.png'],
    ['name'=>'Hevilift Australia','file'=>'hevilift-australia.jpg'],
    ['name'=>'Impulse Airlines','file'=>'impulse-airlines.jpg'],
    ['name'=>'Indian Ocean Airlines','file'=>'indian-ocean-airlines.jpg'],
    ['name'=>'Jetcraft Aviation','file'=>'jetcraft-aviation.png'],
    ['name'=>'JetGo Australia','file'=>'jetgo-australia.png'],
    ['name'=>'Jetstar Airways','file'=>'jetstar-airways.svg'],
    ['name'=>'Karratha Flying Service','file'=>'karratha-flying-service.png'],
    ['name'=>'Kendell Airlines','file'=>'kendell-airlines.png'],
    ['name'=>'LifeFlight Rescue','file'=>'lifeflight-rescue.png'],
    ['name'=>'Link Airways','file'=>'link-airways.png'],
    ['name'=>'Lloyd Aviation','file'=>'lloyd-aviation-jet-charter.png'],
    ['name'=>'MacAir Airlines','file'=>'macair-airlines.png'],
    ['name'=>'MacRobertson Miller Airlines','file'=>'macrobertson-miller-airlines.gif'],
    ['name'=>'Maroomba Airlines','file'=>'maroomba-airlines.png'],
    ['name'=>'Maxem Aviation','file'=>'maxem-aviation.gif'],
    ['name'=>'MinRes Air','file'=>'minres-air.png'],
    ['name'=>'Murray Valley Airlines','file'=>'murray-valley-airlines_cd29c3.png'],
    ['name'=>'National Jet Express','file'=>'national-jet-express.png'],
    ['name'=>'National Jet Systems','file'=>'national-jet-systems.png'],
    ['name'=>'Network Aviation','file'=>'network-aviation.png'],
    ['name'=>'Nexus Airlines','file'=>'nexus-airlines.png'],
    ['name'=>'Northern Territory Aerial Services','file'=>'northern-territory-aerial-services.png'],
    ['name'=>'O\'Connor Airlines','file'=>'oconnor-airlines.png'],
    ['name'=>'Pacific Air Express','file'=>'pacific-air-express.jpg'],
    ['name'=>'Pearl Aviation','file'=>'pearl-aviation.png'],
    ['name'=>'Pionair Australia','file'=>'pionair-australia.png'],
    ['name'=>'RACQ LifeFlight Rescue','file'=>'racq-lifeflight-rescue.png'],
    ['name'=>'Regional Pacific Airlines','file'=>'regional-pacific-airlines.png'],
    ['name'=>'Rex Airlines','file'=>'rex-airlines.png'],
    ['name'=>'Rossair Charter','file'=>'rossair-charter.png'],
    ['name'=>'Seair Pacific','file'=>'seair-pacific.jpg'],
    ['name'=>'Skippers Aviation','file'=>'skippers-aviation.jpg'],
    ['name'=>'Sky Air World','file'=>'sky-air-world.png'],
    ['name'=>'Skytraders','file'=>'skytraders.png'],
    ['name'=>'Skytrans Airlines','file'=>'skytrans-airlines.png'],
    ['name'=>'Skytrans Australia','file'=>'skytrans-australia.svg'],
    ['name'=>'Skywest Airlines','file'=>'skywest-airlines-australia.png'],
    ['name'=>'SmartLynx Australia','file'=>'smartlynx-australia.svg'],
    ['name'=>'Southern Australia Airlines','file'=>'southern-australia-airlines.jpg'],
    ['name'=>'Strategic Airlines','file'=>'strategic-airlines.png'],
    ['name'=>'Sunshine Express Airlines','file'=>'sunshine-express-airlines.jpg'],
    ['name'=>'Tasair','file'=>'tasair.png'],
    ['name'=>'Tasman Cargo Airlines','file'=>'tasman-cargo-airline.svg'],
    ['name'=>'Team Global Express','file'=>'team-global-express.png'],
    ['name'=>'Tiger Airways Australia','file'=>'tiger-airways-australia.png'],
    ['name'=>'Tigerair Australia','file'=>'tigerair-australia.gif'],
    ['name'=>'Toll Aviation','file'=>'toll-airline.png'],
    ['name'=>'Torres Strait Air','file'=>'torres-strait-air.png'],
    ['name'=>'Trans Australia Airlines (TAA)','file'=>'trans-australia-airlines.png'],
    ['name'=>'V Australia','file'=>'v-australia.png'],
    ['name'=>'Vincent Aviation Australia','file'=>'vincent-aviation-australia.png'],
    ['name'=>'Virgin Australia','file'=>'virgin-australia_.svg'],
    ['name'=>'Virgin Australia Regional','file'=>'virgin-australia-regional.svg'],
    ['name'=>'Virgin Blue','file'=>'virgin-blue.jpg'],
    ['name'=>'Wiseway Cargo Airlines','file'=>'wiseway-cargo-airlines.png'],
];
$lc = 0;
foreach ($logos as $l) {
    // Try exact name match
    $r = row("SELECT id, logo_url FROM airlines WHERE name = ? AND country_code = 'AU'", [$l['name']]);
    if ($r && !$r['logo_url']) {
        exec_sql("UPDATE airlines SET logo_url = 'assets/airline_logos/{$l['file']}' WHERE id = ?", [$r['id']]);
        $log("LOGO: {$l['name']} (id={$r['id']}) -> {$l['file']}");
        $lc++;
    }
}
$log("=== Done! Updated: {$c['updated']}, Inserted: {$c['inserted']}, Fixed country: {$c['fixed']}, Logos: $lc ===");
