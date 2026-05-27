<?php
/**
 * Import airlines from airlines.csv (May 2027 operating airlines)
 * 
 * Updates the following fields from CSV:
 * - name, iata_code, icao_code, prefix
 * - fleet_size, destinations_count
 * - callsign, logo_url, wikipedia_url
 * - status, status_bucket
 * 
 * Status rules:
 * - Airlines in CSV with fleet_size > 0 = active
 * - Airlines in CSV with fleet_size = 0 = inactive/defunct
 * - Airlines in DB but not in CSV = defunct
 */

require_once __DIR__ . '/../includes/db.php';

$csvFile = '/workspace/airlines.csv';

if (!file_exists($csvFile)) {
    die("Error: CSV file not found at $csvFile\n");
}

echo "=== Airlines Import Script (May 2027) ===\n\n";

// Read CSV
$handle = fopen($csvFile, 'r');
if (!$handle) {
    die("Error: Could not open CSV file\n");
}

$headers = fgetcsv($handle);
echo "CSV Headers: " . implode(', ', $headers) . "\n\n";

$airlinesInCsv = [];
$lineNum = 1;

while (($data = fgetcsv($handle)) !== false) {
    $lineNum++;
    $row = array_combine($headers, $data);
    
    $icao = trim($row['ICAO Code'] ?? '');
    $iata = trim($row['IATA Code'] ?? '');
    $name = trim($row['Name'] ?? '');
    $fleetSize = (int)($row['Fleet Size'] ?? 0);
    $destinations = (int)($row['Destinations'] ?? 0);
    $callsign = trim($row['Callsign'] ?? '');
    $logoUrl = trim($row['Logo URL'] ?? '');
    $wikiUrl = trim($row['Wikipedia URL'] ?? '');
    $prefix = trim($row['Prefix'] ?? '');
    
    if (empty($icao) && empty($iata)) {
        continue; // Skip rows without any code
    }
    
    $status = $fleetSize > 0 ? 'active' : 'inactive/defunct';
    $statusBucket = $fleetSize > 0 ? 'active' : 'defunct';
    
    $airlinesInCsv[$icao ?: $iata] = [
        'icao_code' => $icao,
        'iata_code' => $iata,
        'name' => $name,
        'fleet_size' => $fleetSize,
        'destinations_count' => $destinations,
        'callsign' => $callsign,
        'logo_url' => $logoUrl,
        'wikipedia_url' => $wikiUrl,
        'prefix' => $prefix,
        'status' => $status,
        'status_bucket' => $statusBucket,
    ];
}

fclose($handle);

echo "Read " . count($airlinesInCsv) . " airlines from CSV\n\n";

// Get current airlines from database
$currentAirlines = rows("SELECT id, name, iata_code, icao_code, status_bucket FROM airlines");
echo "Found " . count($currentAirlines) . " airlines in database\n\n";

// Build lookup by icao and iata
$byIcao = [];
$byIata = [];
foreach ($currentAirlines as $a) {
    if (!empty($a['icao_code'])) $byIcao[$a['icao_code']] = $a;
    if (!empty($a['iata_code'])) $byIata[$a['iata_code']] = $a;
}

// Process updates
$updated = 0;
$markedDefunct = 0;
$newAirlineKeys = array_keys($airlinesInCsv);

foreach ($currentAirlines as $dbAirline) {
    $key = $dbAirline['icao_code'] ?: $dbAirline['iata_code'];
    
    if (isset($airlinesInCsv[$key])) {
        // Update this airline with CSV data
        $csvData = $airlinesInCsv[$key];
        
        $sql = "UPDATE airlines SET 
            name = ?,
            iata_code = ?,
            prefix = ?,
            fleet_size = ?,
            destinations_count = ?,
            callsign = ?,
            logo_url = ?,
            wikipedia_url = ?,
            status = ?,
            status_bucket = ?,
            last_modified = NOW()
            WHERE id = ?";
        
        $params = [
            $csvData['name'],
            $csvData['iata_code'],
            $csvData['prefix'],
            $csvData['fleet_size'],
            $csvData['destinations_count'],
            $csvData['callsign'],
            $csvData['logo_url'],
            $csvData['wikipedia_url'],
            $csvData['status'],
            $csvData['status_bucket'],
            $dbAirline['id']
        ];
        
        exec_sql($sql, $params);
        $updated++;
    } else {
        // Airline in DB but not in CSV - mark as defunct
        exec_sql(
            "UPDATE airlines SET status = 'defunct', status_bucket = 'defunct', last_modified = NOW() WHERE id = ?",
            [$dbAirline['id']]
        );
        $markedDefunct++;
    }
}

echo "=== Summary ===\n";
echo "Updated: $updated airlines\n";
echo "Marked defunct: $markedDefunct airlines\n";
echo "\nImport complete!\n";
