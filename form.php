require_once 'db.php';
require_once 'logger.php';

$type = isset($_GET['type']) ? $_GET['type'] : 'airports';
// ... (lines omitted for brevity in thought, but I must match exactly)
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$record = null;
$message = '';

$tableMap = [
    'airports' => 'airports',
    'aircraft' => 'aircraft',
    'notam_sources' => 'notam_sources',
    'licenses' => 'licenses'
];
$table = $tableMap[$type] ?? 'airports';

// Load existing record if ID is provided
if ($id) {
    $stmt = $pdo->prepare("SELECT * FROM $table WHERE id = ?");
    $stmt->execute([$id]);
    $record = $stmt->fetch(PDO::FETCH_ASSOC);
}

$categories = [];
if ($type === 'licenses') {
    $categories = $pdo->query("SELECT * FROM license_categories ORDER BY name ASC")->fetchAll(PDO::FETCH_ASSOC);
}

// Handle Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($type === 'airports') {
        $data = [
            'ident' => $_POST['ident'],
            'type' => $_POST['type'],
            'name' => $_POST['name'],
            'latitude_deg' => $_POST['latitude_deg'],
            'longitude_deg' => $_POST['longitude_deg'],
            'elevation_ft' => $_POST['elevation_ft'],
            'continent' => $_POST['continent'],
            'iso_country' => $_POST['iso_country'],
            'iso_region' => $_POST['iso_region'],
            'municipality' => $_POST['municipality'],
            'scheduled_service' => $_POST['scheduled_service'],
            'gps_code' => $_POST['gps_code'],
            'iata_code' => $_POST['iata_code'],
            'icao_code' => $_POST['icao_code'],
            'local_code' => $_POST['local_code'],
            'home_link' => $_POST['home_link'],
            'wikipedia_link' => $_POST['wikipedia_link'],
            'keywords' => $_POST['keywords'],
        ];
        
        $fields = array_keys($data);
        $placeholders = ":" . implode(", :", $fields);
        $updates = "";
        foreach($fields as $f) { $updates .= "$f=:$f, "; }
        $updates = rtrim($updates, ", ");

    } else {
        // Aircraft fields
        $data = [
            'model_name' => $_POST['model_name'],
            'iata_code' => $_POST['iata_code'],
            'icao_code' => $_POST['icao_code'],
            'type' => $_POST['type'],
            'engine_type' => $_POST['engine_type'],
            'engine_count' => (int)$_POST['engine_count'],
            'max_pax' => (int)$_POST['max_pax'],
        ];
        $fields = array_keys($data);
        $placeholders = ":" . implode(", :", $fields);
        $updates = "";
        foreach($fields as $f) { $updates .= "$f=:$f, "; }
        $updates = rtrim($updates, ", ");

    } elseif ($type === 'licenses') {
        $categoryId = (int)$_POST['category_id'];
        
        // Handle New Category creation
        if ($categoryId === -1 && !empty($_POST['new_category'])) {
            $catStmt = $pdo->prepare("INSERT OR IGNORE INTO license_categories (name) VALUES (?)");
            $catStmt->execute([trim($_POST['new_category'])]);
            $categoryId = $pdo->lastInsertId();
            if (!$categoryId) { // If IGNORE triggered, fetch existing
                $catStmt = $pdo->prepare("SELECT id FROM license_categories WHERE name = ?");
                $catStmt->execute([trim($_POST['new_category'])]);
                $categoryId = $catStmt->fetchColumn();
            }
        }

        $data = [
            'category_id' => $categoryId,
            'iso_country' => $_POST['iso_country'],
            'name' => $_POST['name'],
            'validity' => $_POST['validity'],
            'cost' => $_POST['cost'],
            'requirements' => $_POST['requirements'],
            'description' => $_POST['description']
        ];
        $fields = array_keys($data);
        $placeholders = ":" . implode(", :", $fields);
        $updates = "";
        foreach($fields as $f) { $updates .= "$f=:$f, "; }
        $updates = rtrim($updates, ", ");
    } else {

    try {
        if ($id) {
            $sql = "UPDATE $table SET $updates WHERE id=:id";
            $data['id'] = $id;
        } else {
            if ($type === 'airports') {
                $maxIdStmt = $pdo->query("SELECT MAX(id) FROM $table");
                $data['id'] = (int)$maxIdStmt->fetchColumn() + 1;
                $sql = "INSERT INTO $table (id, " . implode(", ", $fields) . ") VALUES (:id, $placeholders)";
            } else {
                // Aircraft has AUTO_INCREMENT ID
                $sql = "INSERT INTO $table (" . implode(", ", $fields) . ") VALUES ($placeholders)";
            }
        }
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute($data);
        
        $redirectId = $id ?: ($type === 'aircraft' ? $pdo->lastInsertId() : $data['id']);
        
        // Logging
        if ($id) {
            logAction($pdo, 'EDIT', $table, $id, $record, $data);
        } else {
            logAction($pdo, 'ADD', $table, $redirectId, null, $data);
        }

        header("Location: form.php?type=$type&id=$redirectId&msg=success");
        exit;

    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

if (isset($_GET['msg']) && $_GET['msg'] === 'success') {
    $message = ucfirst($type) . " saved successfully!";
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | <?= $id ? 'Edit' : 'Add' ?> <?= ucfirst($type) ?></title>
    <link rel="stylesheet" href="style.css">
    <style>
        .form-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1.5rem; }
        .full-width { grid-column: span 2; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <?php $active_page = 'directory'; include 'header.php'; ?>
        </header>

        <main>
            <div class="card">
                <h2><?= $id ? 'Edit ' . ucfirst($type) : 'Add New ' . ucfirst($type) ?></h2>
                
                <?php if ($message): ?>
                    <div class="alert <?= strpos($message, 'Error') === false ? 'alert-success' : 'alert-error' ?>">
                        <?= htmlspecialchars($message) ?>
                    </div>
                <?php endif; ?>

                <form method="POST">
                    <div class="form-grid">
                        <?php if ($type === 'airports'): ?>
                            <div class="form-group">
                                <label>Identifier (Ident)</label>
                                <input type="text" name="ident" value="<?= htmlspecialchars($record['ident'] ?? '') ?>" required>
                            </div>
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" name="name" value="<?= htmlspecialchars($record['name'] ?? '') ?>" required>
                            </div>
                            <div class="form-group">
                                <label>Type</label>
                                <select name="type">
                                    <option value="small_airport" <?= ($record['type'] ?? '') === 'small_airport' ? 'selected' : '' ?>>Small Airport</option>
                                    <option value="medium_airport" <?= ($record['type'] ?? '') === 'medium_airport' ? 'selected' : '' ?>>Medium Airport</option>
                                    <option value="large_airport" <?= ($record['type'] ?? '') === 'large_airport' ? 'selected' : '' ?>>Large Airport</option>
                                    <option value="heliport" <?= ($record['type'] ?? '') === 'heliport' ? 'selected' : '' ?>>Heliport</option>
                                </select>
                            </div>
                            <!-- ... other airport fields ... -->
                            <div class="form-group">
                                <label>Municipality</label>
                                <input type="text" name="municipality" value="<?= htmlspecialchars($record['municipality'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>ISO Country</label>
                                <input type="text" name="iso_country" value="<?= htmlspecialchars($record['iso_country'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>ISO Region</label>
                                <input type="text" name="iso_region" value="<?= htmlspecialchars($record['iso_region'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Latitude</label>
                                <input type="number" step="any" name="latitude_deg" value="<?= htmlspecialchars($record['latitude_deg'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Longitude</label>
                                <input type="number" step="any" name="longitude_deg" value="<?= htmlspecialchars($record['longitude_deg'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Elevation (ft)</label>
                                <input type="number" name="elevation_ft" value="<?= htmlspecialchars($record['elevation_ft'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Continent</label>
                                <input type="text" name="continent" value="<?= htmlspecialchars($record['continent'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>GPS Code</label>
                                <input type="text" name="gps_code" value="<?= htmlspecialchars($record['gps_code'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>IATA Code</label>
                                <input type="text" name="iata_code" value="<?= htmlspecialchars($record['iata_code'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>ICAO Code</label>
                                <input type="text" name="icao_code" value="<?= htmlspecialchars($record['icao_code'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Local Code</label>
                                <input type="text" name="local_code" value="<?= htmlspecialchars($record['local_code'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Scheduled Service</label>
                                <input type="text" name="scheduled_service" value="<?= htmlspecialchars($record['scheduled_service'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Home Link</label>
                                <input type="url" name="home_link" value="<?= htmlspecialchars($record['home_link'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Wikipedia Link</label>
                                <input type="url" name="wikipedia_link" value="<?= htmlspecialchars($record['wikipedia_link'] ?? '') ?>">
                            </div>
                            <div class="form-group full-width">
                                <label>Keywords</label>
                                <textarea name="keywords"><?= htmlspecialchars($record['keywords'] ?? '') ?></textarea>
                            </div>

                        <?php else: ?>
                            <div class="form-group">
                                <label>Model Name</label>
                                <input type="text" name="model_name" value="<?= htmlspecialchars($record['model_name'] ?? '') ?>" required>
                            </div>
                            <div class="form-group">
                                <label>IATA Code</label>
                                <input type="text" name="iata_code" value="<?= htmlspecialchars($record['iata_code'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>ICAO Code</label>
                                <input type="text" name="icao_code" value="<?= htmlspecialchars($record['icao_code'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Type</label>
                                <input type="text" name="type" value="<?= htmlspecialchars($record['type'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Engine Type</label>
                                <input type="text" name="engine_type" value="<?= htmlspecialchars($record['engine_type'] ?? '') ?>">
                            </div>
                            <div class="form-group">
                                <label>Engine Count</label>
                                <input type="number" name="engine_count" value="<?= htmlspecialchars($record['engine_count'] ?? '0') ?>">
                            </div>
                            <div class="form-group">
                                <label>Max Pax</label>
                                <input type="number" name="max_pax" value="<?= htmlspecialchars($record['max_pax'] ?? '0') ?>">
                            </div>
                        <?php endif; ?>

                        <?php if ($type === 'notam_sources'): ?>
                            <div class="form-group">
                                <label>ISO Country Code (e.g., KE)</label>
                                <input type="text" name="iso_country" value="<?= htmlspecialchars($record['iso_country'] ?? '') ?>" placeholder="KE" required>
                            </div>
                            <div class="form-group">
                                <label>Country Name</label>
                                <input type="text" name="country_name" value="<?= htmlspecialchars($record['country_name'] ?? '') ?>" placeholder="Kenya" required>
                            </div>
                            <div class="form-group">
                                <label>Official Authority Name</label>
                                <input type="text" name="official_source_name" value="<?= htmlspecialchars($record['official_source_name'] ?? '') ?>" placeholder="Kenya Civil Aviation Authority" required>
                            </div>
                            <div class="form-group">
                                <label>Notam Portal URL</label>
                                <input type="url" name="notam_portal_url" value="<?= htmlspecialchars($record['notam_portal_url'] ?? '') ?>" placeholder="https://..." required>
                            </div>
                            <div class="form-group">
                                <label>ICAO NOF Code</label>
                                <input type="text" name="icao_nof_code" value="<?= htmlspecialchars($record['icao_nof_code'] ?? '') ?>" placeholder="HKJK">
                            </div>
                            <div class="form-group" style="grid-column: span 2;">
                                <label>Notes</label>
                                <textarea name="notes" rows="3"><?= htmlspecialchars($record['notes'] ?? '') ?></textarea>
                            </div>
                        <?php endif; ?>
                    </div>
                    <div style="margin-top: 2rem;">
                        <button type="submit" class="btn">Save <?= ucfirst($type) ?></button>
                        <a href="index.php?type=<?= $type ?>" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
