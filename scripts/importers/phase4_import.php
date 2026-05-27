#!/usr/bin/env php
<?php
require_once __DIR__ . '/ImportEngine.php';

function usage(): void {
    $groups = implode(', ', array_keys(phase4_dataset_groups()));
    echo "Angani Data Phase 4 importer\n";
    echo "Usage:\n";
    echo "  php scripts/importers/phase4_import.php --group=all [--mode=append|replace] [--dry-run] [--store-raw=1]\n";
    echo "  php scripts/importers/phase4_import.php --group=country --country=KE\n";
    echo "  php scripts/importers/phase4_import.php --group=aircraft\n";
    echo "\nGroups: all, {$groups}\n";
    echo "Options:\n";
    echo "  --group=NAME       Import group to run.\n";
    echo "  --path=PATH        Override source directory/ZIP.\n";
    echo "  --mode=append      Append rows. Default.\n";
    echo "  --mode=replace     Truncate each target table once before importing.\n";
    echo "  --country=KE       Country-code filter for country ZIP imports.\n";
    echo "  --limit=1000       Stop after N source rows. Useful for tests.\n";
    echo "  --dry-run          Parse and validate without inserting.\n";
    echo "  --store-raw=1      Also store raw rows in dataset_records.\n";
    echo "  --help             Show this help.\n";
}

$options = getopt('', ['group:', 'path::', 'mode::', 'country::', 'limit::', 'dry-run', 'store-raw::', 'help']);
if (isset($options['help']) || !isset($options['group'])) { usage(); exit(isset($options['help']) ? 0 : 1); }

$root = realpath(__DIR__ . '/../..');
$group = (string)$options['group'];
$mode = (string)($options['mode'] ?? 'append');
if (!in_array($mode, ['append','replace'], true)) { fwrite(STDERR, "Invalid --mode. Use append or replace.\n"); exit(1); }

try {
    $pdo = phase4_db_from_config($root);
    $engine = new AnganiImportEngine($pdo, $root, [
        'mode' => $mode,
        'dry_run' => array_key_exists('dry-run', $options),
        'limit' => (int)($options['limit'] ?? 0),
        'country' => $options['country'] ?? null,
        'store_raw' => isset($options['store-raw']) && (string)$options['store-raw'] !== '0',
        'batch_name' => 'Phase 4 CLI importer: ' . $group,
    ]);
    $summary = $engine->run($group, $options['path'] ?? null);
    echo json_encode($summary, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES) . PHP_EOL;
} catch (Throwable $e) {
    fwrite(STDERR, "Import failed: " . $e->getMessage() . PHP_EOL);
    exit(1);
}
