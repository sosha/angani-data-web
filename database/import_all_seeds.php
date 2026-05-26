<?php
/**
 * CLI seed importer for Angani Data.
 *
 * Usage from the app root:
 *   php database/import_all_seeds.php
 *
 * It reads includes/config.php and imports every SQL file in database/seeds/
 * in filename order. Seed files are already split by table/category and kept
 * below 1MB for cPanel/phpMyAdmin-friendly handling.
 */
if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit("This importer must be run from the command line.\n");
}

$root = dirname(__DIR__);
$configFile = $root . '/includes/config.php';

if (!file_exists($configFile)) {
    fwrite(STDERR, "Missing config file: {$configFile}\n");
    exit(1);
}

$config = require $configFile;
$dsn = sprintf(
    'mysql:host=%s;port=%s;dbname=%s;charset=%s',
    $config['host'] ?? '127.0.0.1',
    $config['port'] ?? '3306',
    $config['database'] ?? 'angani_data',
    $config['charset'] ?? 'utf8mb4'
);

try {
    $pdo = new PDO($dsn, $config['username'] ?? 'root', $config['password'] ?? '', [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::MYSQL_ATTR_MULTI_STATEMENTS => true,
    ]);
} catch (Throwable $e) {
    fwrite(STDERR, "Database connection failed: " . $e->getMessage() . "\n");
    exit(1);
}

$files = glob($root . '/database/seeds/*.sql');
sort($files, SORT_NATURAL);

if (!$files) {
    fwrite(STDERR, "No seed files found in database/seeds.\n");
    exit(1);
}

foreach ($files as $file) {
    echo 'Importing ' . basename($file) . "...\n";
    $sql = file_get_contents($file);
    if ($sql === false) {
        fwrite(STDERR, "Could not read {$file}\n");
        exit(1);
    }
    try {
        $pdo->exec($sql);
    } catch (Throwable $e) {
        fwrite(STDERR, "Failed while importing " . basename($file) . ': ' . $e->getMessage() . "\n");
        exit(1);
    }
}

echo "All seed files imported successfully.\n";
