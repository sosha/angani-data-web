#!/usr/bin/env php
<?php
/**
 * Angani Data Phase 5 QA checker.
 * Runs static readiness checks without requiring MySQL, and optional DB checks with --db.
 */
$root = realpath(__DIR__ . '/..');
require_once $root . '/includes/modules.php';
require_once $root . '/scripts/importers/DatasetMap.php';

$checks = [];
function qa_add(array &$checks, string $name, bool $pass, string $detail = ''): void {
    $checks[] = ['name'=>$name, 'pass'=>$pass, 'detail'=>$detail];
}
function qa_split_top(string $s): array {
    $out = []; $curr = ''; $depth = 0; $quote = null; $esc = false;
    $len = strlen($s);
    for ($i=0; $i<$len; $i++) {
        $ch = $s[$i];
        if ($quote !== null) {
            $curr .= $ch;
            if ($ch === $quote && !$esc) $quote = null;
            $esc = ($ch === '\\' && !$esc);
            continue;
        }
        if ($ch === "'" || $ch === '`' || $ch === '"') { $quote = $ch; $curr .= $ch; continue; }
        if ($ch === '(') { $depth++; $curr .= $ch; continue; }
        if ($ch === ')') { $depth--; $curr .= $ch; continue; }
        if ($ch === ',' && $depth === 0) { $out[] = trim($curr); $curr = ''; continue; }
        $curr .= $ch;
    }
    if (trim($curr) !== '') $out[] = trim($curr);
    return $out;
}
function qa_schema_columns(string $schema): array {
    $columns = [];
    if (preg_match_all('/CREATE TABLE(?: IF NOT EXISTS)?\s+`?([a-zA-Z0-9_]+)`?\s*\((.*?)\)\s*ENGINE/is', $schema, $matches, PREG_SET_ORDER)) {
        foreach ($matches as $m) {
            $table = $m[1]; $cols = [];
            foreach (qa_split_top($m[2]) as $part) {
                if (preg_match('/^`?([a-zA-Z0-9_]+)`?\s+/', $part, $cm)) {
                    $name = strtoupper($cm[1]);
                    if (!in_array($name, ['PRIMARY','UNIQUE','INDEX','KEY','FULLTEXT','CONSTRAINT','FOREIGN'], true)) $cols[] = $cm[1];
                }
            }
            $columns[$table] = array_flip($cols);
        }
    }
    return $columns;
}
$schemaFile = $root . '/database/01_schema.sql';
$schema = is_file($schemaFile) ? file_get_contents($schemaFile) : '';
$columns = qa_schema_columns((string)$schema);
qa_add($checks, 'Schema file exists', is_file($schemaFile), 'database/01_schema.sql');
qa_add($checks, 'Schema tables detected', count($columns) >= 70, count($columns) . ' tables detected');

$mods = modules();
$missingTables = [];
$missingFields = [];
foreach ($mods as $key => $cfg) {
    $table = $cfg['table'] ?? '';
    if (!isset($columns[$table])) { $missingTables[] = "$key → $table"; continue; }
    foreach (['fields','list','detail','search'] as $group) {
        foreach (($cfg[$group] ?? []) as $field) {
            if (!isset($columns[$table][$field])) $missingFields[] = "$key.$group.$field";
        }
    }
}
qa_add($checks, 'All configured module tables exist', count($missingTables) === 0, $missingTables ? implode('; ', array_slice($missingTables,0,5)) : count($mods) . ' modules checked');
qa_add($checks, 'All configured module fields exist', count($missingFields) === 0, $missingFields ? implode('; ', array_slice($missingFields,0,5)) : 'No field mismatches');

$badTiers = [];
foreach ($mods as $key => $cfg) {
    if (!in_array($cfg['tier'] ?? 'free', ['free','pro','enterprise'], true)) $badTiers[] = $key;
}
qa_add($checks, 'Modules use only Free / Pro / Enterprise tiers', count($badTiers) === 0, $badTiers ? implode(', ', $badTiers) : '3-tier model enforced in module config');

$badPublicFields = [];
$internal = ['id','uuid','source_id','source_record_id','source_scope','fields_json','row_json','headers_json','raw_text','raw_hash','import_batch_id','dataset_file_id','created_at','updated_at','deleted_at','date_added','date_modified','data_source','record_status','source_file','source_url','created_by','screenshot_path'];
foreach ($mods as $key => $cfg) {
    if (in_array($key, ['dataset_files','source_records','change_log','import_batches','staging_records','export_logs'], true)) continue;
    foreach (($cfg['list'] ?? []) as $field) {
        $publicBusinessIds = ['fare_id','source_notam_id','model_id'];
        if (in_array($field, $internal, true) || (str_ends_with($field, '_id') && !in_array($field, $publicBusinessIds, true))) $badPublicFields[] = "$key.$field";
    }
}
qa_add($checks, 'Public listings hide internal fields', count($badPublicFields) === 0, $badPublicFields ? implode('; ', array_slice($badPublicFields,0,8)) : 'No internal fields in list configs');

$seedDir = $root . '/database/seeds';
$seedFiles = glob($seedDir . '/*.sql') ?: [];
$largeSeeds = [];
foreach ($seedFiles as $file) if (filesize($file) > 1024*1024) $largeSeeds[] = basename($file) . ' (' . filesize($file) . ')';
qa_add($checks, 'Seed files exist', count($seedFiles) > 0, count($seedFiles) . ' seed files');
qa_add($checks, 'No seed file exceeds 1MB', count($largeSeeds) === 0, $largeSeeds ? implode('; ', $largeSeeds) : 'All seed files under 1MB');

$insertIssues = []; $insertCount = 0;
foreach ($seedFiles as $file) {
    $txt = file_get_contents($file);
    if (preg_match_all('/INSERT\s+INTO\s+`?([a-zA-Z0-9_]+)`?\s*\((.*?)\)\s*VALUES/is', (string)$txt, $imatches, PREG_SET_ORDER)) {
        foreach ($imatches as $m) {
            $insertCount++;
            $table = $m[1];
            if (!isset($columns[$table])) { $insertIssues[] = basename($file) . ": missing table $table"; continue; }
            foreach (explode(',', $m[2]) as $rawCol) {
                $col = trim($rawCol, " `\t\n\r\0\x0B");
                if ($col !== '' && !isset($columns[$table][$col])) $insertIssues[] = basename($file) . ": $table.$col";
            }
        }
    }
}
qa_add($checks, 'Seed INSERT statements match schema columns', count($insertIssues) === 0, $insertIssues ? implode('; ', array_slice($insertIssues,0,10)) : $insertCount . ' INSERT blocks checked');

$globalFiles = glob($root . '/data/global/*.csv') ?: [];
$countryZip = $root . '/data/countries/countries.zip';
qa_add($checks, 'Global CSV source folder present', count($globalFiles) >= 20, count($globalFiles) . ' CSV files found');
qa_add($checks, 'Country ZIP source present', is_file($countryZip), 'data/countries/countries.zip');
qa_add($checks, 'Country ZIP importer has available ZIP reader', class_exists('ZipArchive') || trim((string)shell_exec('command -v unzip 2>/dev/null')) !== '', class_exists('ZipArchive') ? 'PHP ZipArchive available' : 'System unzip fallback available');

$groups = array_keys(phase4_dataset_groups());
$globalMap = phase4_global_map();
$countryMap = phase4_country_map();
$missingMappedGlobal = [];
foreach ($globalMap as $file => $cfg) if (!is_file($root . '/data/global/' . $file)) $missingMappedGlobal[] = $file;
qa_add($checks, 'Importer groups configured', count($groups) === 8, implode(', ', $groups));
qa_add($checks, 'Global importer maps have matching source files', count($missingMappedGlobal) === 0, $missingMappedGlobal ? implode(', ', $missingMappedGlobal) : count($globalMap) . ' mapped files');
qa_add($checks, 'Country importer maps configured', count($countryMap) >= 40, count($countryMap) . ' country dataset mappings');

$phpFiles = array_merge(glob($root . '/*.php') ?: [], glob($root . '/includes/*.php') ?: [], glob($root . '/scripts/*.php') ?: [], glob($root . '/scripts/importers/*.php') ?: [], glob($root . '/admin/pages/*.php') ?: []);
qa_add($checks, 'PHP file set detected for linting', count($phpFiles) >= 8, count($phpFiles) . ' PHP files');

if (in_array('--db', $argv, true)) {
    try {
        require_once $root . '/includes/db.php';
        $pdo = db();
        $dbCounts = [];
        foreach (['users','subscription_tiers','airlines','airports','aircraft_types','dataset_files'] as $table) {
            $dbCounts[] = $table . '=' . (int)$pdo->query('SELECT COUNT(*) FROM `' . $table . '`')->fetchColumn();
        }
        qa_add($checks, 'Database connection and core table counts', true, implode(', ', $dbCounts));
    } catch (Throwable $e) {
        qa_add($checks, 'Database connection and core table counts', false, $e->getMessage());
    }
}

$passed = 0;
foreach ($checks as $check) if ($check['pass']) $passed++;
$total = count($checks);
foreach ($checks as $check) {
    echo ($check['pass'] ? '[PASS] ' : '[FAIL] ') . $check['name'];
    if ($check['detail'] !== '') echo ' — ' . $check['detail'];
    echo PHP_EOL;
}
echo "\nSummary: {$passed}/{$total} checks passed" . PHP_EOL;
exit($passed === $total ? 0 : 1);
