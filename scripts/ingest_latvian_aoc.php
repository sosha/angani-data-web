<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$rows = [
    [
        'icao' => 'BTI',
        'name' => '"Air Baltic Corporation" JSC',
        'address' => '3 Tehnikas street, Lidosta "Riga", Marupe district, LV-1053, Latvia',
        'phone' => '+371 6700 6006',
        'email' => 'info@airbaltic.com',
        'website' => 'https://www.airbaltic.com',
        'services' => 'Commercial air transport (CAT) – passengers and cargo',
        'aircraft' => ['Airbus A220-300'],
        'remarks' => 'Approved to deliver initial cabin crew training and issue cabin crew attestations',
    ],
    [
        'icao' => 'MTL',
        'name' => '"Raf-Avia" JSC',
        'address' => '26A Vienibas gate, Riga, LV-1004, Latvia',
        'phone' => '+371 67 324 661',
        'email' => 'rafavia@rafavia.aero',
        'website' => 'https://rafavia.aero',
        'services' => 'Commercial air transport (CAT) – passengers and cargo',
        'aircraft' => ['SAAB 340 A'],
        'remarks' => '',
    ],
    [
        'icao' => '',
        'name' => '"GM Helicopters" Ltd',
        'address' => 'M-SOLA, Jumprava parish, Ogre Local Municipality, LV-5022, Latvia',
        'phone' => '+371-65068350',
        'email' => 'info@gmhelicopters.com',
        'website' => 'https://www.gmhelicopters.com',
        'services' => 'Commercial air transport (CAT)',
        'aircraft' => ['Cabri G2', 'H125/AS 350 B3E'],
        'remarks' => '',
    ],
    [
        'icao' => 'UAV',
        'name' => '"Union Aviation" JSC',
        'address' => '',
        'phone' => '',
        'email' => '',
        'website' => '',
        'services' => '',
        'aircraft' => [],
        'remarks' => 'Only operator name mentioned in source; no further details published.',
    ],
];

function cleanName(string $name): string {
    $name = preg_replace('/\s*\(formerly[^)]*\)/i', '', $name);
    $name = preg_replace('/\s*S\.?r?\.?l\.?/i', '', $name);
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
    return trim(strtolower($name));
}

$stopwords = ['air','airways','aviation','airlines','services','helicopter','flight','fly','aero','limited','ltd','plc','uk','gb','company','corporation','jsc','sa','ae'];

function stripStopwords(string $name): string {
    global $stopwords;
    $words = preg_split('/\s+/', $name);
    $filtered = array_filter($words, fn($w) => !in_array($w, $stopwords));
    return trim(implode(' ', $filtered));
}

function namesMatch(string $caaName, string $dbName): bool {
    $a = cleanName($caaName);
    $b = cleanName($dbName);
    if ($a === $b) return true;
    $sa = stripStopwords($a);
    $sb = stripStopwords($b);
    if (!$sa || !$sb) return false;
    return $sa === $sb;
}

function upsertDigitalProperty(PDO $db, string $icao, string $name, string $category, string $platform, string $value): void {
    if (!$value) return;
    $exists = $db->prepare("SELECT id FROM airline_digital_properties WHERE icao_code=? AND category=? AND platform=? AND url_or_handle=?");
    $exists->execute([$icao, $category, $platform, $value]);
    if ($exists->fetch()) return;
    $db->prepare("INSERT INTO airline_digital_properties (country_code, icao_code, airline_name, category, platform, url_or_handle, is_primary)
        VALUES ('LV', ?, ?, ?, ?, ?, 1)")->execute([$icao, $name, $category, $platform, $value]);
}

function upsertFleet(PDO $db, string $icao, string $aircraftType): void {
    if (!$aircraftType) return;
    $exists = $db->prepare("SELECT id FROM airline_fleet_summary WHERE icao_code=? AND aircraft_type=?");
    $exists->execute([$icao, $aircraftType]);
    if ($exists->fetch()) return;
    $db->prepare("INSERT INTO airline_fleet_summary (country_code, icao_code, aircraft_type, aircraft_count)
        VALUES ('LV', ?, ?, NULL)")->execute([$icao, $aircraftType]);
}

$matched = 0;
$updated = 0;
$inserted = 0;
$digitalInserted = 0;
$fleetInserted = 0;
$skipped = 0;

echo "Processing " . count($rows) . " Latvian AOC holders...\n\n";

foreach ($rows as $r) {
    $companyName = $r['name'];
    $addr = $r['address'] ?: '';
    $phone = $r['phone'] ?: '';
    $email = $r['email'] ?: '';
    $website = $r['website'] ?: '';
    $aircraft = $r['aircraft'] ?? [];

    $matchedAirline = null;
    $carrierIcao = null;
    $icaoCode = $r['icao'] ?: null;

    // Try matching by ICAO code if provided
    if ($icaoCode) {
        $stmt = $db->prepare("SELECT icao_code, name, active FROM airlines WHERE icao_code=? AND country_code='LV'");
        $stmt->execute([$icaoCode]);
        $existing = $stmt->fetch();
        if ($existing) {
            $matchedAirline = $existing;
            $carrierIcao = $existing['icao_code'];
        }
    }

    // Fall back to name matching
    if (!$matchedAirline) {
        $all = $db->prepare("SELECT icao_code, name, active FROM airlines WHERE country_code='LV'");
        $all->execute();
        foreach ($all as $a) {
            if (namesMatch($companyName, $a['name'])) {
                $matchedAirline = $a;
                $carrierIcao = $a['icao_code'] ?: null;
                break;
            }
        }
    }

    if ($matchedAirline) {
        if ($matchedAirline['active'] !== 'Y') {
            $db->prepare("UPDATE airlines SET active='Y', updated_at=NOW() WHERE icao_code=?")
                ->execute([$matchedAirline['icao_code']]);
            echo "  ✓ Updated {$matchedAirline['icao_code']}: active=Y\n";
            $updated++;
        } else {
            echo "  • {$matchedAirline['icao_code']}: already active\n";
        }
        $matched++;
    } else {
        // Determine ICAO: use provided code, or generate
        if ($icaoCode) {
            // Check if provided ICAO is taken by non-LV airline
            $taken = $db->prepare("SELECT name, country_code FROM airlines WHERE icao_code=?");
            $taken->execute([$icaoCode]);
            $takenRow = $taken->fetch();
            if ($takenRow) {
                echo "  ⚠ ICAO $icaoCode taken by '{$takenRow['name']}' ({$takenRow['country_code']}) — generating\n";
                $icaoCode = null;
            }
        }
        if (!$icaoCode) {
            $genNum = 1;
            while (true) {
                $genIcao = 'LV' . str_pad((string)$genNum, 3, '0', STR_PAD_LEFT);
                $taken = $db->prepare("SELECT 1 FROM airlines WHERE icao_code=?");
                $taken->execute([$genIcao]);
                if (!$taken->fetch()) break;
                $genNum++;
            }
            $icaoCode = $genIcao;
        }
        $carrierIcao = $icaoCode;
        $db->prepare("INSERT INTO airlines (icao_code, name, country, country_code, active, created_at, updated_at)
            VALUES (?, ?, 'Latvia', 'LV', 'Y', NOW(), NOW())")
            ->execute([$icaoCode, $companyName]);
        echo "  + Inserted new airline: '{$companyName}' (ICAO: $icaoCode)\n";
        $inserted++;
    }

    // Insert digital properties
    if ($carrierIcao) {
        if ($email) {
            upsertDigitalProperty($db, $carrierIcao, $companyName, 'Contact', 'Email', $email);
            $digitalInserted++;
        }
        if ($phone) {
            upsertDigitalProperty($db, $carrierIcao, $companyName, 'Contact', 'Phone', $phone);
            $digitalInserted++;
        }
        if ($addr) {
            upsertDigitalProperty($db, $carrierIcao, $companyName, 'Contact', 'Address', $addr);
            $digitalInserted++;
        }
        if ($website && $website !== '—' && strpos($website, 'Information') === false) {
            upsertDigitalProperty($db, $carrierIcao, $companyName, 'Contact', 'Website', $website);
            $digitalInserted++;
        }
        if ($r['services']) {
            upsertDigitalProperty($db, $carrierIcao, $companyName, 'Services', 'AOC Services', $r['services']);
            $digitalInserted++;
        }
        if ($r['remarks']) {
            upsertDigitalProperty($db, $carrierIcao, $companyName, 'Regulatory', 'Remarks', $r['remarks']);
            $digitalInserted++;
        }

        // Insert fleet
        foreach ($aircraft as $ac) {
            upsertFleet($db, $carrierIcao, $ac);
            $fleetInserted++;
        }
    } else {
        echo "  ⚠ No ICAO code available for digital properties\n";
        $skipped++;
    }
}

// Mark all other LV airlines as inactive
echo "\n--- Marking Latvian airlines NOT on AOC list as inactive ---\n";
// Collect all LV ICAO codes that were matched (from this run or already had active=Y)
$icaoList = [];
foreach ($rows as $r) {
    $icaoCode = $r['icao'] ?: null;
    if ($icaoCode) {
        $stmt = $db->prepare("SELECT icao_code FROM airlines WHERE icao_code=? AND country_code='LV'");
        $stmt->execute([$icaoCode]);
        $found = $stmt->fetch();
        if ($found) { $icaoList[] = $found['icao_code']; continue; }
    }
    // Fallback: try name matching
    $all = $db->prepare("SELECT icao_code, name FROM airlines WHERE country_code='LV'");
    $all->execute();
    foreach ($all as $a) {
        if (namesMatch($r['name'], $a['name'])) {
            $icaoList[] = $a['icao_code'];
        }
    }
}
$icaoList = array_unique($icaoList);
// Also include any generated ICAO codes from newly inserted airlines
foreach ($rows as $r) {
    $icaoCode = $r['icao'] ?: null;
    if (!$icaoCode) {
        $all = $db->prepare("SELECT icao_code FROM airlines WHERE country_code='LV' AND name=?");
        $all->execute([$r['name']]);
        foreach ($all as $a) { $icaoList[] = $a['icao_code']; }
    }
}
$icaoList = array_unique($icaoList);
$placeholders = implode(',', array_fill(0, count($icaoList), '?'));
$inactiveAll = $db->prepare("SELECT icao_code, name, active FROM airlines WHERE country_code='LV' AND active='Y' AND icao_code NOT IN ($placeholders)");
$inactiveAll->execute($icaoList);
$inactiveCount = 0;
foreach ($inactiveAll as $ia) {
    $db->prepare("UPDATE airlines SET active='N', updated_at=NOW() WHERE icao_code=?")->execute([$ia['icao_code']]);
    echo "  ⊘ {$ia['icao_code']}: '{$ia['name']}' marked inactive\n";
    $inactiveCount++;
}

echo "\n--- Summary ---\n";
echo "Total LV AOC entries: " . count($rows) . "\n";
echo "Airlines updated (active=Y): $updated\n";
echo "Airlines matched (already active): $matched\n";
echo "New airlines inserted: $inserted\n";
echo "Digital properties inserted: $digitalInserted\n";
echo "Fleet entries inserted: $fleetInserted\n";
echo "Other LV airlines marked inactive: $inactiveCount\n";
echo "Skipped: $skipped\n";
echo "\nDone.\n";
