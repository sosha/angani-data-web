<?php
require_once 'db.php';
$pdo = AnganiDB::getInstance();

// Pagination Settings
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 20;
$offset = ($page - 1) * $perPage;

// Search/Filter Logic
$search = isset($_GET['search']) ? $_GET['search'] : '';
// View Type (Airports vs Aircraft)
$type = isset($_GET['type']) ? $_GET['type'] : 'airports';

// Sorting Logic
$sort = isset($_GET['sort']) ? $_GET['sort'] : ($type === 'aircraft' ? 'model_name' : 'name');
$order = isset($_GET['order']) && strtolower($_GET['order']) === 'desc' ? 'DESC' : 'ASC';

// Whitelist columns to prevent SQL injection
if ($type === 'airports') {
    $allowedSort = ['ident', 'icao_code', 'name', 'type', 'municipality', 'iso_country'];
} elseif ($type === 'navaids') {
    $allowedSort = ['ident', 'name', 'type', 'frequency_khz', 'iso_country'];
} elseif ($type === 'frequencies') {
    $allowedSort = ['airport_ident', 'type', 'description', 'frequency_mhz'];
} elseif ($type === 'notam_sources') {
    $allowedSort = ['iso_country', 'country_name', 'official_source_name'];
} elseif ($type === 'licenses') {
    $allowedSort = ['name', 'iso_country', 'validity', 'category_name'];
} else {
    $allowedSort = ['model_name', 'iata_code', 'icao_code', 'type', 'engine_type', 'max_pax'];
}
if (!in_array($sort, $allowedSort)) {
    $sort = ($type === 'aircraft' ? 'model_name' : ($type === 'frequencies' ? 'airport_ident' : 'name'));
}

$where = "1=1";
$params = [];

if ($search) {
    if ($type === 'airports') {
        $where .= " AND (name LIKE ? OR ident LIKE ? OR iata_code LIKE ? OR iso_country = ?)";
        $params = ["%$search%", "%$search%", $search, $search];
    } elseif ($type === 'navaids') {
        $where .= " AND (name LIKE ? OR ident LIKE ? OR iso_country = ?)";
        $params = ["%$search%", "%$search%", $search];
    } elseif ($type === 'frequencies') {
        $where .= " AND (airport_ident LIKE ? OR description LIKE ?)";
        $params = ["%$search%", "%$search%"];
    } elseif ($type === 'notam_sources') {
        $where .= " AND (country_name LIKE ? OR iso_country LIKE ? OR official_source_name LIKE ?)";
        $params = ["%$search%", "%$search%", "%$search%"];
    } elseif ($type === 'licenses') {
        $where .= " AND (l.name LIKE ? OR l.iso_country LIKE ? OR c.name LIKE ?)";
        $params = ["%$search%", "%$search%", "%$search%"];
    } else {
        $where .= " AND (model_name LIKE ? OR iata_code LIKE ? OR icao_code LIKE ?)";
        $params = ["%$search%", "%$search%", "%$search%"];
    }
}

// Get Total Count
$table = ($type === 'aircraft') ? 'aircraft' : 'airports';
/** @var PDO $pdo */
$countStmt = $pdo->prepare("SELECT COUNT(*) FROM $table WHERE $where");
$countStmt->execute($params);
$totalRecords = $countStmt->fetchColumn();
$totalPages = ceil($totalRecords / $perPage);

// Get Records
$stmt = $pdo->prepare("SELECT * FROM $table WHERE $where ORDER BY $sort $order LIMIT $perPage OFFSET $offset");
$stmt->execute($params);
$records = $stmt->fetchAll(PDO::FETCH_ASSOC);

function sortLink($col, $currentSort, $currentOrder, $currentType, $currentSearch) {
    $newOrder = ($currentSort === $col && $currentOrder === 'ASC') ? 'desc' : 'asc';
    $icon = ($currentSort === $col) ? ($currentOrder === 'ASC' ? ' ↑' : ' ↓') : '';
    return "?type=$currentType&search=" . urlencode($currentSearch) . "&sort=$col&order=$newOrder" . "#table-top";
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Directory Viewer</title>
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
                    <div style="display: flex; gap: 1rem; align-items: center;">
                        <h3 style="margin: 0;"><?= ucfirst($type) ?> List</h3>
                        <div class="btn-group">
                            <a href="?type=airports" class="btn <?= $type === 'airports' ? '' : 'btn-secondary' ?>" style="padding: 0.5rem 1rem;">Airports</a>
                            <a href="?type=aircraft" class="btn <?= $type === 'aircraft' ? '' : 'btn-secondary' ?>" style="padding: 0.5rem 1rem;">Aircraft</a>
                            <a href="?type=navaids" class="btn <?= $type === 'navaids' ? '' : 'btn-secondary' ?>" style="padding: 0.5rem 1rem;">Navaids</a>
                            <a href="?type=frequencies" class="btn <?= $type === 'frequencies' ? '' : 'btn-secondary' ?>" style="padding: 0.5rem 1rem;">Frequencies</a>
                            <a href="?type=notam_sources" class="btn <?= $type === 'notam_sources' ? '' : 'btn-secondary' ?>" style="padding: 0.5rem 1rem;">NOTAM Sources</a>
                            <a href="?type=licenses" class="btn <?= $type === 'licenses' ? '' : 'btn-secondary' ?>" style="padding: 0.5rem 1rem;">Licensing</a>
                        </div>
                    </div>
                    <form method="GET" style="display: flex; gap: 0.5rem;">
                        <input type="hidden" name="type" value="<?= htmlspecialchars($type) ?>">
                        <input type="text" name="search" placeholder="Search <?= $type ?>..." value="<?= htmlspecialchars($search) ?>" style="width: 300px;">
                        <button type="submit" class="btn">Filter</button>
                    </form>
                </div>

                <table id="table-top">
                    <thead>
                        <?php if ($type === 'airports'): ?>
                        <tr>
                            <th><a href="<?= sortLink('ident', $sort, $order, $type, $search) ?>">Ident<?= $sort === 'ident' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('icao_code', $sort, $order, $type, $search) ?>">ICAO<?= $sort === 'icao_code' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('name', $sort, $order, $type, $search) ?>">Name<?= $sort === 'name' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('type', $sort, $order, $type, $search) ?>">Type<?= $sort === 'type' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('municipality', $sort, $order, $type, $search) ?>">Municipality<?= $sort === 'municipality' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('iso_country', $sort, $order, $type, $search) ?>">Country<?= $sort === 'iso_country' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th>Actions</th>
                        </tr>
                        <?php elseif ($type === 'navaids'): ?>
                        <tr>
                            <th>Ident</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Freq (kHz)</th>
                            <th>Country</th>
                            <th>Actions</th>
                        </tr>
                        <?php elseif ($type === 'frequencies'): ?>
                        <tr>
                            <th>Airport</th>
                            <th>Type</th>
                            <th>Description</th>
                            <th>Freq (MHz)</th>
                            <th>Actions</th>
                        </tr>
                        <?php elseif ($type === 'licenses'): ?>
                        <tr>
                            <th><a href="<?= sortLink('iso_country', $sort, $order, $type, $search) ?>">Country</a></th>
                            <th><a href="<?= sortLink('category_name', $sort, $order, $type, $search) ?>">Category</a></th>
                            <th><a href="<?= sortLink('name', $sort, $order, $type, $search) ?>">License/Permit Name</a></th>
                            <th><a href="<?= sortLink('validity', $sort, $order, $type, $search) ?>">Validity</a></th>
                            <th>Cost</th>
                            <th>Actions</th>
                        </tr>
                        <?php else: ?>
                        <tr>
                            <th><a href="<?= sortLink('model_name', $sort, $order, $type, $search) ?>">Model Name<?= $sort === 'model_name' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('iata_code', $sort, $order, $type, $search) ?>">IATA<?= $sort === 'iata_code' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('icao_code', $sort, $order, $type, $search) ?>">ICAO<?= $sort === 'icao_code' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('type', $sort, $order, $type, $search) ?>">Type<?= $sort === 'type' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('engine_type', $sort, $order, $type, $search) ?>">Engine<?= $sort === 'engine_type' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th><a href="<?= sortLink('max_pax', $sort, $order, $type, $search) ?>">Pax<?= $sort === 'max_pax' ? ($order === 'ASC' ? ' ↑' : ' ↓') : '' ?></a></th>
                            <th>Actions</th>
                        </tr>
                        <?php endif; ?>
                    </thead>
                    <tbody>
                        <?php if (empty($records)): ?>
                        <tr><td colspan="7" style="text-align: center;">No <?= $type ?> found.</td></tr>
                        <?php else: ?>
                            <?php foreach ($records as $record): ?>
                            <tr>
                                <?php if ($type === 'airports'): ?>
                                <td><code><?= htmlspecialchars($record['ident']) ?></code></td>
                                <td><?= htmlspecialchars($record['icao_code'] ?? '-') ?></td>
                                <td><?= htmlspecialchars($record['name']) ?></td>
                                <td><?= htmlspecialchars(str_replace('_', ' ', $record['type'])) ?></td>
                                <td><?= htmlspecialchars($record['municipality']) ?></td>
                                <td><?= htmlspecialchars($record['iso_country']) ?></td>
                                <?php elseif ($type === 'navaids'): ?>
                                <td><code><?= htmlspecialchars($record['ident']) ?></code></td>
                                <td><?= htmlspecialchars($record['name']) ?></td>
                                <td><?= htmlspecialchars($record['type']) ?></td>
                                <td><?= htmlspecialchars($record['frequency_khz']) ?></td>
                                <td><?= htmlspecialchars($record['iso_country']) ?></td>
                                <?php elseif ($type === 'frequencies'): ?>
                                <td><code><?= htmlspecialchars($record['airport_ident']) ?></code></td>
                                <td><?= htmlspecialchars($record['type']) ?></td>
                                <td><?= htmlspecialchars($record['description']) ?></td>
                                <td><?= htmlspecialchars($record['frequency_mhz']) ?> MHz</td>
                                <?php elseif ($type === 'notam_sources'): ?>
                                <td><code><?= htmlspecialchars($record['iso_country']) ?></code></td>
                                <td><?= htmlspecialchars($record['country_name']) ?></td>
                                <td><?= htmlspecialchars($record['official_source_name']) ?></td>
                                <td><a href="<?= htmlspecialchars($record['notam_portal_url']) ?>" target="_blank" style="font-size: 0.8rem;">Visit Portal ↗</a></td>
                                <td><code><?= htmlspecialchars($record['icao_nof_code'] ?? '-') ?></code></td>
                                <?php elseif ($type === 'licenses'): ?>
                                <td><code><?= htmlspecialchars($record['iso_country']) ?></code></td>
                                <td><?= htmlspecialchars($record['category_name']) ?></td>
                                <td><strong><?= htmlspecialchars($record['name']) ?></strong></td>
                                <td><?= htmlspecialchars($record['validity']) ?></td>
                                <td><?= htmlspecialchars($record['cost']) ?></td>
                                <?php else: ?>
                                <td><strong><?= htmlspecialchars($record['model_name']) ?></strong></td>
                                <td><?= htmlspecialchars($record['iata_code'] ?? '-') ?></td>
                                <td><?= htmlspecialchars($record['icao_code'] ?? '-') ?></td>
                                <td><?= htmlspecialchars($record['type'] ?? '-') ?></td>
                                <td><?= htmlspecialchars($record['engine_type'] ?? '-') ?></td>
                                <td><?= htmlspecialchars($record['max_pax'] ?? '-') ?></td>
                                <?php endif; ?>
                                <td style="display: flex; gap: 0.3rem;">
                                    <a href="view.php?type=<?= $type ?>&id=<?= $record['id'] ?>" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #6366f1;" title="View Detail">View</a>
                                    <?php if ($type === 'airports'): ?>
                                    <a href="weather.php?ident=<?= $record['ident'] ?>" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: var(--success-color);" title="Weather">WX</a>
                                    <a href="notams.php?ident=<?= $record['ident'] ?>" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #f59e0b;" title="NOTAMs">NT</a>
                                    <a href="frequencies.php?ident=<?= $record['ident'] ?>" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #3b82f6;" title="Frequencies">FR</a>
                                    <?php endif; ?>
                                    <a href="form.php?type=<?= $type ?>&id=<?= $record['id'] ?>" class="btn btn-secondary" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Edit</a>
                                    <a href="delete.php?type=<?= $type ?>&id=<?= $record['id'] ?>" class="btn btn-danger" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;" onclick="return confirm('Are you sure?')">Del</a>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>

                <?php if ($totalPages > 1): ?>
                <div class="pagination">
                    <?php for ($i = 1; $i <= min($totalPages, 10); $i++): ?>
                    <a href="?type=<?= $type ?>&page=<?= $i ?>&search=<?= urlencode($search) ?>&sort=<?= $sort ?>&order=<?= $order ?>" class="<?= $page === $i ? 'active' : '' ?>"><?= $i ?></a>
                    <?php endfor; ?>
                </div>
                <?php endif; ?>
            </div>
        </main>
    </div>
</body>
</html>
