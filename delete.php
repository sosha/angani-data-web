require_once 'db.php';
require_once 'logger.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$type = isset($_GET['type']) ? $_GET['type'] : 'airports';

if ($id) {
    try {
        $table = ($type === 'aircraft') ? 'aircraft' : (($type === 'notam_sources') ? 'notam_sources' : 'airports');
        
        // Fetch old data for Undo
        $oldStmt = $pdo->prepare("SELECT * FROM $table WHERE id = ?");
        $oldStmt->execute([$id]);
        $oldData = $oldStmt->fetch(PDO::FETCH_ASSOC);

        if ($oldData) {
            $stmt = $pdo->prepare("DELETE FROM $table WHERE id = ?");
            $stmt->execute([$id]);
            logAction($pdo, 'DELETE', $table, $id, $oldData, null);
        }

        header("Location: viewer.php?type=$type&msg=deleted");
        exit;
    } catch (Exception $e) {
        die("Error deleting: " . $e->getMessage());
    }
}
header("Location: index.php?type=$type");
?>
