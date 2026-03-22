<?php
require_once 'db.php';

$ident = isset($_GET['ident']) ? $_GET['ident'] : '';
$airport = null;
$metar = null;
$taf = null;
$error = '';

if ($ident) {
    // Get airport details
    $stmt = $pdo->prepare("SELECT * FROM airports WHERE ident = ?");
    $stmt->execute([$ident]);
    $airport = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($airport) {
        // Fetch METAR
        $metarUrl = "https://aviationweather.gov/api/data/metar?ids=$ident&format=json";
        $metarJson = @file_get_contents($metarUrl);
        if ($metarJson) {
            $metarData = json_decode($metarJson, true);
            $metar = !empty($metarData) ? $metarData[0] : null;
        }

        // Fetch TAF
        $tafUrl = "https://aviationweather.gov/api/data/taf?ids=$ident&format=json";
        $tafJson = @file_get_contents($tafUrl);
        if ($tafJson) {
            $tafData = json_decode($tafJson, true);
            $taf = !empty($tafData) ? $tafData[0] : null;
        }
    } else {
        $error = "Airport not found.";
    }
} else {
    header("Location: index.php");
    exit;
}

function formatVisibility($vis) {
    return $vis ? "$vis SM" : "N/A";
}

function formatTemp($temp) {
    return $temp !== null ? $temp . "°C" : "N/A";
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Weather - <?= htmlspecialchars($ident) ?></title>
    <link rel="stylesheet" href="style.css">
    <style>
        .weather-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; margin-top: 2rem; }
        .raw-data { background: rgba(0,0,0,0.2); padding: 1rem; border-radius: 0.5rem; font-family: monospace; font-size: 0.9rem; margin-top: 1rem; white-space: pre-wrap; word-break: break-all; }
        .metric-badge { display: inline-block; padding: 0.5rem 1rem; background: var(--primary-color); border-radius: 2rem; font-weight: bold; margin-bottom: 1rem; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>AnganiData</h1>
            <nav>
                <a href="index.php">Viewer</a>
                <a href="form.php">Add Airport</a>
                <a href="import.php">Bulk Import</a>
            </nav>
        </header>

        <main>
            <div class="card">
                <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                    <div>
                        <h2>Weather Report: <?= htmlspecialchars($airport['name'] ?? $ident) ?></h2>
                        <p class="text-muted"><?= htmlspecialchars($airport['municipality'] ?? '') ?>, <?= htmlspecialchars($airport['iso_country'] ?? '') ?></p>
                    </div>
                    <a href="index.php" class="btn btn-secondary">Back to Viewer</a>
                </div>

                <?php if ($error): ?>
                    <div class="alert alert-error"><?= htmlspecialchars($error) ?></div>
                <?php else: ?>
                    <div class="weather-grid">
                        <!-- METAR Section -->
                        <div class="card" style="background: rgba(255,255,255,0.03);">
                            <div class="metric-badge">METAR (Current)</div>
                            <?php if ($metar): ?>
                                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                                    <div>
                                        <label>Wind</label>
                                        <p><?= ($metar['wdir'] ?? '0') . '° @ ' . ($metar['wspd'] ?? '0') ?> kts</p>
                                    </div>
                                    <div>
                                        <label>Visibility</label>
                                        <p><?= formatVisibility($metar['visib'] ?? null) ?></p>
                                    </div>
                                    <div>
                                        <label>Temp / Dew</label>
                                        <p><?= formatTemp($metar['temp'] ?? null) ?> / <?= formatTemp($metar['dewp'] ?? null) ?></p>
                                    </div>
                                    <div>
                                        <label>Altimeter</label>
                                        <p><?= ($metar['altim'] ?? 'N/A') ?> inHg</p>
                                    </div>
                                </div>
                                <div class="raw-data"><?= htmlspecialchars($metar['rawOb'] ?? 'No raw data available.') ?></div>
                            <?php else: ?>
                                <p>No real-time METAR data available for this station.</p>
                            <?php endif; ?>
                        </div>

                        <!-- TAF Section -->
                        <div class="card" style="background: rgba(255,255,255,0.03);">
                            <div class="metric-badge">TAF (Forecast)</div>
                            <?php if ($taf): ?>
                                <p style="margin-bottom: 1rem;">Valid From: <?= date('Y-m-d H:i', strtotime($taf['validTimeFrom'] ?? 'now')) ?></p>
                                <div class="raw-data"><?= htmlspecialchars($taf['rawTAF'] ?? 'No raw TAF available.') ?></div>
                            <?php else: ?>
                                <p>No forecast (TAF) data available for this station.</p>
                            <?php endif; ?>
                        </div>
                    </div>
                <?php endif; ?>
            </div>
        </main>
    </div>
</body>
</html>
