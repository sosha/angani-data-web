<?php
require_once 'db.php';

$airport_ident = isset($_GET['ident']) ? $_GET['ident'] : '';
$airport = null;
$frequencies = [];

if ($airport_ident) {
    // Get airport details
    $stmt = $pdo->prepare("SELECT * FROM airports WHERE ident = ?");
    $stmt->execute([$airport_ident]);
    $airport = $stmt->fetch(PDO::FETCH_ASSOC);

    // Get frequencies
    $stmt = $pdo->prepare("SELECT * FROM frequencies WHERE airport_ident = ? ORDER BY frequency_mhz");
    $stmt->execute([$airport_ident]);
    $frequencies = $stmt->fetchAll(PDO::FETCH_ASSOC);
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
    <title>AnganiData | Frequencies - <?= htmlspecialchars($airport_ident) ?></title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>AnganiData</h1>
            <nav>
                <a href="index.php">Viewer</a>
                <a href="navaids.php">Navaids</a>
                <a href="import.php">Bulk Import</a>
            </nav>
        </header>

        <main>
            <div class="card">
                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 2rem;">
                    <div>
                        <h2>Airport Frequencies: <?= htmlspecialchars($airport['name'] ?? $airport_ident) ?></h2>
                        <p class="text-muted">Identifier: <?= htmlspecialchars($airport_ident) ?></p>
                    </div>
                    <a href="index.php" class="btn btn-secondary">Back to Viewer</a>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Description</th>
                            <th>Frequency (MHz)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($frequencies)): ?>
                        <tr><td colspan="3" style="text-align: center;">No frequencies found for this airport.</td></tr>
                        <?php else: ?>
                            <?php foreach ($frequencies as $f): ?>
                            <tr>
                                <td><strong><?= htmlspecialchars($f['type']) ?></strong></td>
                                <td><?= htmlspecialchars($f['description']) ?></td>
                                <td><code><?= htmlspecialchars($f['frequency_mhz']) ?> MHz</code></td>
                            </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>
