<?php
require_once 'db.php';

// Pagination Settings
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 20;
$offset = ($page - 1) * $perPage;

// Search/Filter Logic
$search = isset($_GET['search']) ? $_GET['search'] : '';
$where = "1=1";
$params = [];

if ($search) {
    $where = "(name LIKE ? OR ident LIKE ? OR iata_code LIKE ? OR iso_country = ?)";
    $params = ["%$search%", "%$search%", $search, $search];
}

// Get Total Count
$countStmt = $pdo->prepare("SELECT COUNT(*) FROM airports WHERE $where");
$countStmt->execute($params);
$totalRecords = $countStmt->fetchColumn();
$totalPages = ceil($totalRecords / $perPage);

// Fetch airport records for the current page
$stmt = $pdo->prepare("SELECT * FROM airports WHERE $where ORDER BY name LIMIT $perPage OFFSET $offset");
$stmt->execute($params);
$airports = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Airport Viewer</title>
    <link rel="stylesheet" href="style.css">
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
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                    <h2>Airport Directory</h2>
                    <form method="GET" style="display: flex; gap: 0.5rem;">
                        <input type="text" name="search" placeholder="Search name, code, country..." value="<?= htmlspecialchars($search) ?>" style="width: 300px;">
                        <button type="submit" class="btn">Search</button>
                    </form>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Ident</th>
                            <th>ICAO</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Municipality</th>
                            <th>Country</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($airports)): ?>
                        <tr><td colspan="7" style="text-align: center;">No airports found. Use Bulk Import to get started.</td></tr>
                        <?php else: ?>
                            <?php foreach ($airports as $airport): ?>
                            <tr>
                                <td><code><?= htmlspecialchars($airport['ident']) ?></code></td>
                                <td><code><?= htmlspecialchars($airport['icao_code'] ?? '-') ?></code></td>
                                <td><?= htmlspecialchars($airport['name']) ?></td>
                                <td><?= htmlspecialchars(str_replace('_', ' ', $airport['type'])) ?></td>
                                <td><?= htmlspecialchars($airport['municipality']) ?></td>
                                <td><?= htmlspecialchars($airport['iso_country']) ?></td>
                                <td style="display: flex; gap: 0.3rem;">
                                    <a href="weather.php?ident=<?= $airport['ident'] ?>" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: var(--success-color);" title="Weather">WX</a>
                                    <a href="notams.php?ident=<?= $airport['ident'] ?>" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #f59e0b;" title="NOTAMs">NT</a>
                                    <a href="frequencies.php?ident=<?= $airport['ident'] ?>" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #3b82f6;" title="Frequencies">FR</a>
                                    <a href="form.php?id=<?= $airport['id'] ?>" class="btn btn-secondary" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Edit</a>
                                    <a href="delete.php?id=<?= $airport['id'] ?>" class="btn btn-danger" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;" onclick="return confirm('Are you sure?')">Del</a>
                                </td>
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
