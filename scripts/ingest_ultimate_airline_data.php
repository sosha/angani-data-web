<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$csvFile = __DIR__ . '/../data/data/ultimate_airline_data.csv';
if (!file_exists($csvFile)) {
    fwrite(STDERR, "ERROR: CSV file not found at $csvFile\n"); exit(1);
}

// Detect columns in airlines table
$tableCols = [];
$st = $db->query("SHOW COLUMNS FROM airlines");
while ($r = $st->fetch(PDO::FETCH_ASSOC)) {
    $tableCols[$r['Field']] = $r['Type'];
}
$hasStatusBucket = isset($tableCols['status_bucket']);
$hasLastModified = isset($tableCols['last_modified']);
$hasLegalName = isset($tableCols['legal_name']);
$hasTradingName = isset($tableCols['trading_name']);
$hasDateAdded = isset($tableCols['date_added']);
$hasDataSource = isset($tableCols['data_source']);
$hasRecordStatus = isset($tableCols['record_status']);
$hasOwnershipType = isset($tableCols['ownership_type']);
$hasActive = isset($tableCols['active']);
$hasCreatedAt = isset($tableCols['created_at']);
$hasUpdatedAt = isset($tableCols['updated_at']);
$hasCountry = isset($tableCols['country']);
$hasIata = isset($tableCols['iata_code']);
$hasCallsign = isset($tableCols['callsign']);
$hasFleetSize = isset($tableCols['fleet_size']);
$hasDestCount = isset($tableCols['destinations_count']);
$hasFounded = isset($tableCols['founded']);
$hasAlliance = isset($tableCols['alliance']);
$hasParentCo = isset($tableCols['parent_company']);
$hasDateModified = isset($tableCols['date_modified']);
$hasHubs = isset($tableCols['hubs']);
$hasWikiUrl = isset($tableCols['wikipedia_url']);
$hasWebsiteUrl = isset($tableCols['website_url']);
$hasCeo = isset($tableCols['ceo_accountable_manager']);
$hasCountryCode = isset($tableCols['country_code']);
$hasRegion = isset($tableCols['region']);
$hasPrefix = isset($tableCols['prefix']);
$hasLogoUrl = isset($tableCols['logo_url']);

echo "Table columns detected:\n";
echo "  status_bucket=" . ($hasStatusBucket?'Y':'N')
    . " last_modified=" . ($hasLastModified?'Y':'N')
    . " active=" . ($hasActive?'Y':'N')
    . " created_at=" . ($hasCreatedAt?'Y':'N')
    . " updated_at=" . ($hasUpdatedAt?'Y':'N')
    . " date_added=" . ($hasDateAdded?'Y':'N')
    . " data_source=" . ($hasDataSource?'Y':'N')
    . "\n\n";

// Parse CSV
$rows = [];
$handle = fopen($csvFile, 'r');
$rawHeader = fgetcsv($handle);

while (($data = fgetcsv($handle)) !== false) {
    if (count($data) < 27) continue;
    $rows[] = [
        'name' => trim($data[0] ?? ''),
        'iata' => trim($data[1] ?? ''),
        'icao' => trim($data[2] ?? ''),
        'hq' => trim($data[3] ?? ''),
        'bases' => trim($data[4] ?? ''),
        'destinations' => trim($data[5] ?? ''),
        'callsign' => trim($data[6] ?? ''),
        'countryCode' => trim($data[7] ?? ''),
        'website' => trim(str_replace(' ', '', $data[8] ?? '')),
        'keyPersonnel' => trim($data[9] ?? ''),
        'employees' => trim($data[10] ?? ''),
        'revenue' => trim($data[11] ?? ''),
        'profit' => trim($data[12] ?? ''),
        'fleetSize' => trim($data[13] ?? ''),
        'fleetType' => trim($data[14] ?? ''),
        'destNames' => trim($data[15] ?? ''),
        'alliance' => trim($data[16] ?? ''),
        'ffp' => trim($data[17] ?? ''),
        'codeshare' => trim($data[18] ?? ''),
        'interline' => trim($data[19] ?? ''),
        'founded' => trim($data[20] ?? ''),
        'operatingBases' => trim($data[21] ?? ''),
        'parentCo' => trim($data[22] ?? ''),
        'focusCities' => trim($data[23] ?? ''),
        'subsidiaries' => trim($data[24] ?? ''),
        'careersLink' => trim($data[25] ?? ''),
        'wikiUrl' => trim($data[26] ?? ''),
    ];
}
fclose($handle);

echo "Total CSV rows: " . count($rows) . "\n";

function cleanName(string $name): string {
    $name = preg_replace('/\s*\(formerly[^)]*\)/i', '', $name);
    $name = preg_replace('/\s*S\.?r?\.?l\.?\s*/i', '', $name);
    $name = preg_replace('/\s*S\.?p\.?A\.?\s*/i', '', $name);
    $name = preg_replace('/\s*LIMITED\s*/i', '', $name);
    $name = preg_replace('/\s*LTD\s*/i', '', $name);
    $name = preg_replace('/\s*PLC\s*/i', '', $name);
    $name = preg_replace('/\s*SA\s*/i', '', $name);
    $name = preg_replace('/\s*AE\s*/i', '', $name);
    $name = preg_replace('/\s*JSC\s*/i', '', $name);
    $name = preg_replace('/\s*Ltd\s*/i', '', $name);
    $name = preg_replace('/\s*\(UK\)\s*/i', '', $name);
    $name = preg_replace('/\s*\(NI\)\s*/i', '', $name);
    $name = preg_replace('/[",.]/', '', $name);
    $name = preg_replace('/\s*Corporation\s*/i', '', $name);
    $name = preg_replace('/\s+/', ' ', $name);
    return trim(strtolower($name));
}

$stopwords = ['air','airways','aviation','airlines','services','helicopter','flight','fly','aero','limited','ltd','plc','uk','gb','company','corporation','jsc','sa','ae'];

function stripStopwords(string $name): string {
    global $stopwords;
    $words = preg_split('/\s+/', $name);
    $filtered = array_filter($words, fn($w) => !in_array($w, $stopwords));
    return trim(implode(' ', $filtered));
}

function namesMatch(string $csvName, string $dbName): bool {
    $a = cleanName($csvName);
    $b = cleanName($dbName);
    if (!$a || !$b) return false;
    if ($a === $b) return true;
    $sa = stripStopwords($a);
    $sb = stripStopwords($b);
    if (!$sa || !$sb) return false;
    return $sa === $sb;
}

function upsertDigitalProperty(PDO $db, string $icao, string $airlineName, string $category, string $platform, string $value, string $countryCode = ''): void {
    if (!trim($value)) return;
    $exists = $db->prepare("SELECT id FROM airline_digital_properties WHERE icao_code=? AND category=? AND platform=? AND url_or_handle=?");
    $exists->execute([$icao, $category, $platform, $value]);
    if ($exists->fetch()) return;
    $cc = $countryCode ?: 'XX';
    $db->prepare("INSERT INTO airline_digital_properties (country_code, icao_code, airline_name, category, platform, url_or_handle, is_primary)
        VALUES (?, ?, ?, ?, ?, ?, 1)")->execute([$cc, $icao, $airlineName, $category, $platform, $value]);
}

// Pre-fetch all existing airlines for matching
$existingAirlines = [];
$st = $db->query("SELECT icao_code, name, country_code FROM airlines WHERE icao_code IS NOT NULL AND icao_code != ''");
foreach ($st as $r) {
    $existingAirlines[$r['icao_code']] = $r;
}

$matched = 0;
$updated = 0;
$inserted = 0;
$digitalInserted = 0;
$skippedNoIcao = 0;

$now = date('Y-m-d H:i:s');

echo "\nProcessing...\n\n";

foreach ($rows as $r) {
    $icao = $r['icao'];
    $name = $r['name'];
    if (!$icao) {
        $skippedNoIcao++;
        continue;
    }

    $cc = $r['countryCode'] ?: 'XX';
    $existing = $existingAirlines[$icao] ?? null;

    if ($existing) {
        $dbCc = $existing['country_code'] ?: $cc;
        $updates = [];
        $params = [];

        if ($name && $name !== $existing['name']) {
            $updates[] = "name=?";
            $params[] = $name;
        }
        if ($hasIata && $r['iata']) {
            $updates[] = "iata_code=?";
            $params[] = $r['iata'];
        }
        if ($hasCallsign && $r['callsign']) {
            $updates[] = "callsign=?";
            $params[] = $r['callsign'];
        }
        if ($hasFleetSize && $r['fleetSize'] !== '') {
            $updates[] = "fleet_size=?";
            $params[] = (int)$r['fleetSize'];
        }
        if ($hasDestCount && $r['destinations'] !== '') {
            $updates[] = "destinations_count=?";
            $params[] = (int)$r['destinations'];
        }
        if ($hasFounded && $r['founded']) {
            $updates[] = "founded=?";
            $params[] = substr($r['founded'], 0, 80);
        }
        if ($hasAlliance && $r['alliance']) {
            $updates[] = "alliance=?";
            $params[] = substr($r['alliance'], 0, 120);
        }
        if ($hasParentCo && $r['parentCo']) {
            $updates[] = "parent_company=?";
            $params[] = substr($r['parentCo'], 0, 190);
        }
        if ($hasHubs && $r['hq']) {
            $updates[] = "hubs=?";
            $params[] = substr($r['hq'], 0, 120);
        }
        if ($hasWikiUrl && $r['wikiUrl']) {
            $updates[] = "wikipedia_url=?";
            $params[] = $r['wikiUrl'];
        }
        if ($hasWebsiteUrl && $r['website']) {
            $updates[] = "website_url=?";
            $params[] = $r['website'];
        }
        if ($hasCeo && $r['keyPersonnel']) {
            $updates[] = "ceo_accountable_manager=?";
            $params[] = substr($r['keyPersonnel'], 0, 255);
        }
        if ($hasCountryCode && $cc && $cc !== $dbCc) {
            $updates[] = "country_code=?";
            $params[] = $cc;
        }

        if ($updates) {
            if ($hasLastModified) {
                $updates[] = "last_modified=NOW()";
            } elseif ($hasUpdatedAt) {
                $updates[] = "updated_at=NOW()";
            }
            if ($hasDateModified) {
                $updates[] = "date_modified=?";
                $params[] = $now;
            }
            $params[] = $icao;
            $sql = "UPDATE airlines SET " . implode(',', $updates) . " WHERE icao_code=?";
            $db->prepare($sql)->execute($params);
            $updated++;
        }
        $matched++;
    } else {
        // New airline
        $cols = ["icao_code", "name"];
        $vals = [$icao, $name];
        $ph = ["?", "?"];

        if ($hasIata && $r['iata']) { $cols[] = "iata_code"; $vals[] = $r['iata']; $ph[] = "?"; }
        if ($hasCallsign && $r['callsign']) { $cols[] = "callsign"; $vals[] = $r['callsign']; $ph[] = "?"; }
        if ($hasFleetSize && $r['fleetSize'] !== '') { $cols[] = "fleet_size"; $vals[] = (int)$r['fleetSize']; $ph[] = "?"; }
        if ($hasDestCount && $r['destinations'] !== '') { $cols[] = "destinations_count"; $vals[] = (int)$r['destinations']; $ph[] = "?"; }
        if ($hasFounded && $r['founded']) { $cols[] = "founded"; $vals[] = substr($r['founded'], 0, 80); $ph[] = "?"; }
        if ($hasAlliance && $r['alliance']) { $cols[] = "alliance"; $vals[] = substr($r['alliance'], 0, 120); $ph[] = "?"; }
        if ($hasParentCo && $r['parentCo']) { $cols[] = "parent_company"; $vals[] = substr($r['parentCo'], 0, 190); $ph[] = "?"; }
        if ($hasHubs && $r['hq']) { $cols[] = "hubs"; $vals[] = substr($r['hq'], 0, 120); $ph[] = "?"; }
        if ($hasWikiUrl && $r['wikiUrl']) { $cols[] = "wikipedia_url"; $vals[] = $r['wikiUrl']; $ph[] = "?"; }
        if ($hasWebsiteUrl && $r['website']) { $cols[] = "website_url"; $vals[] = $r['website']; $ph[] = "?"; }
        if ($hasCeo && $r['keyPersonnel']) { $cols[] = "ceo_accountable_manager"; $vals[] = substr($r['keyPersonnel'], 0, 255); $ph[] = "?"; }
        if ($hasCountryCode && $cc) { $cols[] = "country_code"; $vals[] = $cc; $ph[] = "?"; }
        if ($hasLogoUrl) { $cols[] = "logo_url"; $vals[] = null; $ph[] = "?"; }
        if ($hasPrefix) { $cols[] = "prefix"; $vals[] = null; $ph[] = "?"; }
        if ($hasRegion) { $cols[] = "region"; $vals[] = null; $ph[] = "?"; }
        if ($hasDataSource) { $cols[] = "data_source"; $vals[] = "ultimate_airline_data.csv"; $ph[] = "?"; }
        if ($hasRecordStatus) { $cols[] = "record_status"; $vals[] = "active"; $ph[] = "?"; }

        if ($hasStatusBucket) {
            $bucket = ($r['fleetSize'] !== '' && (int)$r['fleetSize'] > 0) ? 'active' : 'unknown';
            $cols[] = "status_bucket"; $vals[] = $bucket; $ph[] = "?";
        } elseif ($hasActive) {
            $isActive = ($r['fleetSize'] !== '' && (int)$r['fleetSize'] > 0);
            $cols[] = "active"; $vals[] = $isActive ? 'Y' : 'N'; $ph[] = "?";
        }

        if ($hasDateAdded) { $cols[] = "date_added"; $vals[] = $now; $ph[] = "?"; }
        if ($hasCreatedAt) { $cols[] = "created_at"; $vals[] = $now; $ph[] = "?"; }

        $sql = "INSERT INTO airlines (" . implode(',', $cols) . ") VALUES (" . implode(',', $ph) . ")";
        $db->prepare($sql)->execute($vals);
        $inserted++;
        $matched++;
    }

    // Digital properties
    $airlineName = $name;
    $dpCc = $cc ?: ($existing['country_code'] ?? 'XX');

    $dpFields = [
        ['Contact', 'Website', $r['website']],
        ['Contact', 'Headquarters', $r['hq']],
        ['Contact', 'Bases', $r['bases']],
        ['Operations', 'Destinations', $r['destNames']],
        ['Operations', 'Fleet Type', $r['fleetType']],
        ['Management', 'Key Personnel', $r['keyPersonnel']],
        ['Financial', 'Employees', $r['employees']],
        ['Financial', 'Revenue', $r['revenue']],
        ['Financial', 'Profit', $r['profit']],
        ['Programs', 'Frequent Flyer Program', $r['ffp']],
        ['Partnerships', 'Codeshare', $r['codeshare']],
        ['Partnerships', 'Interline', $r['interline']],
        ['Contact', 'Operating Bases', $r['operatingBases']],
        ['Operations', 'Focus Cities', $r['focusCities']],
        ['Corporate', 'Subsidiaries', $r['subsidiaries']],
        ['Contact', 'Careers', $r['careersLink']],
        ['Reference', 'Wikipedia', $r['wikiUrl']],
        ['Partnerships', 'Alliance', $r['alliance']],
    ];

    foreach ($dpFields as [$cat, $plat, $val]) {
        if ($val) {
            upsertDigitalProperty($db, $icao, $airlineName, $cat, $plat, $val, $dpCc);
            $digitalInserted++;
        }
    }
}

echo "\n--- Summary ---\n";
echo "Total CSV rows: " . count($rows) . "\n";
echo "Skipped (no ICAO): $skippedNoIcao\n";
echo "Matched/processed: $matched\n";
echo "Existing airlines updated: $updated\n";
echo "New airlines inserted: $inserted\n";
echo "Digital properties inserted: $digitalInserted\n";
if ($matched > 0) {
    echo "\nProcessed " . ($inserted + $matched) . " airlines from CSV.\n";
}
echo "\nDone.\n";
