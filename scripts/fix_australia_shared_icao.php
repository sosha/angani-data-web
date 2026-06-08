<?php
require_once __DIR__ . '/../includes/db.php';
$log=fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/fix_australia_shared_icao.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);
$db=db();
$log("=== Fixing Australia shared-ICAO conflicts ===");

// 1. Skytrans id=8519 is correct as defunct Skytrans Airlines
// But Skytrans Australia (active 2025, QN/SKP) needs a separate record
// And SmartLynx Australia (defunct 2025, QN/SKP) too
// Skytrans id=5192 (no callsign) also exists - update it

// Check what id=8519 currently is
$r = row("SELECT id, name, iata_code, icao_code, fleet_size, status_bucket FROM airlines WHERE id=8519");
$log("id=8519 is: {$r['name']} fleet={$r['fleet_size']} status={$r['status_bucket']}");

// Fix: id=5192 already had Skytrans (QN/SKP) - update it to Skytrans Airlines (defunct original)
exec_sql("UPDATE airlines SET name='Skytrans Airlines', callsign='SKYTRANS', status_bucket='defunct', founded='May 1980', fleet_size=0 WHERE id=5192");
$log("FIXED: id=5192 Skytrans -> Skytrans Airlines (defunct, 0 fleet)");

// Fix id=8519 to be Skytrans Australia (active, 2025, 10 fleet)
exec_sql("UPDATE airlines SET name='Skytrans Australia', status_bucket='active', founded='23 Dec 2025', fleet_size=10, hubs='Brisbane International (BNE / YBBN); Cairns International (CNS / YBCS)' WHERE id=8519");
$log("FIXED: id=8519 -> Skytrans Australia (active, 10 fleet)");

// Insert SmartLynx Australia as new record
exec_sql("INSERT INTO airlines (name, iata_code, icao_code, callsign, fleet_size, status_bucket, founded, hubs, country_code) VALUES ('SmartLynx Australia','QN','SKP','SKYTRANS',0,'defunct','24 Jun 2025','Brisbane International (BNE / YBBN); Cairns International (CNS / YBCS)','AU')");
$log("INSERTED: SmartLynx Australia");

// 2. Virgin Australia id=8540 was overwritten by Virgin Blue. Restore Virgin Australia.
exec_sql("UPDATE airlines SET name='Virgin Australia', iata_code='VA', icao_code='VOZ', callsign='VELOCITY', fleet_size=109, status_bucket='active', founded='4 May 2011', hubs='Brisbane International (BNE / YBBN)', legal_name='Virgin Australia Airlines Pty Ltd', trading_name='Virgin Australia', website_url='https://virginaustralia.com/' WHERE id=8540");
$log("FIXED: id=8540 -> Virgin Australia (active, 109 fleet)");

// Insert Virgin Blue as new record
exec_sql("INSERT INTO airlines (name, iata_code, icao_code, callsign, fleet_size, status_bucket, founded, country_code) VALUES ('Virgin Blue','DJ','VOZ','VIRGIN',0,'defunct','3 Aug 2000','AU')");
$log("INSERTED: Virgin Blue");

$log("=== Done fixing shared-ICAO records ===");
