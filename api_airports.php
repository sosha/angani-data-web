<?php
/**
 * Airport API — serves airport data for the route visualizer.
 * Reads CSV files from all country folders and returns JSON.
 */
header('Content-Type: application/json; charset=utf-8');

define('DATA_ROOT', realpath(__DIR__ . '/../angani-data/datasets'));

if (!DATA_ROOT) {
    echo json_encode(['error' => 'Dataset root not found']);
    exit;
}

$action = $_GET['action'] ?? '';

switch ($action) {
    case 'search':  searchAirports(); break;
    case 'details': airportDetails(); break;
    default:        echo json_encode(['error' => 'Use action=search&q=... or action=details&ident=...']);
}

// ═══════════════════════════════════════════════════════════════════════════════
// Search airports across all country CSVs
// ═══════════════════════════════════════════════════════════════════════════════
function searchAirports() {
    $query = strtolower(trim($_GET['q'] ?? ''));
    if (strlen($query) < 2) {
        echo json_encode(['results' => []]);
        return;
    }

    $results = [];
    $limit = 30;
    $countriesDir = DATA_ROOT . '/Countries';

    if (!is_dir($countriesDir)) {
        echo json_encode(['error' => 'Countries directory not found']);
        return;
    }

    $countries = array_diff(scandir($countriesDir), ['.', '..']);

    foreach ($countries as $countryCode) {
        $csvPath = $countriesDir . '/' . $countryCode . '/airports/airports.csv';
        if (!file_exists($csvPath)) continue;

        $handle = fopen($csvPath, 'r');
        if (!$handle) continue;

        $headers = fgetcsv($handle);
        if (!$headers) { fclose($handle); continue; }

        // Clean headers
        $headers = array_map(function($h) {
            return strtolower(trim(preg_replace('/^\x{FEFF}/u', '', $h)));
        }, $headers);

        $headerMap = array_flip($headers);

        while (($row = fgetcsv($handle)) !== false) {
            if (count($results) >= $limit) break 2;

            $row = array_pad($row, count($headers), '');

            $name     = $row[$headerMap['name'] ?? 3] ?? '';
            $ident    = $row[$headerMap['ident'] ?? 1] ?? '';
            $iata     = $row[$headerMap['iata_code'] ?? 13] ?? '';
            $icao     = $row[$headerMap['gps_code'] ?? 12] ?? '';
            $muni     = $row[$headerMap['municipality'] ?? 10] ?? '';
            $country  = $row[$headerMap['iso_country'] ?? 8] ?? '';
            $type     = $row[$headerMap['type'] ?? 2] ?? '';
            $lat      = (float)($row[$headerMap['latitude_deg'] ?? 4] ?? 0);
            $lon      = (float)($row[$headerMap['longitude_deg'] ?? 5] ?? 0);
            $elev     = $row[$headerMap['elevation_ft'] ?? 6] ?? '';
            $sched    = $row[$headerMap['scheduled_service'] ?? 11] ?? '';
            $wiki     = $row[$headerMap['wikipedia_link'] ?? 16] ?? '';

            // Search in name, IATA, ICAO, ident, municipality
            $searchable = strtolower("$name $iata $icao $ident $muni $country");
            if (strpos($searchable, $query) !== false) {
                $results[] = [
                    'ident'      => $ident,
                    'name'       => $name,
                    'iata_code'  => $iata,
                    'icao_code'  => $icao,
                    'latitude'   => $lat,
                    'longitude'  => $lon,
                    'elevation'  => $elev,
                    'type'       => $type,
                    'municipality' => $muni,
                    'country'    => $country,
                    'scheduled_service' => $sched,
                    'wikipedia'  => $wiki,
                ];
            }
        }
        fclose($handle);
    }

    // Sort: prioritize IATA matches, then medium/large airports
    usort($results, function($a, $b) use ($query) {
        // Exact IATA match first
        if (strtolower($a['iata_code']) === $query && strtolower($b['iata_code']) !== $query) return -1;
        if (strtolower($b['iata_code']) === $query && strtolower($a['iata_code']) !== $query) return 1;
        // Prioritize scheduled service
        if ($a['scheduled_service'] === 'yes' && $b['scheduled_service'] !== 'yes') return -1;
        if ($b['scheduled_service'] === 'yes' && $a['scheduled_service'] !== 'yes') return 1;
        // Then by type (large > medium > small)
        $typeOrder = ['large_airport' => 0, 'medium_airport' => 1, 'small_airport' => 2];
        $aOrder = $typeOrder[$a['type']] ?? 3;
        $bOrder = $typeOrder[$b['type']] ?? 3;
        return $aOrder - $bOrder;
    });

    echo json_encode(['results' => $results]);
}

// ═══════════════════════════════════════════════════════════════════════════════
// Get full details of a single airport by ident
// ═══════════════════════════════════════════════════════════════════════════════
function airportDetails() {
    $ident = trim($_GET['ident'] ?? '');
    if (!$ident) {
        echo json_encode(['error' => 'ident parameter required']);
        return;
    }

    $countriesDir = DATA_ROOT . '/Countries';
    $countries = array_diff(scandir($countriesDir), ['.', '..']);

    foreach ($countries as $countryCode) {
        $csvPath = $countriesDir . '/' . $countryCode . '/airports/airports.csv';
        if (!file_exists($csvPath)) continue;

        $handle = fopen($csvPath, 'r');
        if (!$handle) continue;

        $headers = fgetcsv($handle);
        if (!$headers) { fclose($handle); continue; }

        $headers = array_map(function($h) {
            return strtolower(trim(preg_replace('/^\x{FEFF}/u', '', $h)));
        }, $headers);

        while (($row = fgetcsv($handle)) !== false) {
            $row = array_pad($row, count($headers), '');
            $record = array_combine($headers, $row);

            if (strcasecmp($record['ident'] ?? '', $ident) === 0 ||
                strcasecmp($record['iata_code'] ?? '', $ident) === 0 ||
                strcasecmp($record['gps_code'] ?? '', $ident) === 0) {
                fclose($handle);
                echo json_encode(['airport' => $record]);
                return;
            }
        }
        fclose($handle);
    }

    echo json_encode(['error' => 'Airport not found: ' . $ident]);
}
