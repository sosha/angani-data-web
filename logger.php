<?php
require_once 'db.php';

function logAction($pdo, $action, $table, $id, $oldData = null, $newData = null) {
    $stmt = $pdo->prepare("INSERT INTO audit_logs (action_type, table_name, record_id, old_data, new_data) VALUES (?, ?, ?, ?, ?)");
    $stmt->execute([
        $action,
        $table,
        $id,
        $oldData ? json_encode($oldData) : null,
        $newData ? json_encode($newData) : null
    ]);
}
?>
