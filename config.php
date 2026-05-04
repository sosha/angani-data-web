<?php
/**
 * AnganiData — Central Configuration
 *
 * DATA_ROOT is the absolute path to the angani-data/datasets directory.
 *
 * Default: the sibling angani-data/datasets folder (standard deployment).
 * Override: set the ANGANI_DATA_ROOT environment variable, or edit the
 *           $dataRootOverride value below for a custom local path.
 *
 * Examples:
 *   $dataRootOverride = 'C:/Users/user/Documents/Angani/angani-data/datasets';
 *   $dataRootOverride = '/var/www/data/angani-data/datasets';
 */

// ── Optional hard-coded override (leave empty string to use auto-detection) ──
$dataRootOverride = '';

// ── Resolution order ─────────────────────────────────────────────────────────
// 1. Hard-coded override above
// 2. ANGANI_DATA_ROOT environment variable
// 3. Auto-detect: sibling angani-data/datasets directory

if (!defined('DATA_ROOT')) {
    if ($dataRootOverride !== '') {
        $resolved = realpath($dataRootOverride);
    } elseif (getenv('ANGANI_DATA_ROOT') !== false) {
        $resolved = realpath(getenv('ANGANI_DATA_ROOT'));
    } else {
        $resolved = realpath(__DIR__ . '/../angani-data/datasets');
    }

    if (!$resolved || !is_dir($resolved)) {
        // Provide a helpful error with all attempted paths
        $attempted = [];
        if ($dataRootOverride !== '') $attempted[] = "Override: $dataRootOverride";
        if (getenv('ANGANI_DATA_ROOT') !== false) $attempted[] = "Env: " . getenv('ANGANI_DATA_ROOT');
        $attempted[] = "Auto: " . __DIR__ . '/../angani-data/datasets';

        $msg = 'Dataset root not found. Tried: ' . implode(', ', $attempted) . '. '
             . 'Set $dataRootOverride in config.php or the ANGANI_DATA_ROOT environment variable.';

        // If called from an API file, return JSON; otherwise show plain text
        if (!empty($_SERVER['HTTP_ACCEPT']) && strpos($_SERVER['HTTP_ACCEPT'], 'application/json') !== false) {
            header('Content-Type: application/json; charset=utf-8');
            http_response_code(500);
            echo json_encode(['error' => $msg]);
        } else {
            http_response_code(500);
            echo '<pre style="color:red;font-family:monospace;padding:2rem;">' . htmlspecialchars($msg) . '</pre>';
        }
        exit;
    }

    define('DATA_ROOT', $resolved);
}
