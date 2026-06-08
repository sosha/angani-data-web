<?php
require_once __DIR__ . '/../includes/db.php';
$log=fn($m)=>printf("$m\n").file_put_contents(__DIR__.'/../logs/update_algeria_fleet_details.log','['.date('Y-m-d H:i:s')."] $m\n",FILE_APPEND);
$db=db();
$log("=== Starting Algeria fleet detail updates from saved pages ===");

// Planespotters pages show current fleet (In Service + Parked), not historic totals
// Fix defunct airlines where fleet_size was set to historic total instead of 0

$fixes = [
    [1791, 'Inter Air Services',      3, 0, 'all 3 historic'],
    [1793, 'Khalifa Airways Cargo',   1, 0, 'all 1 historic'],
    [1794, 'Rym Airlines',            2, 0, 'all 2 historic'],
];

$c = 0;
foreach ($fixes as $f) {
    $r = row("SELECT id, fleet_size FROM airlines WHERE id=?", [$f[0]]);
    if ($r && $r['fleet_size'] == $f[2]) {
        exec_sql("UPDATE airlines SET fleet_size=? WHERE id=?", [$f[3], $f[0]]);
        $log("FIXED: {$f[1]} id={$f[0]} fleet_size {$f[2]}->{$f[3]} ({$f[4]})");
        $c++;
    } else {
        $log("SKIP: {$f[1]} id={$f[0]} fleet={$r['fleet_size']} (not {$f[2]})");
    }
}

$log("=== Done! Fixed $c records ===");
