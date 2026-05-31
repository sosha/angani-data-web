<?php
/**
 * Ingests Greek HCAA AOC holders list (May 2026).
 *
 * - Matches existing GR airlines by name
 * - Updates matched airlines: active='Y'
 * - Inserts contact data (address, phone, email, website) into airline_digital_properties
 * - Inserts new airlines with generated ICAO codes (GR{AOC_NUMBER})
 * - Marks all GR airlines NOT on this list as active='N'
 *
 * Usage: php scripts/ingest_greek_caa_aoc.php
 * Environment: ANGANI_DB_PASS must be set
 */

$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$rows = [
    ['aoc'=>'AOC.GR-007', 'name'=>'AEGEAN AIRLINES SA',             'address'=>'Athens International Airport, Building 57, 19 019, Spata, Attiki, Greece',        'phone'=>'+30 210 3550141', 'email'=>'a3occ@aegeanair.com'],
    ['aoc'=>'AOC.GR-065', 'name'=>'AEGEAN EXECUTIVE',                'address'=>'Athens International Airport, Building 57, 19 019, Spata, Attiki, Greece',        'phone'=>'+30 210 3550141', 'email'=>'a3occ@aegeanair.com'],
    ['aoc'=>'AOC.GR-050', 'name'=>'AIR MEDITERRANEAN',               'address'=>'140 Vouliagmenis Avenue, Glyfada GR-16674, Athens, Greece',                        'phone'=>'+30 210 89 47 373', 'email'=>'info@air-mediterranean.com'],
    ['aoc'=>'AOC.GR-034', 'name'=>'BLUE BIRD AIRWAYS AE',            'address'=>'Iraklion International Airport \'Nikos Kazantzakis\', Crete, Greece',              'phone'=>'+30 2810 224451', 'email'=>'amg@bluebirdair.com'],
    ['aoc'=>'AOC.GR-010', 'name'=>'EPSILON AVIATION SA',             'address'=>'Athens Int\'l Airport \'Eleftherios Venizelos\' BLD 16, GR-19019, Spata, Greece',  'phone'=>'+30 210 3538500', 'email'=>'info@epsilonaviation.com'],
    ['aoc'=>'AOC.GR-060', 'name'=>'HOPER',                           'address'=>'24A Ermou st., Markopoulo Mesogaias, 19003 Attika, Greece',                         'phone'=>'+30 22990 40650', 'email'=>'twr@flyhoper'],
    ['aoc'=>'AOC.GR-024', 'name'=>'GAIN JET AVIATION AE',            'address'=>'Vouliagmenis Avenue & 1 Themistokleous st. Glyfada, GR-16674 Attica, Greece',      'phone'=>'+30 210 9636101', 'email'=>'info@gainjet.com'],
    ['aoc'=>'AOC.GR-027', 'name'=>'LIFE LINE AVIATION',              'address'=>'Agiou Georgiou & Dionysou st. Halandri, GR-15234 Attiki, Greece',                 'phone'=>'+30 210 6740600', 'email'=>'accountable@airlife.gr'],
    ['aoc'=>'AOC.GR-030', 'name'=>'OLYMPIC AIR',                     'address'=>'Athens Int\'l Airport \'Eleftherios Venizelos\' Building 57, GR-19019, Spata, Greece','phone'=>'+30 210 3550427', 'email'=>'A11QA@aegeanair.com'],
    ['aoc'=>'AOC.GR-063', 'name'=>'PANELLENIC AIRLINES SA',          'address'=>'S. Kazantzidis & Vosporou 2A Str., GR-71601 N. Alikarnassos, Heraklion, Greece',   'phone'=>'+30 2810 382900', 'email'=>'manager@panellenic.gr'],
    ['aoc'=>'AOC.GR-021', 'name'=>'SKY EXPRESS SA',                  'address'=>'Iraklion International Airport \'Nikos Kazantzakis\' GR-71601, Crete, Greece',     'phone'=>'+30 2810 223835', 'email'=>'info@skyexpress.gr'],
    ['aoc'=>'AOC.GR-004', 'name'=>'SWIFT AIR HELLAS',                'address'=>'El. Dimokratias, A. Koumbi 24 & Ch. Giannaki 1, GR-19003, Markopoulo, Attiki, Greece','phone'=>'+30 22990 63790', 'email'=>'maf_ops@swiftair.com'],
    ['aoc'=>'AOC.GR-62',  'name'=>'MARATHON AIRLINES',               'address'=>'14 Lontou str., GR-16675, Glyfada Attica, Greece',                                 'phone'=>'+30 210 9607400', 'email'=>'info@flymarathon.aero'],
    ['aoc'=>'AOC.GR-061', 'name'=>'NORTHERN WINGS SA',               'address'=>'22 Andrianoupoleos str., GR-55133, Kalamaria Thessaloniki, Greece',                'phone'=>'+30 2310 486410', 'email'=>'office@northernwings.gr'],
    ['aoc'=>'AOC.GR-016', 'name'=>'AIR INTERSALONIKA',               'address'=>'Dimarchou Christou Mpeka Str. 69, 19004 Spata Attica, Greece',                     'phone'=>'+30 210 6632847', 'email'=>'ops@airintersalonica.gr'],
    ['aoc'=>'AOC.GR-017', 'name'=>'AIR LIFT AE',                     'address'=>'Ave. Megaridos str. 124, 19300 Aspropyrgos, Attika, Greece',                      'phone'=>'+30 2108093834', 'email'=>'info@airlift.gr'],
    ['aoc'=>'AOC.GR-046', 'name'=>'IFLY',                            'address'=>'Megara Civil Airport, GR-19100, Megara, Greece',                                    'phone'=>'+30 22960 80744', 'email'=>'info@ifly.gr'],
    ['aoc'=>'AOC.GR-040', 'name'=>'SUPERIOR AIR SERVICES',           'address'=>'Megara Civil Airport, GR-19100, Megara, Greece',                                    'phone'=>'+30 22967 72018', 'email'=>'info@superior-air.gr'],
    ['aoc'=>'AOC.GR-052', 'name'=>'HELISTAR',                        'address'=>'Pythagora 50, Koropi Attikis, 19441, Greece',                                       'phone'=>'+30 2106020915', 'email'=>'info@helistar.eu'],
    ['aoc'=>'AOC.GR-056', 'name'=>'BELAVIA / AGRIONIC AIR AF',       'address'=>'8A Iviskon st. GR-14568, Krioneri Attiki, Greece',                                 'phone'=>'+30 2106221759', 'email'=>'bellavialtd@gmail.com'],
    ['aoc'=>'AOC.GR-058', 'name'=>'JETWAY',                          'address'=>'28 km Lavriou Avenue GR-19400, Koropi Attiki, Greece',                             'phone'=>'+30 211 8009050', 'email'=>'info@jetway.gr'],
];

function cleanName(string $name): string {
    $name = preg_replace('/\s*S\.?A\.?\s*$/i', '', $name);
    $name = preg_replace('/\s*AE\s*$/i', '', $name);
    $name = preg_replace('/\s*S\.?A\.?\s*/i', ' ', $name);
    $name = preg_replace('/\bS\.?p\.?A\.?\b/i', '', $name);
    $name = preg_replace('/\s*LIMITED\s*$/i', '', $name);
    $name = preg_replace('/\s*LTD\s*$/i', '', $name);
    $name = preg_replace('/\s*PLC\s*$/i', '', $name);
    $name = preg_replace('/\s*\(formerly[^)]*\)/i', '', $name);
    $name = preg_replace('/\s*\(UK\)\s*$/i', '', $name);
    $name = preg_replace('/\s+UK\s*$/i', '', $name);
    $name = preg_replace('/\s*\(NI\)\s*$/i', '', $name);
    $name = preg_replace('/[",.]/', '', $name);
    $name = preg_replace('/\s+/', ' ', $name);
    return trim(strtolower($name));
}

function namesMatch(string $aocName, string $dbName): bool {
    $a = cleanName($aocName);
    $b = cleanName($dbName);
    if (!$a || !$b) return false;
    if ($a === $b) return true;
    $stopwords = ['air', 'airways', 'aviation', 'airlines', 'services', 'helicopter', 'helicopters', 'flight', 'fly', 'aero', 'limited', 'ltd', 'plc', 'international', 'group', 'company', 'uk', 'ni', 'gb', 'operations', 'charter', 'club', 'sa', 'ae'];
    $wa = array_diff(explode(' ', $a), $stopwords);
    $wb = array_diff(explode(' ', $b), $stopwords);
    if (!$wa && !$wb) return false;
    if (!$wa || !$wb) return false;
    return implode(' ', $wa) === implode(' ', $wb);
}

function extractWebsite(string $email): string {
    if (!$email) return '';
    $parts = explode('@', $email);
    if (count($parts) !== 2) return '';
    $domain = strtolower(trim($parts[1]));
    // Skip generic email providers
    $generic = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com', 'icloud.com', 'mail.com', 'protonmail.com', 'live.com'];
    if (in_array($domain, $generic)) return '';
    return 'www.' . $domain;
}

function upsertDigitalProperty(PDO $db, string $icao, string $name, string $category, string $platform, string $value): void {
    if (!$value) return;
    $exists = $db->prepare("SELECT id FROM airline_digital_properties WHERE icao_code=? AND category=? AND platform=? AND url_or_handle=?");
    $exists->execute([$icao, $category, $platform, $value]);
    if ($exists->fetch()) return;
    $db->prepare("INSERT INTO airline_digital_properties (country_code, icao_code, airline_name, category, platform, url_or_handle, is_primary)
        VALUES ('GR', ?, ?, ?, ?, ?, 1)")->execute([$icao, $name, $category, $platform, $value]);
}

$updated = 0;
$inserted = 0;
$matched = 0;
$digitalInserted = 0;
$skipped = 0;

echo "Processing " . count($rows) . " Greek AOC holders...\n\n";

foreach ($rows as $r) {
    $companyName = $r['name'];
    $aoc = $r['aoc'];
    $address = $r['address'];
    $phone = $r['phone'];
    $email = $r['email'];
    $website = extractWebsite($email);

    // Pre-load GR airlines for matching
    $grAirlines = function() use ($db) {
        $s = $db->prepare("SELECT icao_code, name, active FROM airlines WHERE country_code='GR'");
        $s->execute();
        return $s;
    };

    // Try name matching
    $matchedAirline = null;
    foreach ($grAirlines() as $a) {
        if (namesMatch($companyName, $a['name'])) {
            $matchedAirline = $a;
            break;
        }
    }

    if ($matchedAirline) {
        $icao = $matchedAirline['icao_code'];
        if ($matchedAirline['active'] !== 'Y') {
            $db->prepare("UPDATE airlines SET active='Y', updated_at=NOW() WHERE icao_code=?")
                ->execute([$icao]);
            echo "  ✓ Updated {$icao}: active=Y\n";
            $updated++;
        } else {
            echo "  • {$icao}: already active\n";
        }
        $matched++;
    } else {
        // Generate ICAO: GR{AOC_NUMBER} — strip prefix, normalize
        $aocNum = preg_replace('/[^0-9]/', '', $aoc);
        if (!$aocNum) {
            echo "  ⚠ No ICAO could be generated for '{$companyName}' (AOC: {$aoc})\n";
            $skipped++;
            continue;
        }
        $genIcao = 'GR' . $aocNum;

        // Check for collision
        $collision = $db->prepare("SELECT name FROM airlines WHERE icao_code=?");
        $collision->execute([$genIcao]);
        if ($collision->fetch()) {
            echo "  ⚠ Generated ICAO $genIcao collides for '{$companyName}' — skipping\n";
            $skipped++;
            continue;
        }

        $db->prepare("INSERT INTO airlines (icao_code, name, country, country_code, active, created_at, updated_at)
            VALUES (?, ?, 'Greece', 'GR', 'Y', NOW(), NOW())")
            ->execute([$genIcao, $companyName]);
        echo "  + Inserted {$genIcao}: '{$companyName}'\n";
        $inserted++;
        $icao = $genIcao;
    }

    // Insert digital properties
    if ($address) {
        upsertDigitalProperty($db, $icao, $companyName, 'Contact', 'Address', $address);
        $digitalInserted++;
    }
    if ($phone) {
        upsertDigitalProperty($db, $icao, $companyName, 'Contact', 'Phone', $phone);
        $digitalInserted++;
    }
    if ($email) {
        upsertDigitalProperty($db, $icao, $companyName, 'Contact', 'Email', $email);
        $digitalInserted++;
    }
    if ($website) {
        upsertDigitalProperty($db, $icao, $companyName, 'Contact', 'Website', 'https://' . $website);
        $digitalInserted++;
    }
}

// ---- Mark all other GR airlines as inactive ----
echo "\n--- Marking Greek airlines NOT on AOC list as inactive ---\n";
$aocNames = array_map(fn($r) => $r['name'], $rows);
$aocNames = array_map('cleanName', $aocNames);

$allGr = $db->prepare("SELECT icao_code, name FROM airlines WHERE country_code='GR'");
$allGr->execute();
$markedInactive = 0;
foreach ($allGr as $a) {
    $clean = cleanName($a['name']);
    $isInList = false;
    foreach ($aocNames as $aoc) {
        if ($clean === $aoc) { $isInList = true; break; }
    }
    if (!$isInList) {
        $db->prepare("UPDATE airlines SET active='N', updated_at=NOW() WHERE icao_code=?")
            ->execute([$a['icao_code']]);
        echo "  ⊘ {$a['icao_code']}: '{$a['name']}' marked inactive\n";
        $markedInactive++;
    }
}

echo "\n--- Summary ---\n";
echo "Total HCAA entries: " . count($rows) . "\n";
echo "Airlines matched (updated active=Y): $matched\n";
echo "  - of which newly set to active: $updated\n";
echo "New airlines inserted: $inserted\n";
echo "Digital properties inserted: $digitalInserted\n";
echo "Skipped: $skipped\n";
echo "Other GR airlines marked inactive: $markedInactive\n";
echo "\nDone.\n";
