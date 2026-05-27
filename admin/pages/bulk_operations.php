<?php
session_start();
require dirname(__DIR__, 2) . '/includes/db.php';
require dirname(__DIR__, 2) . '/includes/functions.php';
if (!is_admin()) {
    http_response_code(403);
    echo '<!doctype html><meta charset="utf-8"><link rel="stylesheet" href="../../css/styles.css"><main id="app"><div class="empty-state"><h2>Admin only</h2><p>Log in as an administrator before using bulk operations.</p><p><a class="btn ink" href="../../index.php?page=login">Log in</a></p></div></main>';
    exit;
}
$message = '';
if (isset($_POST['export_table'])) {
    $table = preg_replace('/[^a-zA-Z0-9_]/', '', $_POST['export_table']);
    $allowed = array_map(fn($t)=>array_values($t)[0], rows('SHOW TABLES'));
    if (!in_array($table, $allowed, true)) die('Invalid table');
    header('Content-Type: text/csv');
    header('Content-Disposition: attachment; filename="'.$table.'.csv"');
    $out = fopen('php://output', 'w');
    $data = rows("SELECT * FROM `$table` LIMIT 50000");
    if ($data) { fputcsv($out, array_keys($data[0])); foreach ($data as $row) fputcsv($out, $row); }
    exit;
}
$tables = array_map(fn($t)=>array_values($t)[0], rows('SHOW TABLES'));
?><!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Bulk Operations — Angani Data</title><link rel="stylesheet" href="../../css/styles.css"></head><body><main id="app"><a class="btn ghost" href="../../index.php?page=admin">← Back to admin</a><section class="section-head"><div><div class="eyebrow">Admin utility</div><h2>Bulk operations</h2></div><p>Lightweight table export utility. For imports, use the validated CLI importer until per-table validators are built.</p></section><div class="panel"><h3>Export a table</h3><form method="post" class="admin-form compact"><?=csrf_field()?><select name="export_table"><?php foreach($tables as $t): ?><option value="<?=e($t)?>"><?=e($t)?></option><?php endforeach; ?></select><button class="btn ink">Download CSV</button></form></div><section class="section-head"><div><div class="eyebrow">Tables</div><h2>Current schema</h2></div></section><div class="card-grid"><?php foreach($tables as $t): $count=(int)scalar("SELECT COUNT(*) FROM `$t`"); ?><article class="record-card"><div class="topline"><span class="chip gold">Table</span><span class="chip"><?=nfmt($count)?> rows</span></div><h3><?=e($t)?></h3></article><?php endforeach; ?></div></main></body></html>
