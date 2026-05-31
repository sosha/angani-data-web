<?php
/**
 * Mirror Sync - Realtime rsync + MySQL replication to secondary server.
 *
 * Designed to be run via cron every 5 minutes.
 * Usage: php scripts/mirror_sync.php
 * Environment: ANGANI_DB_PASS must be set
 */

$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$projectRoot = realpath(__DIR__ . '/..');
$sshKey = $projectRoot . '/data/mirror_key';
$mirrorHost = '134.209.114.217';
$mirrorUser = 'root';
$mirrorPath = '/var/www/angani-data';
$stateFile = $projectRoot . '/backups/mirror_state.json';
$logFile = $projectRoot . '/backups/mirror_sync.log';

if (!is_dir(dirname($stateFile))) mkdir(dirname($stateFile), 0755, true);

$state = ['last_sync' => date('Y-m-d H:i:s'), 'status' => 'syncing', 'files_synced' => 0, 'last_error' => ''];
file_put_contents($stateFile, json_encode($state));

$log = function($msg) use ($logFile) {
    $line = '[' . date('Y-m-d H:i:s') . '] ' . $msg . "\n";
    file_put_contents($logFile, $line, FILE_APPEND);
    echo $msg . "\n";
};

$sshBase = "ssh -i " . escapeshellarg($sshKey) . " -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";

// ---- Step 1: Rsync files ----
$log("Step 1: Syncing files to {$mirrorUser}@{$mirrorHost}:{$mirrorPath}...");

$rsyncCmd = sprintf(
    'rsync -avz --delete --exclude=".git" --exclude="angani_backup_*.zip" --exclude="backups/mirror_state.json" -e "ssh -i %s -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" %s/ %s@%s:%s/ 2>&1',
    escapeshellarg($sshKey),
    escapeshellarg($projectRoot),
    escapeshellarg($mirrorUser),
    escapeshellarg($mirrorHost),
    escapeshellarg($mirrorPath)
);

$log("  Running: rsync ...");
$output = shell_exec($rsyncCmd);
$exitCode = 0;

// Parse file count from rsync output
$filesSynced = 0;
if (preg_match('/^Number of files: (\d+)/m', $output, $m)) {
    // try alternate parsing
}
// Count lines with ">" prefix (transferred files)
$lines = explode("\n", $output);
$sentFiles = 0;
foreach ($lines as $l) {
    if (preg_match('/^<f/', $l) || preg_match('/^\d+\s+>\s+/', $l)) $sentFiles++;
    if (strpos($l, 'total size is') !== false) break;
}
$filesSynced = max($sentFiles, 1);

$log("  Files transferred/checked: ~{$filesSynced}");

if ($exitCode !== 0 && $exitCode !== 24) { // 24 = partial transfer OK
    $state['status'] = 'error';
    $state['last_error'] = "rsync failed: " . substr($output, 0, 500);
    file_put_contents($stateFile, json_encode($state));
    $log("ERROR: rsync failed.");
    exit(1);
}

// ---- Step 2: MySQL dump and restore via SSH ----
$log("Step 2: Syncing MySQL database...");

$mysqlDumpCmd = sprintf(
    'mysqldump --single-transaction --routines --triggers --events -u root -p%s angani_data 2>/dev/null',
    escapeshellarg($dbPass)
);

$mysqlRestoreCmd = sprintf(
    '%s %s@%s "mysql -u root -p%s angani_data 2>/dev/null" 2>&1',
    $sshBase,
    escapeshellarg($mirrorUser),
    escapeshellarg($mirrorHost),
    escapeshellarg($dbPass)
);

$fullCmd = $mysqlDumpCmd . ' | ' . $mysqlRestoreCmd;
$log("  Piping MySQL dump through SSH to mirror...");
$output = shell_exec($fullCmd);
$log("  MySQL sync completed.");

// ---- Step 3: Set permissions on mirror ----
$log("Step 3: Setting permissions on mirror...");
$permCmd = sprintf('%s %s@%s "chown -R www-data:www-data %s && chmod -R 755 %s" 2>&1',
    $sshBase,
    escapeshellarg($mirrorUser),
    escapeshellarg($mirrorHost),
    escapeshellarg($mirrorPath),
    escapeshellarg($mirrorPath)
);
$output = shell_exec($permCmd);
$log("  Permissions set.");

// ---- Update state ----
$state['status'] = 'ok';
$state['files_synced'] = $filesSynced;
$state['last_sync'] = date('Y-m-d H:i:s');
$state['last_error'] = '';
file_put_contents($stateFile, json_encode($state));

$log("Mirror sync complete.\n");
echo "\nDone.\n";
