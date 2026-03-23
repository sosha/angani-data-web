<?php
require_once 'db.php';

$active_page = 'admin';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Administration</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .admin-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; margin-top: 1rem; }
        .admin-card { padding: 1.5rem; display: flex; flex-direction: column; gap: 1rem; transition: transform 0.2s; }
        .admin-card:hover { transform: translateY(-3px); }
        .admin-card h3 { margin: 0; display: flex; align-items: center; gap: 0.5rem; }
        .admin-card p { margin: 0; color: var(--text-muted); font-size: 0.9rem; flex-grow: 1; }
        .admin-card .btn { align-self: flex-start; }
    </style>
</head>
<body>
    <div class="container">
        <?php include 'header.php'; ?>

        <main>
            <h2>Administration & Housekeeping</h2>
            <p class="text-muted">Manage your data, system logs, and API configurations from here.</p>

        <div class="admin-grid">
                <?php
                // Handle API Key Saving
                if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['rapidapi_key'])) {
                    $stmt = $pdo->prepare("INSERT INTO settings (setting_key, setting_value) VALUES ('rapidapi_key', ?) ON CONFLICT(setting_key) DO UPDATE SET setting_value = excluded.setting_value");
                    // Fix for MySQL compatibility if needed
                    if ($is_mysql) {
                        $stmt = $pdo->prepare("INSERT INTO settings (setting_key, setting_value) VALUES ('rapidapi_key', ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
                    }
                    $stmt->execute([$_POST['rapidapi_key']]);
                    echo "<div class='alert alert-success' style='grid-column: 1 / -1;'>RapidAPI Key saved successfully!</div>";
                }

                $stmt = $pdo->prepare("SELECT setting_value FROM settings WHERE setting_key = 'rapidapi_key'");
                $stmt->execute();
                $currentKey = $stmt->fetchColumn();
                ?>

                <div class="card admin-card" style="grid-column: 1 / -1; border-color: var(--accent-color);">
                    <h3>🔑 API Configuration</h3>
                    <p>Enter your <strong>RapidAPI Key</strong> to enable deep technical specifications for aircraft via AeroDataBox. You can get a free key at <a href="https://rapidapi.com/aero-data-box/api/aerodatabox/" target="_blank">RapidAPI.com</a>.</p>
                    <form method="POST" style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                        <input type="password" name="rapidapi_key" value="<?= htmlspecialchars($currentKey ?: '') ?>" placeholder="Paste your X-RapidAPI-Key here..." style="flex-grow: 1;">
                        <button type="submit" class="btn">Save Key</button>
                        <button type="button" id="test-api-btn" class="btn btn-secondary">Test Connection</button>
                    </form>
                    <div id="api-test-result" style="margin-top: 1rem; font-size: 0.9rem; font-weight: bold;"></div>
                </div>

                <script>
                    document.getElementById('test-api-btn').addEventListener('click', function() {
                        const resultDiv = document.getElementById('api-test-result');
                        resultDiv.innerText = 'Testing connection...';
                        resultDiv.style.color = 'var(--text-muted)';
                        
                        fetch('test_api.php')
                            .then(res => res.json())
                            .then(data => {
                                resultDiv.innerText = data.message;
                                resultDiv.style.color = data.success ? 'var(--success-color)' : 'var(--danger-color)';
                            })
                            .catch(err => {
                                resultDiv.innerText = 'An error occurred while testing the connection.';
                                resultDiv.style.color = 'var(--danger-color)';
                            });
                    });
                </script>

                <div class="card admin-card">
                    <h3>📥 Data Import</h3>
                    <p>Load new aviation datasets (Airports, Aircraft, Navaids, Frequencies) from the curated CSV files into your storage.</p>
                    <a href="import.php" class="btn">Import Datasets</a>
                </div>

                <div class="card admin-card">
                    <h3>📤 Data Export</h3>
                    <p>Clean and export your current database as CSV files for backup or external analysis.</p>
                    <a href="export.php" class="btn">Export Datasets</a>
                </div>

                <div class="card admin-card">
                    <h3>📜 Activity Logs</h3>
                    <p>Monitor all user actions, including additions, edits, and deletions. Use this to track changes or perform "Undos".</p>
                    <a href="logs.php" class="btn">View System Logs</a>
                </div>

                <div class="card admin-card">
                    <h3>🔑 API Settings</h3>
                    <p>Configure your access keys for OpenSky Network, AeroDataBox, and other external aviation data providers.</p>
                    <a href="#" class="btn btn-secondary" title="Coming soon">Configure APIs</a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
