<?php
require_once 'db.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$airport = null;
$message = '';

// Load existing record if ID is provided
if ($id) {
    $stmt = $pdo->prepare("SELECT * FROM airports WHERE id = ?");
    $stmt->execute([$id]);
    $airport = $stmt->fetch(PDO::FETCH_ASSOC);
}

// Handle Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
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

    try {
        if ($id) {
            $sql = "UPDATE airports SET 
                ident=:ident, type=:type, name=:name, latitude_deg=:latitude_deg, longitude_deg=:longitude_deg, 
                elevation_ft=:elevation_ft, continent=:continent, iso_country=:iso_country, iso_region=:iso_region, 
                municipality=:municipality, scheduled_service=:scheduled_service, gps_code=:gps_code, 
                iata_code=:iata_code, icao_code=:icao_code, local_code=:local_code, home_link=:home_link, 
                wikipedia_link=:wikipedia_link, keywords=:keywords WHERE id=:id";
            $data['id'] = $id;
        } else {
            // Generate a new ID for manual adds if necessary, or let DB handle it if it was AUTO_INCREMENT
            // In db.php, airports.id is INT PRIMARY KEY but not AUTO_INCREMENT because it comes from source data.
            // For manual add, we might need to find the max ID + 1.
            $maxIdStmt = $pdo->query("SELECT MAX(id) FROM airports");
            $data['id'] = (int)$maxIdStmt->fetchColumn() + 1;
            
            $sql = "INSERT INTO airports (id, ident, type, name, latitude_deg, longitude_deg, elevation_ft, continent, iso_country, iso_region, municipality, scheduled_service, gps_code, iata_code, icao_code, local_code, home_link, wikipedia_link, keywords) 
                VALUES (:id, :ident, :type, :name, :latitude_deg, :longitude_deg, :elevation_ft, :continent, :iso_country, :iso_region, :municipality, :scheduled_service, :gps_code, :iata_code, :icao_code, :local_code, :home_link, :wikipedia_link, :keywords)";
        }
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute($data);
        $message = "Airport " . ($id ? "updated" : "added") . " successfully!";
        if (!$id) {
            header("Location: form.php?id=" . $data['id'] . "&msg=success");
            exit;
        }
    } catch (Exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

if (isset($_GET['msg']) && $_GET['msg'] === 'success') {
    $message = "Airport added successfully!";
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | <?= $id ? 'Edit' : 'Add' ?> Airport</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .form-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1.5rem; }
        .full-width { grid-column: span 2; }
    </style>
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
                <h2><?= $id ? 'Edit Airport: ' . htmlspecialchars($airport['name']) : 'Add New Airport' ?></h2>
                
                <?php if ($message): ?>
                    <div class="alert <?= strpos($message, 'Error') === false ? 'alert-success' : 'alert-error' ?>">
                        <?= htmlspecialchars($message) ?>
                    </div>
                <?php endif; ?>

                <form method="POST">
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Identifier (Ident)</label>
                            <input type="text" name="ident" value="<?= htmlspecialchars($airport['ident'] ?? '') ?>" required placeholder="e.g. HKJK">
                        </div>
                        <div class="form-group">
                            <label>Name</label>
                            <input type="text" name="name" value="<?= htmlspecialchars($airport['name'] ?? '') ?>" required placeholder="Airport Name">
                        </div>
                        <div class="form-group">
                            <label>Type</label>
                            <select name="type">
                                <option value="small_airport" <?= ($airport['type'] ?? '') === 'small_airport' ? 'selected' : '' ?>>Small Airport</option>
                                <option value="medium_airport" <?= ($airport['type'] ?? '') === 'medium_airport' ? 'selected' : '' ?>>Medium Airport</option>
                                <option value="large_airport" <?= ($airport['type'] ?? '') === 'large_airport' ? 'selected' : '' ?>>Large Airport</option>
                                <option value="heliport" <?= ($airport['type'] ?? '') === 'heliport' ? 'selected' : '' ?>>Heliport</option>
                                <option value="closed" <?= ($airport['type'] ?? '') === 'closed' ? 'selected' : '' ?>>Closed</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Municipality</label>
                            <input type="text" name="municipality" value="<?= htmlspecialchars($airport['municipality'] ?? '') ?>" placeholder="City/Municipality">
                        </div>
                        <div class="form-group">
                            <label>ISO Country</label>
                            <input type="text" name="iso_country" value="<?= htmlspecialchars($airport['iso_country'] ?? '') ?>" placeholder="e.g. KE" maxlength="2">
                        </div>
                        <div class="form-group">
                            <label>ISO Region</label>
                            <input type="text" name="iso_region" value="<?= htmlspecialchars($airport['iso_region'] ?? '') ?>" placeholder="e.g. KE-110">
                        </div>
                        <div class="form-group">
                            <label>Latitude (deg)</label>
                            <input type="number" step="any" name="latitude_deg" value="<?= htmlspecialchars($airport['latitude_deg'] ?? '') ?>">
                        </div>
                        <div class="form-group">
                            <label>Longitude (deg)</label>
                            <input type="number" step="any" name="longitude_deg" value="<?= htmlspecialchars($airport['longitude_deg'] ?? '') ?>">
                        </div>
                        <div class="form-group">
                            <label>Elevation (ft)</label>
                            <input type="number" name="elevation_ft" value="<?= htmlspecialchars($airport['elevation_ft'] ?? '') ?>">
                        </div>
                        <div class="form-group">
                            <label>Continent</label>
                            <input type="text" name="continent" value="<?= htmlspecialchars($airport['continent'] ?? '') ?>" placeholder="e.g. AF">
                        </div>
                        <div class="form-group">
                            <label>ICAO Code</label>
                            <input type="text" name="icao_code" value="<?= htmlspecialchars($airport['icao_code'] ?? '') ?>">
                        </div>
                        <div class="form-group">
                            <label>IATA Code</label>
                            <input type="text" name="iata_code" value="<?= htmlspecialchars($airport['iata_code'] ?? '') ?>">
                        </div>
                        <div class="form-group">
                            <label>GPS Code</label>
                            <input type="text" name="gps_code" value="<?= htmlspecialchars($airport['gps_code'] ?? '') ?>">
                        </div>
                        <div class="form-group">
                            <label>Local Code</label>
                            <input type="text" name="local_code" value="<?= htmlspecialchars($airport['local_code'] ?? '') ?>">
                        </div>
                        <div class="form-group">
                            <label>Scheduled Service</label>
                            <select name="scheduled_service">
                                <option value="yes" <?= ($airport['scheduled_service'] ?? '') === 'yes' ? 'selected' : '' ?>>Yes</option>
                                <option value="no" <?= ($airport['scheduled_service'] ?? '') === 'no' ? 'selected' : '' ?>>No</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Wikipedia Link</label>
                            <input type="url" name="wikipedia_link" value="<?= htmlspecialchars($airport['wikipedia_link'] ?? '') ?>">
                        </div>
                        <div class="form-group full-width">
                            <label>Keywords</label>
                            <textarea name="keywords"><?= htmlspecialchars($airport['keywords'] ?? '') ?></textarea>
                        </div>
                        <div class="form-group full-width">
                            <label>Home Link</label>
                            <input type="url" name="home_link" value="<?= htmlspecialchars($airport['home_link'] ?? '') ?>">
                        </div>

                    </div>
                    <button type="submit" class="btn">Save Airport</button>
                    <a href="index.php" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
