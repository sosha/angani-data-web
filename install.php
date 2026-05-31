<?php
/**
 * Angani Data - Restore / Guided Installer
 *
 * Place this script (or the entire project with angani_backup_*.zip files)
 * into a web server document root and open it in a browser.
 *
 * It will guide you through:
 *   1. Detecting backup volumes
 *   2. Extracting files
 *   3. Restoring the MySQL database
 *   4. Configuring the database connection
 */

// --- Boot ---
error_reporting(E_ALL);
ini_set('display_errors', 1);
session_start();

$step = $_GET['step'] ?? 'detect';
$root = __DIR__;
$prefix = 'angani_backup_';
$extractDir = $root . '/_restore_extracted';
$errors = [];
$success = false;

// --- Helpers ---
function e($v) { return htmlspecialchars((string)($v ?? ''), ENT_QUOTES, 'UTF-8'); }

function detectBackupVolumes($root, $prefix) {
    $zips = glob($root . '/' . $prefix . '*.zip');
    sort($zips);
    return $zips;
}

function humanFilesize($bytes) {
    $units = ['B', 'KB', 'MB', 'GB'];
    $i = 0;
    while ($bytes >= 1024 && $i < 3) { $bytes /= 1024; $i++; }
    return round($bytes, 1) . ' ' . $units[$i];
}

// --- Handle POST ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'extract') {
        $zips = detectBackupVolumes($root, $prefix);
        if (empty($zips)) {
            $errors[] = 'No backup volumes found.';
        } else {
            if (!is_dir($extractDir)) mkdir($extractDir, 0755, true);

            foreach ($zips as $zipPath) {
                $zip = new ZipArchive();
                if ($zip->open($zipPath) === true) {
                    $zip->extractTo($extractDir);
                    $zip->close();
                    $_SESSION['extracted'][] = basename($zipPath);
                } else {
                    $errors[] = 'Failed to extract: ' . basename($zipPath);
                }
            }

            // Move extracted files to root (overwrite)
            if (empty($errors)) {
                $extractedItems = scandir($extractDir);
                $count = 0;
                foreach ($extractedItems as $item) {
                    if ($item === '.' || $item === '..') continue;
                    $src = $extractDir . '/' . $item;
                    $dst = $root . '/' . $item;
                    if (is_dir($src)) {
                        exec("cp -rf " . escapeshellarg($src) . " " . escapeshellarg($root) . "/ 2>&1");
                    } else {
                        copy($src, $dst);
                    }
                    $count++;
                }
                $_SESSION['extract_count'] = $count;
                // Clean up extract dir
                exec("rm -rf " . escapeshellarg($extractDir));
                $_SESSION['extract_done'] = true;
                header('Location: ?step=database');
                exit;
            }
        }
    }

    if ($action === 'restore_db') {
        $dbHost = $_POST['db_host'] ?? 'localhost';
        $dbUser = $_POST['db_user'] ?? 'root';
        $dbPassInput = $_POST['db_pass'] ?? '';
        $dbName = $_POST['db_name'] ?? 'angani_data';

        // Find SQL dump
        $sqlFiles = glob($root . '/*.sql');
        $sqlDump = null;
        foreach ($sqlFiles as $f) {
            if (strpos(basename($f), 'angani_backup') !== false) {
                $sqlDump = $f;
                break;
            }
        }

        if (!$sqlDump) {
            $errors[] = 'No SQL dump file found (angani_backup_*.sql).';
        } else {
            // Create database if not exists
            $tempConn = @mysqli_connect($dbHost, $dbUser, $dbPassInput);
            if (!$tempConn) {
                $errors[] = 'Database connection failed: ' . mysqli_connect_error();
            } else {
                mysqli_query($tempConn, "CREATE DATABASE IF NOT EXISTS `$dbName` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
                mysqli_close($tempConn);

                // Import SQL
                $cmd = sprintf(
                    'mysql -h %s -u %s %s %s < %s 2>&1',
                    escapeshellarg($dbHost),
                    escapeshellarg($dbUser),
                    $dbPassInput ? '-p' . escapeshellarg($dbPassInput) : '',
                    escapeshellarg($dbName),
                    escapeshellarg($sqlDump)
                );
                $output = shell_exec($cmd);

                // Also try wp-like config creation
                $configContent = "<?php\nreturn [\n";
                $configContent .= "    'db_host' => '" . addslashes($dbHost) . "',\n";
                $configContent .= "    'db_user' => '" . addslashes($dbUser) . "',\n";
                $configContent .= "    'db_pass' => '" . addslashes($dbPassInput) . "',\n";
                $configContent .= "    'db_name' => '" . addslashes($dbName) . "',\n";
                $configContent .= "];\n";

                // Update config files
                $configPaths = [
                    $root . '/includes/config.php',
                    $root . '/includes/config.local.php',
                ];
                $written = false;
                foreach ($configPaths as $cp) {
                    $dir = dirname($cp);
                    if (!is_dir($dir)) @mkdir($dir, 0755, true);
                    if (file_put_contents($cp, $configContent)) {
                        $written = $cp;
                        break;
                    }
                }

                if ($written) {
                    $_SESSION['db_restored'] = true;
                    $_SESSION['config_file'] = basename($written);
                    header('Location: ?step=complete');
                    exit;
                } else {
                    $errors[] = 'Could not write config file. Check permissions.';
                }
            }
        }
    }
}

// --- Detect step ---
$zips = detectBackupVolumes($root, $prefix);
$extractDone = $_SESSION['extract_done'] ?? false;
$dbRestored = $_SESSION['db_restored'] ?? false;
$extractCount = $_SESSION['extract_count'] ?? 0;
$configFile = $_SESSION['config_file'] ?? '';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Angani Data — Restore / Install</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #0a1628; color: #e0e8f0; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .installer { max-width: 680px; width: 100%; background: #112240; border-radius: 16px; padding: 40px; box-shadow: 0 20px 60px rgba(0,0,0,.5); }
        h1 { font-size: 24px; margin-bottom: 6px; display: flex; align-items: center; gap: 10px; }
        h1 small { font-size: 14px; color: #64ffda; font-weight: 400; }
        .subtitle { color: #8892b0; margin-bottom: 28px; font-size: 14px; }
        .step-indicator { display: flex; gap: 8px; margin-bottom: 28px; }
        .step-dot { width: 32px; height: 4px; border-radius: 2px; background: #233554; }
        .step-dot.active { background: #64ffda; }
        .step-dot.done { background: #26c56b; }
        .card { background: #1a2d4a; border-radius: 12px; padding: 24px; margin-bottom: 20px; }
        .card h2 { font-size: 18px; margin-bottom: 12px; }
        .card p { color: #8892b0; margin-bottom: 16px; font-size: 14px; line-height: 1.6; }
        .file-list { background: #0a1628; border-radius: 8px; padding: 12px 16px; margin-bottom: 16px; font-family: monospace; font-size: 13px; }
        .file-list li { padding: 4px 0; list-style: none; display: flex; justify-content: space-between; }
        .file-list li span { color: #64ffda; }
        label { display: block; margin-bottom: 14px; }
        label span { display: block; font-size: 12px; color: #8892b0; margin-bottom: 4px; text-transform: uppercase; letter-spacing: .5px; }
        input, select { width: 100%; padding: 10px 14px; background: #0a1628; border: 1px solid #233554; border-radius: 8px; color: #e0e8f0; font-size: 14px; }
        input:focus { outline: none; border-color: #64ffda; }
        .btn { display: inline-block; padding: 12px 28px; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; }
        .btn-primary { background: #64ffda; color: #0a1628; }
        .btn-primary:hover { background: #45e0be; }
        .btn-success { background: #26c56b; color: #fff; }
        .error { background: #4a1528; color: #ff6b6b; border-radius: 8px; padding: 12px 16px; margin-bottom: 16px; font-size: 13px; }
        .success-box { text-align: center; padding: 30px 0; }
        .success-box .icon { font-size: 48px; margin-bottom: 16px; }
        .success-box h2 { color: #26c56b; margin-bottom: 8px; }
        .success-box p { color: #8892b0; margin-bottom: 20px; }
        .success-box .links { display: flex; gap: 12px; justify-content: center; flex-wrap: wrap; }
        .glow-green { box-shadow: 0 0 20px rgba(38,197,107,.2); }
        .total-size { text-align: right; font-size: 12px; color: #64ffda; margin-top: 8px; }
    </style>
</head>
<body>
<div class="installer">
    <h1><span>🛡️</span> Angani Data <small>Restore / Install</small></h1>
    <p class="subtitle">Restore your system from a backup archive</p>

    <?php if ($errors): ?>
        <?php foreach ($errors as $err): ?>
            <div class="error"><?= e($err) ?></div>
        <?php endforeach; ?>
    <?php endif; ?>

    <?php if ($step === 'complete' || $dbRestored): ?>
        <?php
        // Clear session
        session_destroy();
        ?>
        <div class="card success-box glow-green">
            <div class="icon">✅</div>
            <h2>Restore Complete!</h2>
            <p>Your system has been restored successfully.</p>
            <div class="links">
                <a href="./" class="btn btn-primary">Go to Homepage</a>
                <a href="admin/" class="btn btn-primary">Go to Admin</a>
                <a href="?step=detect" class="btn" style="background:#233554;color:#e0e8f0">Start Over</a>
            </div>
        </div>

    <?php elseif ($step === 'database' || $extractDone): ?>
        <?php
        $totalSteps = 3;
        $currentStep = 2;
        ?>
        <div class="step-indicator">
            <div class="step-dot done"></div>
            <div class="step-dot active"></div>
            <div class="step-dot"></div>
        </div>
        <div class="card">
            <h2>Step 2: Database Setup</h2>
            <p>Enter your MySQL database credentials to restore the data. A new database will be created if it doesn't exist.</p>
            <form method="post">
                <input type="hidden" name="action" value="restore_db">
                <label><span>Database Host</span><input name="db_host" value="localhost" required></label>
                <label><span>Database User</span><input name="db_user" value="root" required></label>
                <label><span>Database Password</span><input name="db_pass" type="password" placeholder="Leave blank if no password"></label>
                <label><span>Database Name</span><input name="db_name" value="angani_data" required></label>
                <button type="submit" class="btn btn-primary">Restore Database</button>
            </form>
        </div>

    <?php else: ?>
        <?php $totalSteps = 3; $currentStep = 1; ?>
        <div class="step-indicator">
            <div class="step-dot active"></div>
            <div class="step-dot"></div>
            <div class="step-dot"></div>
        </div>
        <div class="card">
            <h2>Step 1: Detect Backup</h2>
            <p>Scanning for backup volumes in the current directory...</p>

            <?php if (empty($zips)): ?>
                <div class="error">No backup volumes found. Upload the <code>angani_backup_*.zip</code> files to this directory.</div>
                <p style="font-size:13px;color:#8892b0">Expected files: <code>angani_backup_001.zip</code>, <code>angani_backup_002.zip</code>, etc.</p>
            <?php else: ?>
                <?php
                $totalSize = 0;
                foreach ($zips as $z) $totalSize += filesize($z);
                ?>
                <div class="file-list">
                    <?php foreach ($zips as $z): $sz = filesize($z); $totalSize += $sz; ?>
                        <li><?= e(basename($z)) ?> <span><?= humanFilesize($sz) ?></span></li>
                    <?php endforeach; ?>
                </div>
                <div class="total-size">Total: <?= humanFilesize($totalSize) ?></div>

                <form method="post">
                    <input type="hidden" name="action" value="extract">
                    <button type="submit" class="btn btn-primary">Extract &amp; Restore Files</button>
                </form>
            <?php endif; ?>
        </div>
    <?php endif; ?>

    <p style="text-align:center;margin-top:20px;font-size:12px;color:#233554">Angani Data — Aviation Intelligence Atlas</p>
</div>
</body>
</html>
