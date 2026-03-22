<?php
require_once 'db.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($id) {
    try {
        $stmt = $pdo->prepare("DELETE FROM airports WHERE id = ?");
        $stmt->execute([$id]);
        header("Location: index.php?msg=deleted");
        exit;
    } catch (Exception $e) {
        die("Error deleting: " . $e->getMessage());
    }
}
header("Location: index.php");
?>
