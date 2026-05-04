<?php
/**
 * AnganiData — Search API
 * Multi-column filtered search across CSV datasets with export.
 */
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/config.php'; // defines DATA_ROOT

// ── Security ────────────────────────────────────────────────────────────────
function safePath(string $relative): ?string {
    $relative = str_replace('\\', '/', trim($relative, '/'));
    if (strpos($relative, '..') !== false) return null;
    $full = realpath(DATA_ROOT . '/' . $relative);
    if (!$full) return null;
    if (strpos($full, DATA_ROOT) !== 0) return null;
    return $full;
}

function safeCSVPath(string $relative): ?string {
    $full = safePath($relative);
    if (!$full) return null;
    if (strtolower(pathinfo($full, PATHINFO_EXTENSION)) !== 'csv') return null;
    return $full;
}

function jsonOut($data, int $code = 200) {
    http_response_code($code);
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
}

function jsonErr(string $msg, int $code = 400) {
    jsonOut(['error' => $msg], $code);
}

// ── Router ──────────────────────────────────────────────────────────────────
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'search':          actionSearch();         break;
    case 'search_multi':    actionSearchMulti();    break;
    case 'export_filtered': actionExportFiltered(); break;
    case 'headers':         actionHeaders();        break;
    case 'distinct':        actionDistinct();       break;
    default:                jsonErr('Unknown action. Use: search, search_multi, export_filtered, headers, distinct');
}

// ═════════════════════════════════════════════════════════════════════════════
// ACTION: search — filtered search on a single CSV
// ═════════════════════════════════════════════════════════════════════════════
function actionSearch() {
    $file    = $_GET['file'] ?? '';
    $q       = $_GET['q'] ?? '';
    $page    = max(1, (int)($_GET['page'] ?? 1));
    $perPage = max(10, min(500, (int)($_GET['per_page'] ?? 50)));
    $sortCol = $_GET['sort'] ?? '';
    $sortDir = strtolower($_GET['sort_dir'] ?? 'asc') === 'desc' ? 'desc' : 'asc';

    // Column-specific filters: filters[Column_Name]=value
    $filters = $_GET['filters'] ?? [];
    if (!is_array($filters)) $filters = [];

    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV file path.');

    $handle = fopen($abs, 'r');
    if (!$handle) jsonErr('Could not open file.');

    // Read headers
    $headers = fgetcsv($handle);
    if (!$headers) { fclose($handle); jsonErr('Empty CSV.'); }
    $headers = array_map(function($h) {
        return trim(preg_replace('/^\x{FEFF}/u', '', $h));
    }, $headers);

    $colCount = count($headers);

    // Build filter index: header name -> column index
    $filterMap = [];
    foreach ($filters as $colName => $val) {
        $val = trim($val);
        if ($val === '') continue;
        $idx = array_search($colName, $headers);
        if ($idx !== false) {
            $filterMap[$idx] = strtolower($val);
        }
    }

    // Sort column index
    $sortIdx = -1;
    if ($sortCol !== '') {
        $sortIdx = array_search($sortCol, $headers);
        if ($sortIdx === false) $sortIdx = -1;
    }

    // Read and filter rows
    $matchedRows = [];
    $lineNum = 1;
    while (($row = fgetcsv($handle)) !== false) {
        $row = array_pad($row, $colCount, '');
        $row = array_slice($row, 0, $colCount);

        // Apply column filters (all must match)
        $passFilters = true;
        foreach ($filterMap as $idx => $filterVal) {
            $cellVal = strtolower((string)($row[$idx] ?? ''));
            if (strpos($cellVal, $filterVal) === false) {
                $passFilters = false;
                break;
            }
        }
        if (!$passFilters) { $lineNum++; continue; }

        // Apply global search
        if ($q !== '') {
            $found = false;
            foreach ($row as $cell) {
                if (stripos((string)$cell, $q) !== false) {
                    $found = true;
                    break;
                }
            }
            if (!$found) { $lineNum++; continue; }
        }

        $matchedRows[] = ['_line' => $lineNum, 'data' => $row];
        $lineNum++;
    }
    fclose($handle);

    // Sort
    if ($sortIdx >= 0) {
        usort($matchedRows, function($a, $b) use ($sortIdx, $sortDir) {
            $va = $a['data'][$sortIdx] ?? '';
            $vb = $b['data'][$sortIdx] ?? '';
            // Numeric comparison if both are numeric
            if (is_numeric($va) && is_numeric($vb)) {
                $cmp = (float)$va - (float)$vb;
            } else {
                $cmp = strnatcasecmp($va, $vb);
            }
            return $sortDir === 'desc' ? -$cmp : $cmp;
        });
    }

    $total = count($matchedRows);
    $totalPages = max(1, (int)ceil($total / $perPage));
    $page = min($page, $totalPages);
    $offset = ($page - 1) * $perPage;
    $pageRows = array_slice($matchedRows, $offset, $perPage);

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

// ═════════════════════════════════════════════════════════════════════════════
// ACTION: search_multi — search across multiple files matching a pattern
// ═════════════════════════════════════════════════════════════════════════════
function actionSearchMulti() {
    $pattern  = $_GET['pattern'] ?? '';  // e.g. "Countries/*/airlines/airlines.csv"
    $q        = $_GET['q'] ?? '';
    $page     = max(1, (int)($_GET['page'] ?? 1));
    $perPage  = max(10, min(500, (int)($_GET['per_page'] ?? 50)));
    $filters  = $_GET['filters'] ?? [];
    if (!is_array($filters)) $filters = [];

    if (!$pattern) jsonErr('pattern is required.');
    if (strpos($pattern, '..') !== false) jsonErr('Invalid pattern.');

    // Convert pattern to glob
    $globPattern = DATA_ROOT . '/' . str_replace('\\', '/', $pattern);
    $files = glob($globPattern);
    if (!$files) jsonErr('No files matched pattern.');

    // Use first file to determine headers
    $firstHandle = fopen($files[0], 'r');
    $headers = fgetcsv($firstHandle);
    fclose($firstHandle);
    if (!$headers) jsonErr('Could not read headers.');
    $headers = array_map(function($h) {
        return trim(preg_replace('/^\x{FEFF}/u', '', $h));
    }, $headers);
    $colCount = count($headers);

    // Build filter map
    $filterMap = [];
    foreach ($filters as $colName => $val) {
        $val = trim($val);
        if ($val === '') continue;
        $idx = array_search($colName, $headers);
        if ($idx !== false) {
            $filterMap[$idx] = strtolower($val);
        }
    }

    // Read all matching files
    $allRows = [];
    foreach ($files as $f) {
        // Verify within DATA_ROOT
        $realF = realpath($f);
        if (!$realF || strpos($realF, DATA_ROOT) !== 0) continue;

        // Extract country code from path if possible
        $relPath = substr($realF, strlen(DATA_ROOT) + 1);
        $relPath = str_replace('\\', '/', $relPath);

        $handle = fopen($realF, 'r');
        if (!$handle) continue;

        $fileHeaders = fgetcsv($handle);
        if (!$fileHeaders) { fclose($handle); continue; }

        while (($row = fgetcsv($handle)) !== false) {
            $row = array_pad($row, $colCount, '');
            $row = array_slice($row, 0, $colCount);

            // Column filters
            $pass = true;
            foreach ($filterMap as $idx => $fv) {
                if (strpos(strtolower((string)($row[$idx] ?? '')), $fv) === false) {
                    $pass = false;
                    break;
                }
            }
            if (!$pass) continue;

            // Global search
            if ($q !== '') {
                $found = false;
                foreach ($row as $cell) {
                    if (stripos((string)$cell, $q) !== false) { $found = true; break; }
                }
                if (!$found) continue;
            }

            $allRows[] = [
                '_source' => $relPath,
                'data'    => $row,
            ];
        }
        fclose($handle);
    }

    $total = count($allRows);
    $totalPages = max(1, (int)ceil($total / $perPage));
    $page = min($page, $totalPages);
    $offset = ($page - 1) * $perPage;
    $pageRows = array_slice($allRows, $offset, $perPage);

    jsonOut([
        'pattern'    => $pattern,
        'headers'    => $headers,
        'rows'       => $pageRows,
        'total'      => $total,
        'page'       => $page,
        'per_page'   => $perPage,
        'totalPages' => $totalPages,
        'files_searched' => count($files),
    ]);
}

// ═════════════════════════════════════════════════════════════════════════════
// ACTION: export_filtered — download filtered results as CSV
// ═════════════════════════════════════════════════════════════════════════════
function actionExportFiltered() {
    $file    = $_GET['file'] ?? '';
    $q       = $_GET['q'] ?? '';
    $filters = $_GET['filters'] ?? [];
    if (!is_array($filters)) $filters = [];

    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV path.');

    $handle = fopen($abs, 'r');
    if (!$handle) jsonErr('Could not open file.');

    $headers = fgetcsv($handle);
    if (!$headers) { fclose($handle); jsonErr('Empty CSV.'); }
    $headers = array_map(function($h) {
        return trim(preg_replace('/^\x{FEFF}/u', '', $h));
    }, $headers);
    $colCount = count($headers);

    $filterMap = [];
    foreach ($filters as $colName => $val) {
        $val = trim($val);
        if ($val === '') continue;
        $idx = array_search($colName, $headers);
        if ($idx !== false) $filterMap[$idx] = strtolower($val);
    }

    // Switch to CSV output
    header_remove('Content-Type');
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="filtered_' . basename($file) . '"');

    $out = fopen('php://output', 'w');
    fputcsv($out, $headers);

    while (($row = fgetcsv($handle)) !== false) {
        $row = array_pad($row, $colCount, '');
        $row = array_slice($row, 0, $colCount);

        $pass = true;
        foreach ($filterMap as $idx => $fv) {
            if (strpos(strtolower((string)($row[$idx] ?? '')), $fv) === false) {
                $pass = false; break;
            }
        }
        if (!$pass) continue;

        if ($q !== '') {
            $found = false;
            foreach ($row as $cell) {
                if (stripos((string)$cell, $q) !== false) { $found = true; break; }
            }
            if (!$found) continue;
        }

        fputcsv($out, $row);
    }

    fclose($handle);
    fclose($out);
    exit;
}

// ═════════════════════════════════════════════════════════════════════════════
// ACTION: headers — return just the headers for a CSV file
// ═════════════════════════════════════════════════════════════════════════════
function actionHeaders() {
    $file = $_GET['file'] ?? '';
    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV path.');

    $handle = fopen($abs, 'r');
    if (!$handle) jsonErr('Could not open file.');
    $headers = fgetcsv($handle);
    fclose($handle);

    if (!$headers) jsonErr('Empty CSV.');
    $headers = array_map(function($h) {
        return trim(preg_replace('/^\x{FEFF}/u', '', $h));
    }, $headers);

    jsonOut(['file' => $file, 'headers' => $headers]);
}

// ═════════════════════════════════════════════════════════════════════════════
// ACTION: distinct — return distinct values for a column (for filter dropdowns)
// ═════════════════════════════════════════════════════════════════════════════
function actionDistinct() {
    $file   = $_GET['file'] ?? '';
    $column = $_GET['column'] ?? '';
    $limit  = max(1, min(1000, (int)($_GET['limit'] ?? 200)));

    $abs = safeCSVPath($file);
    if (!$abs) jsonErr('Invalid CSV path.');
    if (!$column) jsonErr('column is required.');

    $handle = fopen($abs, 'r');
    if (!$handle) jsonErr('Could not open file.');

    $headers = fgetcsv($handle);
    if (!$headers) { fclose($handle); jsonErr('Empty CSV.'); }
    $headers = array_map(function($h) {
        return trim(preg_replace('/^\x{FEFF}/u', '', $h));
    }, $headers);

    $colIdx = array_search($column, $headers);
    if ($colIdx === false) { fclose($handle); jsonErr("Column '$column' not found."); }

    $values = [];
    while (($row = fgetcsv($handle)) !== false) {
        $val = trim((string)($row[$colIdx] ?? ''));
        if ($val !== '' && !isset($values[$val])) {
            $values[$val] = true;
            if (count($values) >= $limit) break;
        }
    }
    fclose($handle);

    $sorted = array_keys($values);
    sort($sorted, SORT_NATURAL | SORT_FLAG_CASE);

    jsonOut(['file' => $file, 'column' => $column, 'values' => $sorted, 'count' => count($sorted)]);
}
