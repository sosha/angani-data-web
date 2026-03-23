<?php
require_once 'db.php';

$message = '';

// Handle Export Request
if (isset($_GET['action']) && $_GET['action'] === 'download') {
    $type = $_GET['type'] ?? 'airports';
    $country = $_GET['country'] ?? '';
    
    $table = ($type === 'aircraft') ? 'aircraft' : 'airports';
    $query = "SELECT * FROM $table";
    $params = [];
    
    if ($type === 'airports' && $country) {
        $query .= " WHERE iso_country = ?";
        $params[] = $country;
    }
    
    try {
        $stmt = $pdo->prepare($query);
        $stmt->execute($params);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if (empty($rows)) {
            $message = "Error: No data found to export.";
        } else {
            $filename = "angani_" . $type . ($country ? "_$country" : "") . "_" . date('Y-m-d') . ".csv";
            
            // Set headers for download
            header('Content-Type: text/csv; charset=utf-8');
            header('Content-Disposition: attachment; filename=' . $filename);
            
            $output = fopen('php://output', 'w');
            
            // Output CSV Headers
            fputcsv($output, array_keys($rows[0]));
            
            // Output Data
            foreach ($rows as $row) {
                fputcsv($output, $row);
            }
            
            logAction($pdo, 'EXPORT', $type, 0, null, ['count' => count($rows), 'country' => $country]);
            
            fclose($output);
            exit;
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Get available countries for filtering
$countries = [];
$cStmt = $pdo->query("SELECT DISTINCT iso_country FROM airports WHERE iso_country IS NOT NULL AND iso_country != '' ORDER BY iso_country");
$countries = $cStmt->fetchAll(PDO::FETCH_COLUMN);

$country_names = [
    'KE' => 'Kenya', 'US' => 'United States', 'GB' => 'United Kingdom', 
    'AE' => 'United Arab Emirates', 'TZ' => 'Tanzania', 'UG' => 'Uganda',
    'RW' => 'Rwanda', 'ET' => 'Ethiopia', 'ZA' => 'South Africa'
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Bulk Export</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <?php $active_page = 'admin'; include 'header.php'; ?>
        </header>

        <main>
            <div class="card import-box">
                <h2>Bulk Data Export</h2>
                <p class="text-muted">Download your current database entries as CSV files. This will include all your manual edits and additions.</p>

                <?php if ($message): ?>
                    <div class="alert alert-error">
                        <?= htmlspecialchars($message) ?>
                    </div>
                <?php endif; ?>

                <form method="GET">
                    <input type="hidden" name="action" value="download">
                    
                    <div class="form-group">
                        <label>Data Type</label>
                        <select name="type" onchange="toggleCountryFilter(this.value)">
                            <option value="airports">Airports</option>
                            <option value="aircraft">Aircraft</option>
                        </select>
                    </div>

                    <div class="form-group" id="country-filter-group">
                        <label>Filter by Country (Airports Only)</label>
                        <select name="country">
                            <option value="">All Countries</option>
                            <?php foreach ($countries as $c): 
                                $name = isset($country_names[$c]) ? "$c - " . $country_names[$c] : $c;
                            ?>
                                <option value="<?= htmlspecialchars($c) ?>"><?= htmlspecialchars($name) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <button type="submit" class="btn">Generate CSV Download</button>
                </form>
            </div>
        </main>
    </div>

    <script>
        function toggleCountryFilter(type) {
            document.getElementById('country-filter-group').style.display = (type === 'airports') ? 'block' : 'none';
        }
    </script>
</body>
</html>
