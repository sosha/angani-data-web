<?php
require_once 'db.php';

$type = isset($_GET['type']) ? $_GET['type'] : 'airports';
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$record = null;

if ($id) {
    $table = ($type === 'aircraft') ? 'aircraft' : 'airports';
    $stmt = $pdo->prepare("SELECT * FROM $table WHERE id = ?");
    $stmt->execute([$id]);
    $record = $stmt->fetch(PDO::FETCH_ASSOC);
}

if (!$record) {
    header("Location: index.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | View <?= ucfirst($type) ?></title>
    <link rel="stylesheet" href="style.css">
    <?php if ($type === 'airports' && $record['latitude_deg'] && $record['longitude_deg']): ?>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <?php endif; ?>
    <style>
        .detail-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-top: 1.5rem; }
        .detail-item { padding: 1rem; background: rgba(255,255,255,0.03); border-radius: 0.5rem; border: 1px solid var(--border); }
        .detail-item label { color: var(--text-muted); font-size: 0.8rem; display: block; margin-bottom: 0.2rem; text-transform: uppercase; letter-spacing: 0.05em; }
        .detail-item p { margin: 0; font-weight: 500; font-size: 1.1rem; }
        #map { height: 400px; border-radius: 1rem; margin-top: 2rem; border: 1px solid var(--border); z-index: 1; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <?php $active_page = 'directory'; include 'header.php'; ?>
        </header>

        <main>
            <div class="card">
                <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                    <div>
                        <h2><?= ucfirst($type) ?> Details</h2>
                        <p class="text-muted">ID: <?= $record['id'] ?> | Created/Updated: <?= $record['last_updated'] ?></p>
                    </div>
                    <div style="display: flex; gap: 0.5rem;">
                        <a href="form.php?type=<?= $type ?>&id=<?= $id ?>" class="btn">Edit Record</a>
                        <a href="index.php?type=<?= $type ?>" class="btn btn-secondary">Back to List</a>
                    </div>
                </div>

                <div class="detail-grid">
                    <?php foreach ($record as $key => $value): ?>
                        <?php if ($key !== 'id' && $key !== 'last_updated'): ?>
                            <div class="detail-item">
                                <label><?= str_replace('_', ' ', htmlspecialchars($key)) ?></label>
                                <p><?= $value ? htmlspecialchars($value) : '<em class="text-muted">N/A</em>' ?></p>
                            </div>
                        <?php endif; ?>
                    <?php endforeach; ?>
                </div>

                <?php if ($type === 'airports' && $record['latitude_deg'] && $record['longitude_deg']): ?>
                    <div id="map"></div>
                    <script>
                        var map = L.map('map').setView([<?= $record['latitude_deg'] ?>, <?= $record['longitude_deg'] ?>], 13);
                        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                            attribution: '© OpenStreetMap contributors'
                        }).addTo(map);
                        L.marker([<?= $record['latitude_deg'] ?>, <?= $record['longitude_deg'] ?>]).addTo(map)
                            .bindPopup('<b><?= htmlspecialchars($record['name']) ?></b><br><?= htmlspecialchars($record['ident']) ?>')
                            .openPopup();
                    </script>
                <?php endif; ?>

                <?php if ($type === 'aircraft'): ?>
                    <div id="tech-specs" class="card" style="margin-top: 2rem; background: rgba(99, 102, 241, 0.05); border: 1px solid var(--accent-color);">
                        <h3>🔍 Technical Specifications</h3>
                        <p id="specs-loading" class="text-muted">Fetching deep technical data...</p>
                        <div id="specs-content" class="detail-grid" style="display: none;">
                            <!-- Populated via JS -->
                        </div>
                    </div>
                    <script>
                        const icao = '<?= htmlspecialchars($record['icao_code'] ?? '') ?>';
                        const tail = '<?= htmlspecialchars($record['iata_code'] ?? '') ?>'; // Using iata_code as registration placeholder if available
                        
                        fetch(`aircraft_specs_api.php?tail=${tail}&icao=${icao}`)
                            .then(res => res.json())
                            .then(data => {
                                const loading = document.getElementById('specs-loading');
                                const content = document.getElementById('specs-content');
                                
                                if (data.demo) {
                                    loading.innerHTML = `<em>${data.message} (Showing Sample Data)</em>`;
                                } else {
                                    loading.style.display = 'none';
                                }
                                
                                const specs = data.demo ? data.data : {
                                    'Manufacturer': data.productionLine || 'N/A',
                                    'Model': data.modelName || 'N/A',
                                    'Engine Count': data.engineCount || 'N/A',
                                    'Engine Type': data.engineType || 'N/A',
                                    'Max Seats': data.maxSeats || 'N/A',
                                    'Age': data.ageYears ? data.ageYears + ' years' : 'N/A'
                                };

                                content.innerHTML = Object.entries(specs).map(([label, val]) => `
                                    <div class="detail-item">
                                        <label>${label}</label>
                                        <p>${val}</p>
                                    </div>
                                `).join('');
                                content.style.display = 'grid';
                            })
                            .catch(err => {
                                document.getElementById('specs-loading').innerText = 'Failed to load technical specifications.';
                            });
                    </script>
                <?php endif; ?>

                <?php if ($type === 'airports'): ?>
                    <div style="margin-top: 2rem; display: flex; gap: 1rem;">
                        <a href="weather.php?ident=<?= $record['ident'] ?>" class="btn btn-secondary">Check Weather (WX)</a>
                        <a href="notams.php?ident=<?= $record['ident'] ?>" class="btn btn-secondary">Check NOTAMs (NT)</a>
                        <a href="frequencies.php?ident=<?= $record['ident'] ?>" class="btn btn-secondary">Airport Frequencies (FR)</a>
                    </div>
                <?php endif; ?>
            </div>
        </main>
    </div>
</body>
</html>
