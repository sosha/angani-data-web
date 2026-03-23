<?php
require_once 'db.php';
require_once 'logger.php';

if (!isset($_GET['id'])) {
    header("Location: logs.php");
    exit;
}

$id = (int)$_GET['id'];

// Fetch the log entry
$stmt = $pdo->prepare("SELECT * FROM audit_logs WHERE id = ?");
$stmt->execute([$id]);
$log = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$log) {
    die("Log entry not found.");
}

$table = $log['table_name'];
$recordId = $log['record_id'];
$oldData = json_decode($log['old_data'], true);
$newData = json_decode($log['new_data'], true);

try {
    switch ($log['action_type']) {
        case 'ADD':
            // To undo an ADD, we DELETE the record
            $pdo->prepare("DELETE FROM $table WHERE id = ?")->execute([$recordId]);
            logAction($pdo, 'UNDO_ADD', $table, $recordId, $newData, null);
            break;

        case 'DELETE':
            // To undo a DELETE, we re-INSERT the old data
            $fields = array_keys($oldData);
            $placeholders = array_fill(0, count($fields), '?');
            $sql = "INSERT INTO $table (" . implode(', ', $fields) . ") VALUES (" . implode(', ', $placeholders) . ")";
            $pdo->prepare($sql)->execute(array_values($oldData));
            logAction($pdo, 'UNDO_DELETE', $table, $recordId, null, $oldData);
            break;

        case 'EDIT':
            // To undo an EDIT, we restore the OLD data
            $fields = array_keys($oldData);
            $sets = [];
            foreach ($fields as $f) {
                if ($f === 'id' || $f === 'last_updated') continue;
                $sets[] = "$f = ?";
            }
            $sql = "UPDATE $table SET " . implode(', ', $sets) . " WHERE id = ?";
            // Prep params: old values then the record ID
            $params = [];
            foreach ($fields as $f) {
                if ($f === 'id' || $f === 'last_updated') continue;
                $params[] = $oldData[$f];
            }
            $params[] = $recordId;
            $pdo->prepare($sql)->execute($params);
            logAction($pdo, 'UNDO_EDIT', $table, $recordId, $newData, $oldData);
            break;
    }

    // Optional: Delete the log entry or mark it as undone? 
    // Usually better to keep it and log the UNDO action itself.
    
    header("Location: logs.php?message=Undo successful");
} catch (Exception $e) {
    die("Undo failed: " . $e->getMessage());
}
?>
