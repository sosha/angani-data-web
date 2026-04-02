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
    case 'tree':   actionTree();   break;
    case 'read':   actionRead();   break;
    case 'update': actionUpdate(); break;
    case 'add':    actionAdd();    break;
    case 'delete': actionDelete(); break;
    case 'export': actionExport(); break;
    default:       jsonErr('Unknown action. Use: tree, read, update, add, delete, export');
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

    // Acquire exclusive lock
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
    $bak = $abs . '.bak';
    @copy($abs, $bak);
}
