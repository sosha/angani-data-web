<?php
require_once 'db.php';

// Pagination
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 20;
$offset = ($page - 1) * $perPage;

// Get Logs
$countStmt = $pdo->query("SELECT COUNT(*) FROM audit_logs");
$totalLogs = $countStmt->fetchColumn();
$totalPages = ceil($totalLogs / $perPage);

$stmt = $pdo->prepare("SELECT * FROM audit_logs ORDER BY created_at DESC LIMIT ? OFFSET ?");
$stmt->bindValue(1, $perPage, PDO::PARAM_INT);
$stmt->bindValue(2, $offset, PDO::PARAM_INT);
$stmt->execute();
$logs = $stmt->fetchAll(PDO::FETCH_ASSOC);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Activity Logs</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .log-badge { padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem; font-weight: bold; text-transform: uppercase; }
        .badge-add { background: var(--success-color); color: #000; }
        .badge-edit { background: #3b82f6; color: #fff; }
        .badge-delete { background: var(--danger-color); color: #fff; }
        .badge-import { background: #8b5cf6; color: #fff; }
        .badge-export { background: #f59e0b; color: #fff; }
        .json-view { font-family: monospace; font-size: 0.8rem; color: var(--text-muted); white-space: pre-wrap; max-width: 300px; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <?php $active_page = 'admin'; include 'header.php'; ?>
        </header>

        <main>
            <div class="card">
                <h2>Activity Logs & Undo History</h2>
                <p class="text-muted">Track all changes made to the aviation datasets. You can review adding, editing, and deleting actions here.</p>

                <table>
                    <thead>
                        <tr>
                            <th>Time</th>
                            <th>Action</th>
                            <th>Table</th>
                            <th>Record ID</th>
                            <th>Details</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($logs)): ?>
                            <tr><td colspan="6" style="text-align: center;">No activity recorded yet.</td></tr>
                        <?php else: ?>
                            <?php foreach ($logs as $log): ?>
                                <tr>
                                    <td><?= date('Y-m-d H:i', strtotime($log['created_at'])) ?></td>
                                    <td><span class="log-badge badge-<?= strtolower($log['action_type']) ?>"><?= htmlspecialchars($log['action_type']) ?></span></td>
                                    <td><?= htmlspecialchars($log['table_name'] ?? '-') ?></td>
                                    <td><code>#<?= htmlspecialchars($log['record_id'] ?? '-') ?></code></td>
                                    <td>
                                        <div class="json-view"><?php 
                                            if ($log['action_type'] === 'EDIT') {
                                                echo "Changed fields detected.";
                                            } elseif ($log['action_type'] === 'ADD') {
                                                echo "New record created.";
                                            } else {
                                                echo "-";
                                            }
                                        ?></div>
                                    </td>
                                    <td>
                                        <?php if (in_array($log['action_type'], ['ADD', 'EDIT', 'DELETE'])): ?>
                                            <a href="undo.php?id=<?= $log['id'] ?>" class="btn btn-secondary" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;" onclick="return confirm('Attempting to undo this action. Proceed?')">Undo</a>
                                        <?php else: ?>
                                            <span class="text-muted" style="font-size: 0.8rem;">N/A</span>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>

                <?php if ($totalPages > 1): ?>
                <div class="pagination">
                    <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                        <a href="?page=<?= $i ?>" class="<?= $page === $i ? 'active' : '' ?>"><?= $i ?></a>
                    <?php endfor; ?>
                </div>
                <?php endif; ?>
            </div>
        </main>
    </div>
</body>
</html>
