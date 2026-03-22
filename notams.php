<?php
require_once 'db.php';

$ident = isset($_GET['ident']) ? $_GET['ident'] : '';
$airport = null;
$notams = [];
$error = '';

if ($ident) {
    // Get airport details
    $stmt = $pdo->prepare("SELECT * FROM airports WHERE ident = ?");
    $stmt->execute([$ident]);
    $airport = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($airport) {
        // Fetch NOTAMs from a public source (using a community API or FAA link)
        // For this demonstration, we'll try to simulate/fetch from a placeholder or use the FAA link
        // Real-time NOTAM APIs often require API keys. 
        // We'll provide a direct link to FAA and search logic.
    } else {
        $error = "Airport not found.";
    }
} else {
    header("Location: index.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | NOTAMs - <?= htmlspecialchars($ident) ?></title>
    <link rel="stylesheet" href="style.css">
    <style>
        .notam-card { margin-bottom: 1rem; border-left: 4px solid var(--primary-color); }
        .notam-id { font-weight: bold; color: var(--primary-color); margin-bottom: 0.5rem; }
        .notam-text { font-family: monospace; white-space: pre-wrap; font-size: 0.9rem; }
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
                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 2rem;">
                    <div>
                        <h2>NOTAM Viewer: <?= htmlspecialchars($airport['name'] ?? $ident) ?></h2>
                        <p class="text-muted">Identifier: <?= htmlspecialchars($ident) ?></p>
                    </div>
                    <div style="display: flex; gap: 0.5rem;">
                        <a href="https://notams.aim.faa.gov/notamSearch/nsidirect?displayMode=notams&locId=<?= urlencode($ident) ?>" target="_blank" class="btn">Official FAA Search</a>
                        <a href="index.php" class="btn btn-secondary">Back</a>
                    </div>
                </div>

                <?php if ($error): ?>
                    <div class="alert alert-error"><?= htmlspecialchars($error) ?></div>
                <?php else: ?>
                    <div class="alert alert-success">
                        <p><strong>Note:</strong> Real-time NOTAM API integration usually requires an authorized API key. For the current version, we provide a direct link to the official FAA NOTAM System above.</p>
                    </div>
                    
                    <div class="card" style="background: rgba(255,255,255,0.03);">
                        <p>To view the most up-to-date Notices to Air Missions (NOTAMs) for this airport, please use the <strong>Official FAA Search</strong> button above. This ensures you receive critical safety information directly from the source.</p>
                    </div>
                <?php endif; ?>
            </div>
        </main>
    </div>
</body>
</html>
