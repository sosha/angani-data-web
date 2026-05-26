<?php
/**
 * Bulk Operations Page
 * Provides import, export, and advanced filtering for all database tables
 */

$message = '';
$active_tab = getv('tab', 'export');

// Handle CSV Import
if (isset($_POST['import_submit'])) {
    $table = trim($_POST['import_table'] ?? '');
    $has_header = isset($_POST['has_header']);
    file_put_contents('/var/www/angani-data/admin/import_debug.txt', "POST received at " . date('Y-m-d H:i:s') . "\nPOST:\n" . print_r($_POST, true) . "\nFILES:\n" . print_r($_FILES, true));
    
    if (isset($_FILES['csv_file']) && $_FILES['csv_file']['error'] === UPLOAD_ERR_OK) {
        $file = $_FILES['csv_file']['tmp_name'];
        file_put_contents('/var/www/angani-data/admin/import_debug.txt', file_get_contents('/var/www/angani-data/admin/import_debug.txt') . "\ntmp_file=$file, size=" . filesize($file));
        $message = '<div class="success">POST received, file: ' . basename($_FILES['csv_file']['name']) . '</div>';

        // Validate file type - check by extension since fileinfo extension may not be available
        $ext = strtolower(pathinfo($_FILES['csv_file']['name'], PATHINFO_EXTENSION));
        if (!in_array($ext, ['csv', 'txt'])) {
            $message = '<div class="error">Invalid file type. Only .csv or .txt files are allowed.</div>';
            file_put_contents('/var/www/angani-data/admin/import_debug.txt', file_get_contents('/var/www/angani-data/admin/import_debug.txt') . "\nExtension rejected: $ext");
        } else {
            // Read CSV file
            $handle = fopen($file, 'r');
            if ($handle) {
                $headers = fgetcsv($handle);
                
                // Get table columns to validate CSV headers
                $table_cols = array_column(rows("DESCRIBE $table"), 'Field');
                
                $inserted = 0;
                $errors = 0;

                while (($row = fgetcsv($handle)) !== false) {
                    if (count($row) < count($headers)) continue;

                    $data = array_combine($headers, $row);

                    // Clean data and filter to only valid columns
                    $clean = [];
                    foreach ($data as $key => $val) {
                        $col = trim($key);
                        if (in_array($col, $table_cols)) {
                            $clean[$col] = trim($val);
                        }
                    }
                    
                    if (empty($clean)) {
                        $errors++;
                        continue;
                    }

                    // Build insert based on table
                    try {
                        $cols = implode(', ', array_keys($clean));
                        $placeholders = implode(', ', array_fill(0, count($clean), '?'));
                        db()->prepare("INSERT INTO $table ($cols) VALUES ($placeholders)")->execute(array_values($clean));
                        $inserted++;
                    } catch (Exception $e) {
                        $errors++;
                    }
                }
                fclose($handle);

                $message = '<div class="success">Import completed! ' . number_format($inserted) . ' rows inserted, ' . number_format($errors) . ' errors.</div>';
            } else {
                $message = '<div class="error">Unable to read CSV file.</div>';
            }
        }
    } else {
        $message = '<div class="error">No file uploaded or upload error occurred.</div>';
        file_put_contents('/var/www/angani-data/admin/import_debug.txt', file_get_contents('/var/www/angani-data/admin/import_debug.txt') . "\nNo file uploaded - FILES:\n" . print_r($_FILES, true));
    }
}

// Get available tables
$tables = rows("SHOW TABLES");
$table_names = array_map(function($t) { return array_values($t)[0]; }, $tables);

// Tables to exclude from bulk ops
$exclude_tables = ['admin_users', 'dataset_files', 'dataset_records'];
$bulk_tables = array_filter($table_names, function($t) use ($exclude_tables) { 
    return !in_array($t, $exclude_tables); 
});

// Get filter results if table selected
$filter_table = getv('filter_table', '');
$filter_results = [];
$filter_columns = [];
$filter_total = 0;

if ($filter_table) {
    $filter_columns = rows("DESCRIBE $filter_table");
    $filter_q = getv('filter_q', '');
    $filter_field = getv('filter_field', '');
    $filter_status = getv('filter_status', '');
    
    $where = [];
    $params = [];
    
    if ($filter_q) {
        $search_fields = array_slice(array_filter(array_column($filter_columns, 'Field')), 0, 5);
        $searches = array_map(function($f) { return "$f LIKE ?"; }, $search_fields);
        $where[] = '(' . implode(' OR ', $searches) . ')';
        $params = array_merge($params, array_fill(0, count($search_fields), "%$filter_q%"));
    }
    
    if ($filter_field && $filter_q) {
        $where[] = "$filter_field LIKE ?";
        $params[] = "%$filter_q%";
    }
    
    if ($filter_status) {
        $status_field = get_status_field($filter_columns);
        if ($status_field) {
        $where[] = "$status_field = ?";
        $params[] = $filter_status;
        }
    }
    
    $w = $where ? 'WHERE ' . implode(' AND ', $where) : '';
    $filter_results = rows("SELECT * FROM $filter_table $w LIMIT 100", $params);
    $filter_total = (int)scalar("SELECT COUNT(*) FROM $filter_table $w", $params);
}
?>
<div class="admin-header">
    <h2>Bulk Operations</h2>
</div>

<?= $message ?>

<div class="card" style="margin-bottom: 24px;">
    <div style="display: flex; gap: 8px; border-bottom: 1px solid var(--line); padding-bottom: 16px; margin-bottom: 20px;">
        <a href="?page=bulk_operations&tab=export" class="btn <?= $active_tab === 'export' ? 'btn-primary' : 'btn-secondary' ?>">Export Data</a>
        <a href="?page=bulk_operations&tab=import" class="btn <?= $active_tab === 'import' ? 'btn-primary' : 'btn-secondary' ?>">Import CSV</a>
        <a href="?page=bulk_operations&tab=filter" class="btn <?= $active_tab === 'filter' ? 'btn-primary' : 'btn-secondary' ?>">Advanced Filter</a>
    </div>
</div>

<?php if ($active_tab === 'export'): ?>
<div class="card">
    <h3>Export Data to CSV</h3>
    <form method="GET">
        <input type="hidden" name="page" value="bulk_operations">
        <input type="hidden" name="tab" value="export">
        
        <div class="form-row">
        <div class="form-group">
            <label>Select Table</label>
            <select name="export_table" required onchange="this.form.submit()">
                <option value="">-- Select Table --</option>
                <?php foreach ($bulk_tables as $t): ?>
                    <option value="<?= e($t) ?>" <?= getv('export_table') === $t ? 'selected' : '' ?>><?= e($t) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <?php if (getv('export_table')): ?>
        <div class="form-group">
            <label>Export Format</label>
            <select name="format">
                <option value="csv">CSV (Comma Separated)</option>
                <option value="tsv">TSV (Tab Separated)</option>
            </select>
        </div>
        <?php endif; ?>
        </div>
    </form>
    
    <?php if (getv('export_table')): ?>
    <?php 
    $export_table = getv('export_table');
    $export_format = getv('format', 'csv');
    $export_data = rows("SELECT * FROM $export_table");
    $export_count = count($export_data);
    
    if (!empty($export_data)):
        $export_columns = array_keys($export_data[0]);
    ?>
    <div style="margin-top: 24px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
        <p><strong><?= number_format($export_count) ?></strong> records found in <strong><?= e($export_table) ?></strong></p>
        <div style="display: flex; gap: 12px;">
            <a href="?action=download&export_table=<?= urlencode($export_table) ?>&format=<?= e($export_format) ?>" class="btn btn-success" target="_blank">Download CSV</a>
        </div>
        </div>
        
        <div class="table-wrap" style="max-height: 400px; overflow: auto;">
        <table>
            <thead>
                <tr>
                    <?php foreach ($export_columns as $col): ?>
                    <th><?= e($col) ?></th>
                    <?php endforeach; ?>
                </tr>
            </thead>
            <tbody>
                <?php foreach (array_slice($export_data, 0, 50) as $row): ?>
                <tr>
                    <?php foreach ($export_columns as $col): ?>
                    <td><?= e(mb_strlen($row[$col] ?? '') > 50 ? mb_substr($row[$col] ?? '', 0, 50) . '...' : ($row[$col] ?? 'NULL')) ?></td>
                    <?php endforeach; ?>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        </div>
        <?php if ($export_count > 50): ?>
        <p style="color: var(--steel); margin-top: 12px;">Showing first 50 of <?= number_format($export_count) ?> records. Download to see all.</p>
        <?php endif; ?>
    </div>
    <?php else: ?>
    <p style="color: var(--steel);">No data in this table.</p>
    <?php endif; ?>
    <?php endif; ?>
</div>

<?php elseif ($active_tab === 'import'): ?>
<div class="card">
    <h3>Import CSV Data</h3>
    <p style="color: var(--steel); margin-bottom: 20px;">
        Upload a CSV file to import data. The first row should contain column headers matching your database table.
    </p>
    
    <form method="POST" enctype="multipart/form-data">
        <div class="form-row">
        <div class="form-group">
            <label>Target Table</label>
            <select name="import_table" required>
                <option value="">-- Select Table --</option>
                <?php foreach ($bulk_tables as $t): ?>
                    <option value="<?= e($t) ?>"><?= e($t) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="form-group">
            <label>CSV File</label>
            <input type="file" name="csv_file" accept=".csv,.txt" required>
        </div>
        </div>
        
        <div class="form-group">
        <label style="display: flex; align-items: center; gap: 8px;">
            <input type="checkbox" name="has_header" checked style="width: auto;">
            First row contains column headers
        </label>
        </div>
        
        <div class="form-group">
        <button type="submit" name="import_submit" class="btn btn-primary">Import Data</button>
        </div>
    </form>
    
    <div style="margin-top: 32px; padding: 20px; background: rgba(16,21,27,0.03); border-radius: 12px;">
        <h4 style="margin: 0 0 12px;">CSV Format Guidelines</h4>
        <ul style="margin: 0; color: var(--steel); line-height: 1.8;">
        <li>First row must contain column names matching the target table</li>
        <li>Use comma (,) or tab character as delimiter</li>
        <li>For text containing commas, wrap in double quotes: <code>"text, with, commas"</code></li>
        <li>Date format: <code>YYYY-MM-DD</code> or <code>YYYY-MM-DD HH:MM:SS</code></li>
        <li>Empty cells will be inserted as NULL values</li>
        </ul>
    </div>
</div>

<?php elseif ($active_tab === 'filter'): ?>
<div class="card">
    <h3>Advanced Filter & Search</h3>
    
    <form method="GET" style="margin-bottom: 24px;">
        <input type="hidden" name="page" value="bulk_operations">
        <input type="hidden" name="tab" value="filter">
        
        <div class="form-row">
        <div class="form-group">
            <label>Table</label>
            <select name="filter_table" required onchange="this.form.submit()">
                <option value="">-- Select Table --</option>
                <?php foreach ($bulk_tables as $t): ?>
                    <option value="<?= e($t) ?>" <?= $filter_table === $t ? 'selected' : '' ?>><?= e($t) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        
        <?php if ($filter_table): ?>
        <div class="form-group">
            <label>Search Text</label>
            <input type="text" name="filter_q" value="<?= e(getv('filter_q', '')) ?>" placeholder="Search across multiple fields...">
        </div>
        
        <div class="form-group">
            <label>Field (optional)</label>
            <select name="filter_field">
                <option value="">-- Any Field --</option>
                <?php foreach ($filter_columns as $col): ?>
                    <?php if ($col['Field'] !== 'id'): ?>
                    <option value="<?= e($col['Field']) ?>" <?= getv('filter_field') === $col['Field'] ? 'selected' : '' ?>><?= e($col['Field']) ?></option>
                    <?php endif; ?>
                <?php endforeach; ?>
            </select>
        </div>
        
        <?php
        $status_field = get_status_field($filter_columns);
        if ($status_field):
        ?>
        <div class="form-group">
            <label>Status</label>
            <select name="filter_status">
                <option value="">-- Any Status --</option>
                <?php
                $status_values = rows("SELECT DISTINCT $status_field FROM $filter_table WHERE $status_field IS NOT NULL");
                foreach ($status_values as $sv):
                ?>
                <option value="<?= e($sv[$status_field]) ?>" <?= getv('filter_status') === $sv[$status_field] ? 'selected' : '' ?>><?= e($sv[$status_field]) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <?php endif; ?>
        
        <div class="form-group" style="display: flex; align-items: flex-end;">
            <button type="submit" class="btn btn-primary">Filter</button>
            <?php if ($filter_q || getv('filter_status')): ?>
            <a href="?page=bulk_operations&tab=filter&filter_table=<?= urlencode($filter_table) ?>" class="btn btn-secondary" style="margin-left: 8px;">Clear</a>
            <?php endif; ?>
        </div>
        <?php endif; ?>
        </div>
    </form>
    
    <?php if ($filter_table && !empty($filter_results)): ?>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
        <p><strong><?= number_format($filter_total) ?></strong> records match your filter</p>
        <div style="display: flex; gap: 12px;">
        <a href="download.php?table=<?= urlencode($filter_table) ?>" class="btn btn-secondary">Export Filtered</a>
        </div>
    </div>
    
    <div class="table-wrap" style="max-height: 500px; overflow: auto;">
        <table>
        <thead>
            <tr>
                <th style="width: 40px;">
                    <input type="checkbox" id="select_all" onchange="toggleAll(this)">
                </th>
                <?php 
                $display_cols = array_slice(array_column($filter_columns, 'Field'), 0, 8);
                foreach ($display_cols as $col): ?>
                <th><?= e($col) ?></th>
                <?php endforeach; ?>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($filter_results as $row): ?>
            <tr>
                <td>
                    <input type="checkbox" class="row-checkbox" value="<?= e($row[get_table_pk($filter_columns)] ?? '') ?>">
                </td>
                <?php foreach ($display_cols as $col): ?>
                <td><?= e(mb_strlen($row[$col] ?? '') > 40 ? mb_substr($row[$col] ?? '', 0, 40) . '...' : ($row[$col] ?? '')) ?></td>
                <?php endforeach; ?>
            </tr>
            <?php endforeach; ?>
        </tbody>
        </table>
    </div>
    
    <div style="margin-top: 16px; display: flex; gap: 12px; align-items: center;">
        <form method="POST" onsubmit="return confirm('Delete selected records? This cannot be undone.')">
        <input type="hidden" name="bulk_table" value="<?= e($filter_table) ?>">
        <input type="hidden" name="bulk_ids" id="bulk_ids">
        <button type="submit" name="bulk_delete" class="btn btn-danger">Delete Selected</button>
        </form>
        <span id="selected_count" style="color: var(--steel);">0 selected</span>
    </div>
    
    <script>
    function toggleAll(source) {
        document.querySelectorAll('.row-checkbox').forEach(cb => cb.checked = source.checked);
        updateCount();
    }
    
    document.querySelectorAll('.row-checkbox').forEach(cb => cb.addEventListener('change', updateCount));
    
    function updateCount() {
        const checked = document.querySelectorAll('.row-checkbox:checked').length;
        document.getElementById('selected_count').textContent = checked + ' selected';
        const ids = Array.from(document.querySelectorAll('.row-checkbox:checked')).map(cb => cb.value);
        document.getElementById('bulk_ids').value = JSON.stringify(ids);
    }
    
    // Initialize
    document.querySelectorAll('.row-checkbox').forEach(cb => cb.addEventListener('change', updateCount));
    </script>
    <?php elseif ($filter_table): ?>
    <p style="color: var(--steel);">No records match your filter criteria.</p>
    <?php else: ?>
    <p style="color: var(--steel);">Select a table to start filtering.</p>
    <?php endif; ?>
</div>
<?php endif; ?>

<?php
// Helper functions
function get_table_pk($table) {
    $cols = rows("DESCRIBE $table");
    foreach ($cols as $col) {
        if ($col['Key'] === 'PRI') return $col['Field'];
    }
    // Fallback to first auto_increment column
    foreach ($cols as $col) {
        if (strpos($col['Extra'], 'auto_increment') !== false) return $col['Field'];
    }
    return 'id';
}

function get_status_field($columns) {
    $status_fields = ['status', 'record_status', 'active', 'is_active', 'status_bucket', 'status_type'];
    foreach ($columns as $col) {
        if (in_array($col['Field'], $status_fields)) return $col['Field'];
    }
    return null;
}
?>