<?php
require_once 'db.php';

$message = '';
$importType = isset($_POST['type']) ? $_POST['type'] : '';
$country = isset($_POST['country']) ? $_POST['country'] : '';

// Handle Import Request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $importType) {
    $count = 0;
    $filePath = '';
    
    if ($importType === 'airports' && $country) {
        $filePath = "../angani-data/datasets/Countries/$country/airports/airports.csv";
    } elseif ($importType === 'airlines' && $country) {
        $filePath = "../angani-data/datasets/Countries/$country/airlines/airlines.csv";
    } elseif ($importType === 'aircraft') {
        $filePath = "../angani-data/datasets/Aircraft/aircraft.csv";
    } elseif ($importType === 'navaids') {
        $filePath = "../angani-data/datasets/Global/navaids.csv";
    } elseif ($importType === 'frequencies') {
        $filePath = "../angani-data/datasets/Global/frequencies.csv";
    }

    if ($filePath && file_exists($filePath)) {
        $handle = fopen($filePath, "r");
        
        // Skip header row for structured datasets
        if ($importType !== 'aircraft') {
            fgetcsv($handle);
        }

        try {
            $pdo->beginTransaction();
            
            // Bulk Insert Logic based on Dataset Type
            if ($importType === 'airports') {
                $stmt = $pdo->prepare("INSERT INTO airports (id, ident, type, name, latitude_deg, longitude_deg, elevation_ft, continent, iso_country, iso_region, municipality, scheduled_service, icao_code, iata_code, gps_code, local_code, home_link, wikipedia_link, keywords) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) 
                    ON DUPLICATE KEY UPDATE name=VALUES(name), type=VALUES(type)");
                while (($data = fgetcsv($handle)) !== FALSE) {
                    if (count($data) >= 19) {
                        // Reorder to match: id,ident,type,name,latitude_deg,longitude_deg,elevation_ft,continent,iso_country,iso_region,municipality,scheduled_service,icao_code,iata_code,gps_code,local_code,home_link,wikipedia_link,keywords
                        // The CSV had: id(0),ident(1),type(2),name(3),lat(4),lon(5),elev(6),cont(7),country(8),region(9),mun(10),sched(11),icao(12),iata(13),gps(14),local(15),home(16),wiki(17),key(18)
                        $stmt->execute($data);
                        $count++;
                    }
                }
            } elseif ($importType === 'airlines') {
                $stmt = $pdo->prepare("INSERT INTO airlines (airline_id, name, alias, iata, icao, callsign, country, active) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?) 
                    ON DUPLICATE KEY UPDATE name=VALUES(name)");
                while (($data = fgetcsv($handle)) !== FALSE) {
                    if (count($data) >= 8) {
                        $stmt->execute(array_slice($data, 0, 8));
                        $count++;
                    }
                }
            } elseif ($importType === 'aircraft') {
                $stmt = $pdo->prepare("INSERT INTO aircraft (model_name, iata_code, icao_code) VALUES (?, ?, ?)");
                while (($data = fgetcsv($handle)) !== FALSE) {
                    if (count($data) >= 3) {
                        $stmt->execute(array_slice($data, 0, 3));
                        $count++;
                    }
                }
            } elseif ($importType === 'navaids') {
                $stmt = $pdo->prepare("INSERT INTO navaids (id, filename, ident, name, type, frequency_khz, latitude_deg, longitude_deg, elevation_ft, iso_country, dme_frequency_khz, dme_channel, dme_latitude_deg, dme_longitude_deg, dme_elevation_ft, slaved_variation_deg, magnetic_variation_deg, usageType, power, associated_airport) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) 
                    ON DUPLICATE KEY UPDATE name=VALUES(name)");
                while (($data = fgetcsv($handle)) !== FALSE) {
                    if (count($data) >= 20) {
                        $stmt->execute(array_slice($data, 0, 20));
                        $count++;
                    }
                }
            } elseif ($importType === 'frequencies') {
                $stmt = $pdo->prepare("INSERT INTO frequencies (id, airport_ref, airport_ident, type, description, frequency_mhz) 
                    VALUES (?, ?, ?, ?, ?, ?) 
                    ON DUPLICATE KEY UPDATE description=VALUES(description)");
                while (($data = fgetcsv($handle)) !== FALSE) {
                    if (count($data) >= 6) {
                        $stmt->execute(array_slice($data, 0, 6));
                        $count++;
                    }
                }
            }
            
            $pdo->commit();
            $message = "Successfully imported $count $importType.";
        } catch (Exception $e) {
            $pdo->rollBack();
            $message = "Error during import: " . $e->getMessage();
        }
        fclose($handle);
    } else {
        $message = "Dataset file not found: $filePath";
    }
}

// Get available countries
$countries = [];
if (is_dir('../angani-data/datasets/Countries')) {
    $countries = array_diff(scandir('../angani-data/datasets/Countries'), array('..', '.'));
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnganiData | Bulk Import</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .import-box { max-width: 600px; margin: 2rem auto; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 500; }
        .form-group select, .form-group input { width: 100%; padding: 0.8rem; border: 1px solid var(--border); border-radius: var(--radius); background: var(--card-bg); color: var(--text); }
        .alert { padding: 1rem; border-radius: var(--radius); margin-bottom: 1.5rem; }
        .alert-success { background: rgba(16, 185, 129, 0.1); color: #10b981; border: 1px solid #10b981; }
        .alert-error { background: rgba(239, 68, 68, 0.1); color: #ef4444; border: 1px solid #ef4444; }
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
            <div class="card import-box">
                <h2>Bulk Data Import</h2>
                
                <?php if ($message): ?>
                    <div class="alert <?= strpos($message, 'Error') === false ? 'alert-success' : 'alert-error' ?>">
                        <?= htmlspecialchars($message) ?>
                    </div>
                <?php endif; ?>

                <form method="POST">
                    <div class="form-group">
                        <label>Dataset Type</label>
                        <select name="type" id="type-select" required onchange="toggleCountry()">
                            <option value="">Select Type...</option>
                            <option value="airports">Airports</option>
                            <option value="airlines">Airlines</option>
                            <option value="aircraft">Aircraft (Global)</option>
                            <option value="navaids">Navaids (Global)</option>
                            <option value="frequencies">Frequencies (Global)</option>
                        </select>
                    </div>

                    <div class="form-group" id="country-group" style="display: none;">
                        <label>Select Country</label>
                        <select name="country">
                            <?php foreach ($countries as $c): ?>
                                <option value="<?= htmlspecialchars($c) ?>"><?= htmlspecialchars($c) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <button type="submit" class="btn">Start Import</button>
                </form>
            </div>
        </main>
    </div>

    <script>
        function toggleCountry() {
            const type = document.getElementById('type-select').value;
            const countryGroup = document.getElementById('country-group');
            if (type === 'airports' || type === 'airlines') {
                countryGroup.style.display = 'block';
            } else {
                countryGroup.style.display = 'none';
            }
        }
    </script>
</body>
</html>
