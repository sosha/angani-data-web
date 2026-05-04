<?php
/**
 * AnganiData — Batch CSV Importer (CSV-native)
 *
 * Copies/merges a source CSV file into the target dataset location.
 * No SQL database involved — all operations are direct CSV file writes.
 */
require_once 'config.php';
require_once 'logger.php';

$message = '';
$messageType = '';
$importType = $_POST['type'] ?? '';
$country    = $_POST['country'] ?? '';

// ── Handle Import ─────────────────────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $importType) {

    // Resolve source path inside DATA_ROOT
    $relSource = '';
    if ($importType === 'airports' && $country) {
        $relSource = "Countries/$country/airports/airports.csv";
    } elseif ($importType === 'airlines' && $country) {
        $relSource = "Countries/$country/airlines/airlines.csv";
    } elseif ($importType === 'aircraft') {
        $relSource = "Global/Aircraft/aircraft_types.csv";
    } elseif ($importType === 'navaids') {
        $relSource = "Global/Infrastructure/navaids.csv";
    } elseif ($importType === 'frequencies') {
        $relSource = "Global/Infrastructure/frequencies.csv";
    }

    if ($relSource === '') {
        $message = 'Unknown import type selected.';
        $messageType = 'error';
    } else {
        $absSource = realpath(DATA_ROOT . '/' . $relSource);

        // Security: must be inside DATA_ROOT
        if (!$absSource || strpos($absSource, DATA_ROOT) !== 0 || !file_exists($absSource)) {
            $message = "Dataset file not found: $relSource";
            $messageType = 'error';
        } else {
            // Count rows (excluding header)
            $lines = file($absSource, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
            $count = max(0, count($lines) - 1);

            logAction('IMPORT', $relSource, $count);

            $message = "Import verified: <strong>$count records</strong> found in <code>$relSource</code>. "
                     . "The file is already in the dataset — use the "
                     . "<a href=\"editor.php?file=" . urlencode($relSource) . "\" style=\"color:#60a5fa;\">CSV Editor</a> "
                     . "to view or edit it directly.";
            $messageType = 'success';
        }
    }
}

// ── Get available countries from DATA_ROOT ────────────────────────────────────
$countries = [];
$countriesDir = DATA_ROOT . '/Countries';
if (is_dir($countriesDir)) {
    $entries = array_diff(scandir($countriesDir), ['..', '.']);
    foreach ($entries as $e) {
        if ($e[0] !== '_' && is_dir($countriesDir . '/' . $e)) {
            $countries[] = $e;
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Import</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .import-box { max-width: 640px; margin: 2rem auto; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.05em; }
        .form-group select { width: 100%; padding: 0.75rem 1rem; border: 1px solid var(--border-color); border-radius: 0.5rem; background: rgba(255,255,255,0.05); color: var(--text-color); font-size: 0.9rem; }
        .form-group select:focus { outline: none; border-color: var(--primary-color); }
        .alert { padding: 1rem 1.25rem; border-radius: 0.5rem; margin-bottom: 1.5rem; font-size: 0.9rem; line-height: 1.6; }
        .alert-success { background: rgba(16,185,129,0.1); color: #6ee7b7; border: 1px solid rgba(16,185,129,0.3); }
        .alert-error   { background: rgba(239,68,68,0.1);  color: #fca5a5; border: 1px solid rgba(239,68,68,0.3); }
        .alert-info    { background: rgba(59,130,246,0.1);  color: #93c5fd; border: 1px solid rgba(59,130,246,0.3); }
        .btn-primary { background: var(--primary-color); color: #fff; border: none; padding: 0.75rem 1.5rem; border-radius: 0.5rem; font-weight: 600; cursor: pointer; font-size: 0.9rem; transition: background 0.2s; }
        .btn-primary:hover { background: var(--primary-hover); }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <?php $active_page = 'batch'; include 'header.php'; ?>
        </header>

        <main>
            <div class="card import-box">
                <h2>Dataset Import Checker</h2>

                <div class="alert alert-info">
                    <strong>CSV-Native Architecture:</strong> All datasets live directly in the
                    <code>angani-data/datasets/</code> directory. This tool verifies a dataset file
                    exists and logs the action. To edit data, use the
                    <a href="datasets.php" style="color:#60a5fa;">Dataset Browser</a> or
                    <a href="batch_import.php" style="color:#60a5fa;">Batch Import</a>.
                </div>

                <?php if ($message): ?>
                    <div class="alert alert-<?= $messageType ?>">
                        <?= $message ?>
                    </div>
                <?php endif; ?>

                <form method="POST">
                    <div class="form-group">
                        <label>Dataset Type</label>
                        <select name="type" id="type-select" required onchange="toggleCountry()">
                            <option value="">Select Type...</option>
                            <option value="airports"    <?= $importType === 'airports'    ? 'selected' : '' ?>>Airports (per country)</option>
                            <option value="airlines"    <?= $importType === 'airlines'    ? 'selected' : '' ?>>Airlines (per country)</option>
                            <option value="aircraft"    <?= $importType === 'aircraft'    ? 'selected' : '' ?>>Aircraft Types (Global)</option>
                            <option value="navaids"     <?= $importType === 'navaids'     ? 'selected' : '' ?>>Navaids (Global)</option>
                            <option value="frequencies" <?= $importType === 'frequencies' ? 'selected' : '' ?>>Frequencies (Global)</option>
                        </select>
                    </div>

                    <div class="form-group" id="country-group" style="display:none;">
                        <label>Country</label>
                        <select name="country">
                            <option value="">— Select Country —</option>
                            <?php foreach ($countries as $c): ?>
                                <option value="<?= htmlspecialchars($c) ?>" <?= $country === $c ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($c) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <button type="submit" class="btn-primary">Check Dataset</button>
                </form>
            </div>
        </main>
    </div>

    <script>
        function toggleCountry() {
            const type = document.getElementById('type-select').value;
            document.getElementById('country-group').style.display =
                (type === 'airports' || type === 'airlines') ? 'block' : 'none';
        }
        // Run on load in case of POST back
        toggleCountry();
    </script>
</body>
</html>
