<?php
/**
 * Backup Engine - Creates numbered zip backups (100MB max each).
 *
 * Exports:
 *   1. MySQL database dump
 *   2. All project files
 *
 * Output: angani_backup_001.zip, angani_backup_002.zip … in project root.
 *
 * Usage: php scripts/backup_engine.php
 * Environment: ANGANI_DB_PASS must be set
 */

$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$projectRoot = realpath(__DIR__ . '/..');
$maxSize = 100 * 1024 * 1024; // 100 MB
$prefix = 'angani_backup_';

// ---- Step 1: MySQL dump ----
echo "Step 1: Exporting MySQL database...\n";
$sqlFile = $projectRoot . '/angani_backup_mysql.sql';
$cmd = sprintf(
    'mysqldump --single-transaction --routines --triggers --events -u root -p%s angani_data > %s 2>&1',
    escapeshellarg($dbPass),
    escapeshellarg($sqlFile)
);
$output = shell_exec($cmd);
if (!file_exists($sqlFile) || filesize($sqlFile) === 0) {
    fwrite(STDERR, "ERROR: MySQL dump failed.\n");
    if ($output) fwrite(STDERR, $output . "\n");
    exit(1);
}
echo "  MySQL dump: " . number_format(filesize($sqlFile)) . " bytes\n";

// ---- Step 2: Collect files ----
echo "Step 2: Scanning project files...\n";

$excludePatterns = [
    '/\.git/', '/angani_backup_\d+\.zip$/', '/angani_backup_mysql\.sql$/',
    '/node_modules/', '/\.idea/', '/\.vscode/', '/\.DS_Store/',
];

$files = [];
$iterator = new RecursiveIteratorIterator(
    new RecursiveDirectoryIterator($projectRoot, RecursiveDirectoryIterator::SKIP_DOTS)
);
foreach ($iterator as $path => $fileInfo) {
    if (!$fileInfo->isFile()) continue;
    $rel = str_replace($projectRoot . DIRECTORY_SEPARATOR, '', $path);
    $rel = str_replace('\\', '/', $rel);
    $skip = false;
    foreach ($excludePatterns as $p) {
        if (preg_match($p, $rel)) { $skip = true; break; }
    }
    if ($skip) continue;
    $files[] = ['path' => $path, 'relative' => $rel, 'size' => $fileInfo->getSize()];
}
echo "  Found " . count($files) . " files to back up.\n";

// ---- Step 3: Remove old backups ----
echo "Step 3: Removing old backup zips...\n";
foreach (glob($projectRoot . '/' . $prefix . '*.zip') as $oldZip) {
    unlink($oldZip);
    echo "  Removed: " . basename($oldZip) . "\n";
}

// ---- Step 4: Create zip volumes ----
echo "Step 4: Creating backup volumes (max " . ($maxSize / 1024 / 1024) . " MB each)...\n";

$volumeIndex = 1;
$currentZip = null;
$currentSize = 0;
$currentFiles = [];

$addToVolume = function($filePath, $relativePath) use (&$currentZip, &$currentSize, &$currentFiles, $maxSize) {
    $fileSize = filesize($filePath);
    if ($fileSize === false) return false;

    // If adding this file exceeds limit, close current volume and start new one
    if ($currentZip !== null && ($currentSize + $fileSize) > $maxSize) {
        $currentZip->close();
        $currentZip = null;
    }

    if ($currentZip === null) {
        $currentZip = new ZipArchive();
        $zipPath = $GLOBALS['projectRoot'] . '/' . $GLOBALS['prefix'] . str_pad($GLOBALS['volumeIndex'], 3, '0', STR_PAD_LEFT) . '.zip';
        if ($currentZip->open($zipPath, ZipArchive::CREATE) !== true) {
            fwrite(STDERR, "ERROR: Cannot create zip: $zipPath\n");
            exit(1);
        }
        $GLOBALS['volumeIndex']++;
        $currentSize = 0;
        echo "  Creating volume: " . basename($zipPath) . "\n";
    }

    $currentZip->addFile($filePath, $relativePath);
    $currentSize += $fileSize;
    return true;
};

foreach ($files as $f) {
    $addToVolume($f['path'], $f['relative']);
}
if ($currentZip !== null) $currentZip->close();

// ---- Step 5: Clean up SQL dump ----
unlink($sqlFile);

// ---- Summary ----
$finalZips = glob($projectRoot . '/' . $prefix . '*.zip');
$totalSize = 0;
echo "\n--- Backup Complete ---\n";
echo "Volumes created: " . count($finalZips) . "\n";
foreach ($finalZips as $z) {
    $s = filesize($z);
    $totalSize += $s;
    echo "  " . basename($z) . " — " . number_format($s) . " bytes\n";
}
echo "Total size: " . number_format($totalSize) . " bytes\n";
echo "Files located in: $projectRoot\n";
echo "These will be included in git push.\n";
echo "\nDone.\n";
