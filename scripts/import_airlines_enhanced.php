<?php
/**
 * Import enhanced airlines data from Airlines_List_Enhanced_gpt.csv
 * 
 * Updates the following fields from CSV:
 * - name, iata_code, icao_code, prefix
 * - fleet_size, destinations_count
 * - callsign, logo_url, wikipedia_url
 * - website_url (from Website field)
 * - ceo_accountable_manager (from Key people field)
 * - founded
 * - hubs
 * - alliance
 * - status, status_bucket
 * 
 * Status rules:
 * - Airlines in CSV with fleet_size > 0 = active
 * - Airlines in CSV with fleet_size = 0 = inactive/defunct
 * - Airlines in DB but not in CSV = defunct
 * 
 * Note: CSV should be sanitized (ASCII-only) for compatibility.
 */

require_once __DIR__ . '/../includes/db.php';

$csvFile = __DIR__ . '/../data/Airlines_List_Enhanced_gpt.csv';

if (!file_exists($csvFile)) {
    die("Error: CSV file not found at $csvFile\n");
}

echo "=== Enhanced Airlines Import Script ===\n\n";

// Read CSV
$handle = fopen($csvFile, 'r');
if (!$handle) {
    die("Error: Could not open CSV file\n");
}

$headers = fgetcsv($handle);
echo "CSV Headers: " . implode(', ', $headers) . "\n\n";

$airlinesInCsv = [];

// Convert CSV to UTF-8 if needed and parse
while (($data = fgetcsv($handle)) !== false) {
    $row = [];
    foreach ($data as $idx => $val) {
        // Force UTF-8 encoding
        if (function_exists('mb_convert_encoding')) {
            $val = mb_convert_encoding($val ?? '', 'UTF-8', 'UTF-8');
        } else {
            // Fallback: assume UTF-8
            $val = $val ?? '';
        }
        $row[$headers[$idx]] = $val;
    }
    
    $icao = trim($row['ICAO Code'] ?? '');
    $iata = trim($row['IATA Code'] ?? '');
    $name = trim($row['Name'] ?? '');
    $fleetSize = (int)($row['Fleet Size'] ?? 0);
    $destinations = (int)($row['Destinations'] ?? 0);
    $callsign = trim($row['Callsign'] ?? '');
    $logoUrl = trim($row['Logo URL'] ?? '');
    $wikiUrl = trim($row['Wikipedia URL'] ?? '');
    $prefix = trim($row['Prefix'] ?? '');
    $website = trim($row['Website'] ?? '');
    $keyPeople = trim($row['Key people'] ?? '');
    $headquarters = trim($row['Headquarters'] ?? '');
    $alliance = trim($row['Alliance'] ?? '');
    $founded = trim($row['Founded'] ?? '');
    $hubs = trim($row['Hubs'] ?? '');
    
    // Clean up website URL
    $website = str_replace(' .com', '.com', str_replace(' .', '.', str_replace('com ', 'com', $website)));
    $website = $website ? 'https://' . ltrim($website, '/') : '';
    
    // Truncate long text fields to fit database columns
    $keyPeople = substr($keyPeople, 0, 255);
    $founded = substr($founded, 0, 80);
    $hubs = substr($hubs, 0, 120);
    
    // Replace problematic Unicode characters (em-dash, en-dash) with hyphen
    $name = preg_replace('/[\xE2\x80\x93\xE2\x80\x94]/', '-', $name);
    $callsign = preg_replace('/[\xE2\x80\x93\xE2\x80\x94]/', '-', $callsign);
    $keyPeople = preg_replace('/[\xE2\x80\x93\xE2\x80\x94]/', '-', $keyPeople);
    $founded = preg_replace('/[\xE2\x80\x93\xE2\x80\x94]/', '-', $founded);
    $hubs = preg_replace('/[\xE2\x80\x93\xE2\x80\x94]/', '-', $hubs);
    $headquarters = preg_replace('/[\xE2\x80\x93\xE2\x80\x94]/', '-', $headquarters);
    
    if (empty($icao) && empty($iata)) {
        continue;
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
        'website_url' => $website,
        'ceo_accountable_manager' => $keyPeople,
        'founded' => $founded,
        'hubs' => $hubs,
        'alliance' => $alliance,
        'status' => $status,
        'status_bucket' => $statusBucket,
    ];
}

fclose($handle);

echo "Read " . count($airlinesInCsv) . " airlines from CSV\n\n";

// Get current airlines from database
$currentAirlines = rows("SELECT id, name, iata_code, icao_code, status_bucket FROM airlines");
echo "Found " . count($currentAirlines) . " airlines in database\n\n";

// Process updates using prepared statements
$mysqli = db();
$updated = 0;
$markedDefunct = 0;

$stmt = $mysqli->prepare("UPDATE airlines SET 
    name = ?,
    iata_code = ?,
    prefix = ?,
    fleet_size = ?,
    destinations_count = ?,
    callsign = ?,
    logo_url = ?,
    wikipedia_url = ?,
    website_url = ?,
    ceo_accountable_manager = ?,
    founded = ?,
    hubs = ?,
    alliance = ?,
    status = ?,
    status_bucket = ?,
    last_modified = NOW()
    WHERE id = ?");

$stmtDefunct = $mysqli->prepare("UPDATE airlines SET status = 'defunct', status_bucket = 'defunct', last_modified = NOW() WHERE id = ?");

foreach ($currentAirlines as $dbAirline) {
    $key = $dbAirline['icao_code'] ?: $dbAirline['iata_code'];
    
    if (isset($airlinesInCsv[$key])) {
        $csvData = $airlinesInCsv[$key];
        
        $stmt->bind_param(
            'sssisisssssssssi',
            $csvData['name'],
            $csvData['iata_code'],
            $csvData['prefix'],
            $csvData['fleet_size'],
            $csvData['destinations_count'],
            $csvData['callsign'],
            $csvData['logo_url'],
            $csvData['wikipedia_url'],
            $csvData['website_url'],
            $csvData['ceo_accountable_manager'],
            $csvData['founded'],
            $csvData['hubs'],
            $csvData['alliance'],
            $csvData['status'],
            $csvData['status_bucket'],
            $dbAirline['id']
        );
        
        $stmt->execute();
        $updated++;
    } else {
        $stmtDefunct->bind_param('i', $dbAirline['id']);
        $stmtDefunct->execute();
        $markedDefunct++;
    }
}

$stmt->close();
$stmtDefunct->close();
$mysqli->close();

echo "=== Summary ===\n";
echo "Updated: $updated airlines\n";
echo "Marked defunct: $markedDefunct airlines\n";
echo "\nImport complete!\n";
