<?php
/**
 * AnganiData — Dataset API
 * JSON API for direct CSV file operations.
 */
header('Content-Type: application/json; charset=utf-8');

// ── Configuration ──────────────────────────────────────────────────────────────
define('DATA_ROOT', realpath(__DIR__ . '/../angani-data/datasets'));

if (!DATA_ROOT || !is_dir(DATA_ROOT)) {
    http_response_code(500);
    echo json_encode(['error' => 'Dataset root not found. Expected ../angani-data/datasets']);
    exit;
}

// ── Security: validate that a requested path is within DATA_ROOT ────────────
function safePath(string $relative): ?string {
    // Normalize separators
    $relative = str_replace('\\', '/', trim($relative, '/'));
    
    // Block obvious traversal attempts
    if (strpos($relative, '..') !== false) return null;
    
    $full = realpath(DATA_ROOT . '/' . $relative);
    if (!$full) return null;
    
    // Must be inside DATA_ROOT
    if (strpos($full, DATA_ROOT) !== 0) return null;
    
    return $full;
}

function safeCSVPath(string $relative): ?string {
    $full = safePath($relative);
    if (!$full) return null;
    if (strtolower(pathinfo($full, PATHINFO_EXTENSION)) !== 'csv') return null;
    return $full;
}

// ── Helpers ─────────────────────────────────────────────────────────────────
function jsonOut($data, int $code = 200) {
    http_response_code($code);
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    exit;
}

function jsonErr(string $msg, int $code = 400) {
    jsonOut(['error' => $msg], $code);
}

// ── Action Router ───────────────────────────────────────────────────────────
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'tree':        actionTree();       break;
    case 'read':        actionRead();       break;
    case 'update':      actionUpdate();     break;
    case 'add':         actionAdd();        break;
    case 'delete':      actionDelete();     break;
    case 'export':      actionExport();     break;
    case 'upload':      actionUpload();     break;
    case 'create':      actionCreate();     break;
    case 'delete_file': actionDeleteFile(); break;
    case 'audit':       actionAudit();      break;
    case 'folders':     actionFolders();    break;
    default:            jsonErr('Unknown action. Use: tree, read, update, add, delete, export, upload, create, delete_file, audit, folders');
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: tree — return directory structure as JSON
// ═══════════════════════════════════════════════════════════════════════════════
function actionTree() {
    $tree = scanDir_recursive(DATA_ROOT, '');
    jsonOut($tree);
}

function scanDir_recursive(string $absDir, string $relPrefix): array {
    $items = [];
    $entries = @scandir($absDir);
    if (!$entries) return $items;

    // Sort: directories first, then files
    $dirs = [];
    $files = [];
    foreach ($entries as $entry) {
        if ($entry === '.' || $entry === '..' || $entry === '.git') continue;
        $abs = $absDir . DIRECTORY_SEPARATOR . $entry;
        $rel = $relPrefix ? $relPrefix . '/' . $entry : $entry;
        if (is_dir($abs)) {
            $dirs[] = ['name' => $entry, 'abs' => $abs, 'rel' => $rel];
        } elseif (strtolower(pathinfo($entry, PATHINFO_EXTENSION)) === 'csv') {
            $files[] = ['name' => $entry, 'abs' => $abs, 'rel' => $rel];
        }
        // Skip non-CSV files (README.md, etc.)
    }

    // Natural sort
    usort($dirs,  fn($a, $b) => strnatcasecmp($a['name'], $b['name']));
    usort($files, fn($a, $b) => strnatcasecmp($a['name'], $b['name']));

    foreach ($dirs as $d) {
        $children = scanDir_recursive($d['abs'], $d['rel']);
        $items[] = [
            'type'     => 'folder',
            'name'     => $d['name'],
            'path'     => $d['rel'],
            'children' => $children,
        ];
    }

    foreach ($files as $f) {
        $size = filesize($f['abs']);
        // Quick line count for preview
        $lineCount = 0;
        if ($size < 5 * 1024 * 1024) { // Only count for files < 5MB
            $lineCount = max(0, count(file($f['abs'])) - 1); // minus header
        }
        $items[] = [
            'type'    => 'file',
            'name'    => $f['name'],
            'path'    => $f['rel'],
            'size'    => $size,
            'records' => $lineCount,
        ];
    }

    return $items;
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: read — return CSV content as JSON (paginated)
// ═══════════════════════════════════════════════════════════════════════════════
function actionRead() {
    $file = $_GET['file'] ?? '';
    $page = max(1, (int)($_GET['page'] ?? 1));
    $perPage = max(10, min(500, (int)($_GET['per_page'] ?? 100)));
    $search = $_GET['search'] ?? '';

    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid or inaccessible CSV file path.');

    $handle = fopen($abs, 'r');
    if (!$handle) jsonErr('Could not open file.');

    // Read header
    $headers = fgetcsv($handle);
    if (!$headers) {
        fclose($handle);
        jsonErr('CSV file is empty or has no headers.');
    }

    // Trim BOM and whitespace from headers
    $headers = array_map(function($h) {
        return trim(preg_replace('/^\x{FEFF}/u', '', $h));
    }, $headers);

    // Read all rows (with optional search filter)
    $allRows = [];
    $lineIndex = 1; // 0 = header
    while (($row = fgetcsv($handle)) !== false) {
        // Pad or trim row to match header count
        $row = array_pad($row, count($headers), '');
        $row = array_slice($row, 0, count($headers));

        if ($search !== '') {
            $match = false;
            foreach ($row as $cell) {
                if (stripos((string)$cell, $search) !== false) {
                    $match = true;
                    break;
                }
            }
            if (!$match) { $lineIndex++; continue; }
        }

        $allRows[] = [
            '_line' => $lineIndex,
            'data'  => $row,
        ];
        $lineIndex++;
    }
    fclose($handle);

    $total = count($allRows);
    $totalPages = max(1, (int)ceil($total / $perPage));
    $page = min($page, $totalPages);
    $offset = ($page - 1) * $perPage;
    $pageRows = array_slice($allRows, $offset, $perPage);

    jsonOut([
        'file'       => $file,
        'headers'    => $headers,
        'rows'       => $pageRows,
        'total'      => $total,
        'page'       => $page,
        'per_page'   => $perPage,
        'totalPages' => $totalPages,
    ]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: update — modify specific rows in a CSV
// ═══════════════════════════════════════════════════════════════════════════════
function actionUpdate() {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') jsonErr('POST required', 405);

    $input = json_decode(file_get_contents('php://input'), true);
    if (!$input) jsonErr('Invalid JSON body.');

    $file = $input['file'] ?? '';
    $changes = $input['changes'] ?? []; // [{line: N, data: [...]}]

    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV path.');
    if (empty($changes)) jsonErr('No changes provided.');

    // Read entire file
    $lines = readCSVFile($abs);
    if ($lines === null) jsonErr('Could not read CSV.');

    // Apply changes
    foreach ($changes as $change) {
        $line = (int)($change['line'] ?? -1);
        $data = $change['data'] ?? null;
        if ($line < 1 || !is_array($data)) continue;
        if (!isset($lines[$line])) continue;
        $lines[$line] = $data;
    }

    // Create backup then write
    backupFile($abs);
    if (!writeCSVFile($abs, $lines)) {
        jsonErr('Failed to write CSV file.', 500);
    }

    jsonOut(['success' => true, 'updated' => count($changes)]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: add — append row(s) to a CSV
// ═══════════════════════════════════════════════════════════════════════════════
function actionAdd() {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') jsonErr('POST required', 405);

    $input = json_decode(file_get_contents('php://input'), true);
    if (!$input) jsonErr('Invalid JSON body.');

    $file = $input['file'] ?? '';
    $rows = $input['rows'] ?? []; // Array of row arrays

    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV path.');
    if (empty($rows)) jsonErr('No rows provided.');

    // Read file
    $lines = readCSVFile($abs);
    if ($lines === null) jsonErr('Could not read CSV.');

    // Append rows
    foreach ($rows as $row) {
        if (is_array($row)) {
            $lines[] = $row;
        }
    }

    backupFile($abs);
    if (!writeCSVFile($abs, $lines)) {
        jsonErr('Failed to write CSV file.', 500);
    }

    jsonOut(['success' => true, 'added' => count($rows), 'total' => count($lines) - 1]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: delete — remove row(s) from a CSV by line index
// ═══════════════════════════════════════════════════════════════════════════════
function actionDelete() {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') jsonErr('POST required', 405);

    $input = json_decode(file_get_contents('php://input'), true);
    if (!$input) jsonErr('Invalid JSON body.');

    $file = $input['file'] ?? '';
    $lineIndices = $input['lines'] ?? []; // Array of line numbers to delete

    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV path.');
    if (empty($lineIndices)) jsonErr('No line indices provided.');

    $lines = readCSVFile($abs);
    if ($lines === null) jsonErr('Could not read CSV.');

    // Remove lines (by key, preserving header at index 0)
    $deleteSet = array_flip(array_map('intval', $lineIndices));
    $newLines = [];
    foreach ($lines as $idx => $row) {
        if ($idx === 0 || !isset($deleteSet[$idx])) {
            $newLines[] = $row;
        }
    }

    backupFile($abs);
    if (!writeCSVFile($abs, $newLines)) {
        jsonErr('Failed to write CSV file.', 500);
    }

    jsonOut(['success' => true, 'deleted' => count($lines) - count($newLines), 'remaining' => count($newLines) - 1]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: export — stream a CSV file as download
// ═══════════════════════════════════════════════════════════════════════════════
function actionExport() {
    $file = $_GET['file'] ?? '';
    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV path.');

    $filename = basename($abs);
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filename . '"');
    header('Content-Length: ' . filesize($abs));
    
    // Remove the JSON content-type we set at the top
    header_remove('Content-Type');
    header('Content-Type: text/csv; charset=utf-8');

    readfile($abs);
    exit;
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: upload — upload a CSV file to a target directory
// ═══════════════════════════════════════════════════════════════════════════════
function actionUpload() {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') jsonErr('POST required', 405);

    $targetDir = $_POST['target_dir'] ?? '';
    if (!$targetDir) jsonErr('target_dir is required.');

    // Validate target directory exists within DATA_ROOT
    $absDir = safePath($targetDir);
    if (!$absDir || !is_dir($absDir)) jsonErr('Target directory does not exist.');

    if (!isset($_FILES['csv_file']) || $_FILES['csv_file']['error'] !== UPLOAD_ERR_OK) {
        jsonErr('No file uploaded or upload error.');
    }

    $uploadedName = basename($_FILES['csv_file']['name']);
    if (strtolower(pathinfo($uploadedName, PATHINFO_EXTENSION)) !== 'csv') {
        jsonErr('Only CSV files are allowed.');
    }

    $destPath = $absDir . DIRECTORY_SEPARATOR . $uploadedName;

    // If file already exists, back it up first
    if (file_exists($destPath)) {
        backupFile($destPath);
    }

    if (!move_uploaded_file($_FILES['csv_file']['tmp_name'], $destPath)) {
        jsonErr('Failed to move uploaded file.', 500);
    }

    // Count records
    $lineCount = max(0, count(file($destPath)) - 1);

    auditLog('UPLOAD', $targetDir . '/' . $uploadedName, "Uploaded $lineCount records");
    jsonOut(['success' => true, 'file' => $targetDir . '/' . $uploadedName, 'records' => $lineCount]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: create — create a new empty CSV with headers
// ═══════════════════════════════════════════════════════════════════════════════
function actionCreate() {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') jsonErr('POST required', 405);

    $input = json_decode(file_get_contents('php://input'), true);
    if (!$input) jsonErr('Invalid JSON body.');

    $filePath = $input['file'] ?? '';
    $headers = $input['headers'] ?? [];

    if (!$filePath) jsonErr('file path is required.');
    if (empty($headers)) jsonErr('headers array is required.');
    if (strtolower(pathinfo($filePath, PATHINFO_EXTENSION)) !== 'csv') jsonErr('File must have .csv extension.');

    // Build absolute path and verify parent directory exists within DATA_ROOT
    $relative = str_replace('\\', '/', trim($filePath, '/'));
    if (strpos($relative, '..') !== false) jsonErr('Invalid path.');
    $abs = DATA_ROOT . '/' . $relative;
    $parentDir = dirname($abs);

    // Verify parent is within DATA_ROOT
    $realParent = realpath($parentDir);
    if (!$realParent || strpos($realParent, DATA_ROOT) !== 0) {
        jsonErr('Parent directory is outside data root.');
    }

    if (file_exists($abs)) jsonErr('File already exists. Use upload to replace.');

    // Write just the header row
    $handle = fopen($abs, 'w');
    if (!$handle) jsonErr('Failed to create file.', 500);
    fputcsv($handle, $headers);
    fclose($handle);

    auditLog('CREATE', $filePath, 'Created with ' . count($headers) . ' columns: ' . implode(', ', $headers));
    jsonOut(['success' => true, 'file' => $filePath, 'headers' => $headers]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: delete_file — delete an entire CSV file (with backup)
// ═══════════════════════════════════════════════════════════════════════════════
function actionDeleteFile() {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') jsonErr('POST required', 405);

    $input = json_decode(file_get_contents('php://input'), true);
    if (!$input) jsonErr('Invalid JSON body.');

    $file = $input['file'] ?? '';
    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV path.');

    // Backup before deleting
    backupFile($abs);

    if (!unlink($abs)) {
        jsonErr('Failed to delete file.', 500);
    }

    auditLog('DELETE_FILE', $file, 'File permanently deleted (backup created)');
    jsonOut(['success' => true, 'deleted' => $file]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: audit — return recent audit log entries
// ═══════════════════════════════════════════════════════════════════════════════
function actionAudit() {
    $limit = max(1, min(500, (int)($_GET['limit'] ?? 50)));
    $auditFile = __DIR__ . '/logs/audit.csv';

    if (!file_exists($auditFile)) {
        jsonOut(['entries' => [], 'total' => 0]);
        return;
    }

    $handle = fopen($auditFile, 'r');
    if (!$handle) jsonErr('Could not read audit log.', 500);

    $headers = fgetcsv($handle);
    $entries = [];
    while (($row = fgetcsv($handle)) !== false) {
        if (count($row) >= 4) {
            $entries[] = [
                'timestamp' => $row[0] ?? '',
                'action'    => $row[1] ?? '',
                'file'      => $row[2] ?? '',
                'details'   => $row[3] ?? '',
            ];
        }
    }
    fclose($handle);

    // Return most recent first
    $entries = array_reverse($entries);
    $total = count($entries);
    $entries = array_slice($entries, 0, $limit);

    jsonOut(['entries' => $entries, 'total' => $total]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION: folders — return a flat list of all folder paths (for dropdowns)
// ═══════════════════════════════════════════════════════════════════════════════
function actionFolders() {
    $folders = [];
    collectFolders(DATA_ROOT, '', $folders);
    jsonOut($folders);
}

function collectFolders(string $absDir, string $relPrefix, array &$list): void {
    $entries = @scandir($absDir);
    if (!$entries) return;
    foreach ($entries as $entry) {
        if ($entry === '.' || $entry === '..' || $entry === '.git') continue;
        $abs = $absDir . DIRECTORY_SEPARATOR . $entry;
        if (is_dir($abs)) {
            $rel = $relPrefix ? $relPrefix . '/' . $entry : $entry;
            $list[] = $rel;
            collectFolders($abs, $rel, $list);
        }
    }
}

// ═══════════════════════════════════════════════════════════════════════════════
// File I/O Helpers
// ═══════════════════════════════════════════════════════════════════════════════
function readCSVFile(string $abs): ?array {
    $handle = fopen($abs, 'r');
    if (!$handle) return null;

    $lines = [];
    while (($row = fgetcsv($handle)) !== false) {
        $lines[] = $row;
    }
    fclose($handle);
    return $lines;
}

function writeCSVFile(string $abs, array $lines): bool {
    $handle = fopen($abs, 'w');
    if (!$handle) return false;

    if (!flock($handle, LOCK_EX)) {
        fclose($handle);
        return false;
    }

    foreach ($lines as $row) {
        fputcsv($handle, $row);
    }

    flock($handle, LOCK_UN);
    fclose($handle);
    return true;
}

function backupFile(string $abs): void {
    $bakDir = __DIR__ . '/backups';
    if (!is_dir($bakDir)) @mkdir($bakDir, 0755, true);
    $bakName = basename($abs) . '.' . date('Ymd_His') . '.bak';
    @copy($abs, $bakDir . '/' . $bakName);
}

function auditLog(string $action, string $file, string $details = ''): void {
    $logDir = __DIR__ . '/logs';
    if (!is_dir($logDir)) @mkdir($logDir, 0755, true);
    $logFile = $logDir . '/audit.csv';

    $writeHeader = !file_exists($logFile);
    $handle = fopen($logFile, 'a');
    if (!$handle) return;

    if ($writeHeader) {
        fputcsv($handle, ['Timestamp', 'Action', 'File', 'Details']);
    }
    fputcsv($handle, [date('Y-m-d H:i:s'), $action, $file, $details]);
    fclose($handle);
}
