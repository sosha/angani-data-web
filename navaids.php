<?php
require_once 'db.php';

$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 20;
$offset = ($page - 1) * $perPage;

$search = isset($_GET['search']) ? $_GET['search'] : '';
$where = "1=1";
$params = [];

if ($search) {
    // Search by Ident, Name, or Country
    $where = "(ident LIKE ? OR name LIKE ? OR iso_country = ?)";
    $params = ["%$search%", "%$search%", $search];
}

// Get Total Count
$countStmt = $pdo->prepare("SELECT COUNT(*) FROM navaids WHERE $where");
$countStmt->execute($params);
$totalRecords = $countStmt->fetchColumn();
$totalPages = ceil($totalRecords / $perPage);

// Get Records
$stmt = $pdo->prepare("SELECT * FROM navaids WHERE $where ORDER BY name LIMIT $perPage OFFSET $offset");
$stmt->execute($params);
$navaids = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Navaid Viewer</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <?php $active_page = 'directory'; include 'header.php'; ?>
        </header>

        <main>
            <div class="card">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                    <h2>Navigational Aids</h2>
                    <form method="GET" style="display: flex; gap: 0.5rem;">
                        <input type="text" name="search" placeholder="Search ident, name, country..." value="<?= htmlspecialchars($search) ?>" style="width: 300px;">
                        <button type="submit" class="btn">Search</button>
                    </form>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Ident</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Frequency</th>
                            <th>Country</th>
                            <th>Airport</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($navaids)): ?>
                        <tr><td colspan="6" style="text-align: center;">No navaids found. Use Bulk Import to populate the database.</td></tr>
                        <?php else: ?>
                            <?php foreach ($navaids as $nav): ?>
                            <tr>
                                <td><code><?= htmlspecialchars($nav['ident']) ?></code></td>
                                <td><?= htmlspecialchars($nav['name']) ?></td>
                                <td><?= htmlspecialchars($nav['type']) ?></td>
                                <td>
                                    <?= htmlspecialchars($nav['frequency_khz']) ?> kHz
                                    <?php if ($nav['dme_channel']): ?>
                                        <br><small>DME: <?= htmlspecialchars($nav['dme_channel']) ?></small>
                                    <?php endif; ?>
                                </td>
                                <td><?= htmlspecialchars($nav['iso_country']) ?></td>
                                <td><code><?= htmlspecialchars($nav['associated_airport'] ?? '-') ?></code></td>
                            </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>

                <?php if ($totalPages > 1): ?>
                <div class="pagination">
                    <?php for ($i = 1; $i <= min($totalPages, 10); $i++): ?>
                    <a href="?page=<?= $i ?>&search=<?= urlencode($search) ?>" class="<?= $page === $i ? 'active' : '' ?>"><?= $i ?></a>
                    <?php endfor; ?>
                </div>
                <?php endif; ?>
            </div>
        </main>
    </div>
</body>
</html>
