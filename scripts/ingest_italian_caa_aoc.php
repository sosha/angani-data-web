<?php
/**
 * Ingests Italian CAA AOC data (companies holding air transport license).
 *
 * - Matches existing airlines by ICAO code or name
 * - Updates matched airlines: active='Y'
 * - Inserts contact info (email, phone, address) into airline_digital_properties
 * - Inserts new airlines for un-matched companies
 * - Updates regulatory_licensing_categories with Italian AOC type definitions
 *
 * Usage: php scripts/ingest_italian_caa_aoc.php
 * Environment: ANGANI_DB_PASS must be set
 */

$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$rows = [
    ['type'=>'V',   'icao'=>'AEI', 'name'=>'Ila S.r.l.',                                      'address'=>'Via Santo Stefano n. 10',                       'postal'=>'40125', 'city'=>'Bologna (BO)',                   'email'=>'aeliasrl@pec.it',                             'phone'=>'051 232323'],
    ['type'=>'V*',  'icao'=>'AEZ', 'name'=>'Aeroitalia S.r.l.',                                'address'=>'Viale Cesare Pavese n. 80',                     'postal'=>'00144', 'city'=>'Roma (RM)',                     'email'=>'aerotalla@pec.it',                            'phone'=>'06 840291'],
    ['type'=>'ECP', 'icao'=>'',    'name'=>'Air Corporate S.r.l.',                             'address'=>'Via Valosa di Sopra n. 9',                      'postal'=>'20900', 'city'=>'Monza (MB)',                    'email'=>'aircorporate@pec.it',                         'phone'=>'045 8600910'],
    ['type'=>'V*',  'icao'=>'DLA', 'name'=>'Air Dolomiti S.p.A. Linee Aeree Regionali Europee','address'=>'Via Paolo Bembo n. 70',                         'postal'=>'37062', 'city'=>'Dossobuono di Villafranca (VR)', 'email'=>'adm@pec.airdolomiti.it',                     'phone'=>'045 8605211'],
    ['type'=>'ERCX','icao'=>'',    'name'=>'Air Service Center S.r.l.',                        'address'=>'Frazione Fabbrica n. 31/A',                     'postal'=>'27040', 'city'=>'Arena Po (PV)',                 'email'=>'airservicecenter@legalmail.it',               'phone'=>'0385 272117'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Airgreen S.r.l.',                                  'address'=>'Via Fiano n. 175',                              'postal'=>'10070', 'city'=>'Robassomero (TO)',               'email'=>'airgreen@pec.airgreen.it',                    'phone'=>'011 9235971'],
    ['type'=>'V',   'icao'=>'AFQ', 'name'=>'Alba Servizi Aerotrasporti S.p.A.',               'address'=>'Via Paleocapa n. 3',                            'postal'=>'20121', 'city'=>'Milano (MI)',                   'email'=>'albaaerotrasporti@pec.fininvest.it',          'phone'=>'02 21026181'],
    ['type'=>'ELID','icao'=>'',    'name'=>'Alidaunia S.r.l.',                                 'address'=>'Strada Statale 673 km. 19.00 s.n.c.',           'postal'=>'71100', 'city'=>'Foggia (FG)',                   'email'=>'alidauniaqroup@legalmail.it',                 'phone'=>'0881 617961'],
    ['type'=>'VTJD','icao'=>'',    'name'=>'Aliserio S.r.l.',                                  'address'=>'Aeroporto Città di Torino s.n.c.',              'postal'=>'10072', 'city'=>'Caselle Torinese (TO)',         'email'=>'info.aliserio@legalmail.it',                  'phone'=>'02 58095811'],
    ['type'=>'VRIZ','icao'=>'',    'name'=>'Alpine Wings S.r.l.',                              'address'=>'Via Troyenbach n. 1/E',                         'postal'=>'39030', 'city'=>'Vandoies (BZ)',                  'email'=>'alpinewings@pec.it',                          'phone'=>'3428132679'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Ariane S.r.l. Unipersonale',                       'address'=>'Via Colonnello Alessi n. 15',                   'postal'=>'23100', 'city'=>'Sondrio (SO)',                   'email'=>'arianersrl@pec.it',                           'phone'=>'0342 354013'],
    ['type'=>'V/EVND','icao'=>'',  'name'=>'Avionord S.r.l.',                                  'address'=>'Viale dell\'Aviazione n. 65',                   'postal'=>'20138', 'city'=>'Milano (MI)',                   'email'=>'avionord@legalmail.it',                       'phone'=>'02 7020201'],
    ['type'=>'EELH','icao'=>'',    'name'=>'Avincis Aviation Italia S.p.A.',                   'address'=>'Piazza Castello n. 26',                         'postal'=>'20121', 'city'=>'Milano (MI)',                   'email'=>'qualita@pec.babcockinternational.com',        'phone'=>'0341 934611'],
    ['type'=>'V#',  'icao'=>'ICV', 'name'=>'Cargolux Italia S.p.A.',                           'address'=>'Via Fratelli Cairoli n. 2',                     'postal'=>'25100', 'city'=>'Brescia (BS)',                  'email'=>'cargolux@legalmail.it',                       'phone'=>'0331 233811'],
    ['type'=>'ECAHE','icao'=>'',   'name'=>'+S Air S.r.l.',                                    'address'=>'Contrada Ficocelle snc',                        'postal'=>'84061', 'city'=>'Ogliastro Cilento (SA)',        'email'=>'esair@pec.it',                                'phone'=>'0974 833624'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Eliabruzzo S.r.l.',                                'address'=>'Zona Industriale Campotrino snc',               'postal'=>'66010', 'city'=>'San Martino sulla Marrucina (CH)','email'=>'eliabruzzo@pec.it',                           'phone'=>'0871 85351'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Elicampiglio S.r.l.',                              'address'=>'Via dei Dossi n. 18',                           'postal'=>'38025', 'city'=>'Dimaro Folgarida (TN)',          'email'=>'elicampiglio@pec.it',                         'phone'=>'0463 974044'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Elicompany S.r.l.',                                'address'=>'Via Grilli n. 5/A',                             'postal'=>'41012', 'city'=>'Carpi (MO) - Fraz. Budrione',    'email'=>'elicompansrl@legalmail.it',                   'phone'=>'059 660344'],
    ['type'=>'EE',  'icao'=>'',    'name'=>'Elifly International S.r.l.',                      'address'=>'Via Casa Bianca n. 22',                         'postal'=>'25040', 'city'=>'Esine (BS)',                    'email'=>'eliflyinternationalsrl@legalmail.it',         'phone'=>'0364 466375'],
    ['type'=>'EEFG','icao'=>'',    'name'=>'Elifriulia S.p.A.',                                'address'=>'Piazzetta Luigi Coloatto n. 1',                'postal'=>'34077', 'city'=>'Ronchi dei Legionari (GO)',      'email'=>'elifriulia@pec.elifriulia.it',                'phone'=>'0481 778901'],
    ['type'=>'V/EEOA','icao'=>'',  'name'=>'Ellombarda S.r.l.',                                'address'=>'Lungolago Duca degli Abruzzi n. 4',             'postal'=>'521100', 'city'=>'Calcinate del Pesce (VA)',       'email'=>'legal@ellombarda.legalmail.it',               'phone'=>'0332 310568'],
    ['type'=>'EEOS','icao'=>'',    'name'=>'Eliossola S.r.l.',                                 'address'=>'Via Piave n. 11',                               'postal'=>'28845', 'city'=>'Domodossola (VB)',               'email'=>'eliossola@pec.eliossola.it',                   'phone'=>'0324 44013'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Elitaliana Aviation & Training S.r.l.',            'address'=>'Via Salaria n. 2061',                           'postal'=>'00138', 'city'=>'Roma (RM)',                     'email'=>'eta@winpec.it',                               'phone'=>'06 88521199'],
    ['type'=>'EFGS','icao'=>'',    'name'=>'Elitellina S.r.l.',                                'address'=>'Via Eliporto 37',                               'postal'=>'23017', 'city'=>'Talamona (SO)',                  'email'=>'elitellina@pec.it',                           'phone'=>'0342 213336'],
    ['type'=>'EESP','icao'=>'',    'name'=>'Esperia Aviation Services S.p.A.',                 'address'=>'Via Salaria n. 825',                            'postal'=>'00138', 'city'=>'Roma (RM)',                     'email'=>'esperia.aviation@pec.it',                     'phone'=>'06 88700801'],
    ['type'=>'E',   'icao'=>'',    'name'=>'GMG Aviation S.r.l.',                              'address'=>'Via Carlo D\'Angiò, 23 c/o aeroporto',          'postal'=>'67100', 'city'=>'L\'Aquila',                    'email'=>'gmg01@pec.it',                                'phone'=>'0862 293591'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Heliwest S.r.l.',                                  'address'=>'Via Fiera n. 11',                               'postal'=>'14057', 'city'=>'Isola d\'Asti (AT)',             'email'=>'heliwest@pec.it',                             'phone'=>'0141 595985'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Helixcom S.r.l.',                                  'address'=>'Contrada Xirbi snc',                            'postal'=>'93100', 'city'=>'Caltanissetta (CL)',             'email'=>'helixcom@pec.it',                             'phone'=>'0934 23661'],
    ['type'=>'EHOV','icao'=>'',    'name'=>'Hoverfly divisione Sam S.r.l.',                    'address'=>'Via Orazio n. 15',                              'postal'=>'65128', 'city'=>'Pescara (PE)',                   'email'=>'hoverflydivisionesam@legalmail.it',           'phone'=>'082 8354155'],
    ['type'=>'ECIO','icao'=>'',    'name'=>'Il Ciocco International Travel Service S.r.l.',    'address'=>'Fraz. Castelvecchio Pascoli',                   'postal'=>'55020', 'city'=>'Barga (LU)',                    'email'=>'ciocctravelsrl@legalmail.it',                 'phone'=>'0583 7191'],
    ['type'=>'VMTF','icao'=>'',    'name'=>'Interjet S.r.l.',                                  'address'=>'Via Belvedere n. 23',                           'postal'=>'41014', 'city'=>'Castelvetro di Modena (MO)',     'email'=>'interjet@pec.cremonini.com',                  'phone'=>'051 406931'],
    ['type'=>'V*',  'icao'=>'ITY', 'name'=>'ITA Airways (Italia Trasporto Aereo S.p.A.)',      'address'=>'Via Venti Settembre n. 97',                     'postal'=>'00187', 'city'=>'Roma (RM)',                     'email'=>'italiatrasportoareeo@legalmail.it',           'phone'=>'06 56556407'],
    ['type'=>'V/EITL','icao'=>'',  'name'=>'Italfly S.r.l.',                                   'address'=>'Via Lidorno n. 3',                              'postal'=>'38100', 'city'=>'Trento (TN) - Fraz. Mattarello',  'email'=>'italfly@pecimprese.it',                       'phone'=>'0461 944200'],
    ['type'=>'VLSA','icao'=>'',    'name'=>'Leader S.r.l.',                                    'address'=>'Via Napoli n. 28',                              'postal'=>'00043', 'city'=>'Ciampino (RM)',                 'email'=>'leadersrl@pec.flyleader.it',                  'phone'=>'06 79340666'],
    ['type'=>'VLIT','icao'=>'',    'name'=>'Leisure One Fly S.r.l.',                           'address'=>'Via Alfredo Catalani n. 3',                     'postal'=>'900199', 'city'=>'Roma (RM)',                    'email'=>'info@flyelone.com',                            'phone'=>'06 86205368'],
    ['type'=>'V#',  'icao'=>'LSI', 'name'=>'MSC Air S.p.A. (formerly Aliscargo Airlines S.p.A.)','address'=>'Corso Sempione 32/A',                          'postal'=>'20154', 'city'=>'Milano (MI)',                   'email'=>'mscair.ops@pec.it',                           'phone'=>'0331 1098000'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Mycopter S.r.l.',                                  'address'=>'Via Santa Maria Valle n. 5',                    'postal'=>'20123', 'city'=>'Milano (MI)',                   'email'=>'mycopter@legalmail.it',                       'phone'=>'0182 1976650'],
    ['type'=>'V*',  'icao'=>'NOS', 'name'=>'Neos S.p.A.',                                      'address'=>'Via della Chiesa n. 68',                        'postal'=>'21019', 'city'=>'Somma Lombardo (VA)',            'email'=>'neos@postecert.it',                           'phone'=>'0331 232811'],
    ['type'=>'ENDD','icao'=>'',    'name'=>'Nordend S.r.l.',                                   'address'=>'Piazza Resistenza n. 2',                        'postal'=>'28883', 'city'=>'Gravellona Toce (VB)',           'email'=>'nordend.srl@pec.it',                          'phone'=>'345 2206977'],
    ['type'=>'E',   'icao'=>'',    'name'=>'North West Service S.r.l.',                        'address'=>'Corso Re Umberto n. 54',                        'postal'=>'10128', 'city'=>'Torino (TO)',                   'email'=>'nwservice@pec.it',                            'phone'=>'0124 422018'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Novaris S.r.l.',                                   'address'=>'Via Papa Giovanni XXIII n. 62',                 'postal'=>'27058', 'city'=>'Voghera (PV)',                  'email'=>'novaris@pec.it',                              'phone'=>'348 2437988'],
    ['type'=>'V#',  'icao'=>'MSA', 'name'=>'Poste Air Cargo S.r.l. (formerly Mistral Air S.r.l.)','address'=>'Viale Europa n. 190',                        'postal'=>'00144', 'city'=>'Roma (RM)',                     'email'=>'posteaircargo@pec.posteitaliane.it',          'phone'=>'06 96661815'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Provincia Autonoma di Trento',                      'address'=>'Via Secondo da Trento n. 23',                  'postal'=>'38122', 'city'=>'Trento (TN)',                   'email'=>'segreter.genérale@pec.provincia.tn.it',       'phone'=>'0461 492360'],
    ['type'=>'VSSR','icao'=>'',    'name'=>'Sardinian Sky Service S.r.l.',                     'address'=>'Via Sorrento n. 50',                            'postal'=>'09045', 'city'=>'Quartu Sant\'Elena (CA)',        'email'=>'sss@pec.it',                                  'phone'=>'070 7737663'],
    ['type'=>'VSNM','icao'=>'',    'name'=>'Servizi Aerei S.p.A.',                             'address'=>'Via Agadir n. 38',                              'postal'=>'20097', 'city'=>'S. Donato Milanese (MI)',        'email'=>'servizi.aerei@pec.eni.it',                    'phone'=>'06 79348601'],
    ['type'=>'VSIO','icao'=>'',    'name'=>'Sirio S.p.A.',                                     'address'=>'Viale dell\'Aviazione n. 65',                  'postal'=>'20138', 'city'=>'Milano (MI)',                   'email'=>'quality@pec.sirio.aero',                       'phone'=>'02 70209966'],
    ['type'=>'V*',  'icao'=>'SWU', 'name'=>'Sky Alps S.r.l.',                                  'address'=>'Piazza del grano n. 3',                        'postal'=>'39100', 'city'=>'Bolzano (BZ)',                  'email'=>'skyalps@legalmail.it',                        'phone'=>'0471 324 210'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Sky Aviation S.r.l. (formerly Airstar Aviation S.r.l.)','address'=>'Piazzale Funivie Val Veny',                 'postal'=>'11013', 'city'=>'Courmayeur - Entrevies (AO)',   'email'=>'skyaviation@pec.it',                          'phone'=>'015 9840196'],
    ['type'=>'V',   'icao'=>'',    'name'=>'Sky Services S.p.A.',                               'address'=>'Via Guantai Nuovi n.16',                       'postal'=>'80133', 'city'=>'Napoli (NA)',                   'email'=>'skyservices@pec.it',                          'phone'=>'815522421'],
    ['type'=>'VSLJ','icao'=>'',    'name'=>'SLAM Lavori Aerei S.r.l.',                         'address'=>'Aeroporto Civile Capodichino',                  'postal'=>'80144', 'city'=>'Napoli (NA)',                   'email'=>'slam.lavoriaerei@pec.it',                     'phone'=>'081 5844319'],
    ['type'=>'ESWP','icao'=>'',    'name'=>'Star Work Sky S.a.s. di Giovanni Subrero & C.',    'address'=>'Regione Oltrebornida s.n.',                     'postal'=>'15019', 'city'=>'Strevi (AL)',                   'email'=>'sws@legalmail.it',                            'phone'=>'0144 73225'],
    ['type'=>'E',   'icao'=>'',    'name'=>'Westair Helicopters S.r.l. (formerly Weststar NDD S.r.l.)','address'=>'Via Gabriele D\'Annunzio n. 42',          'postal'=>'21010', 'city'=>'Vizzola Ticino (VA)',            'email'=>'westairhelicopterssrl@pec.it',                'phone'=>'0331 1352923'],
];

// Helper: full address string
function fullAddress($r): string {
    return trim($r['address'] . ', ' . $r['postal'] . ' ' . $r['city']);
}

// Helper: upsert digital property (check existence first, then insert)
function upsertDigitalProperty(PDO $db, string $icao, string $name, string $category, string $platform, string $value): void {
    if (!$value) return;
    $exists = $db->prepare("SELECT id FROM airline_digital_properties WHERE icao_code=? AND category=? AND platform=? AND url_or_handle=?");
    $exists->execute([$icao, $category, $platform, $value]);
    if ($exists->fetch()) return;
    $db->prepare("INSERT INTO airline_digital_properties (country_code, icao_code, airline_name, category, platform, url_or_handle, is_primary)
        VALUES ('IT', ?, ?, ?, ?, ?, 1)")->execute([$icao, $name, $category, $platform, $value]);
}

// Helper: clean company name for matching (remove legal suffixes)
function cleanName(string $name): string {
    $name = preg_replace('/\s*S\.?r?\.?l\.?\s*.*$/i', '', $name);
    $name = preg_replace('/\s*S\.?p\.?A\.?\s*.*$/i', '', $name);
    $name = preg_replace('/\s*S\.?a\.?s\.?\s*.*$/i', '', $name);
    $name = preg_replace('/\s*S\.?p\.?a\.?\s*.*$/i', '', $name);
    $name = preg_replace('/\s*Unipersonale\s*/i', '', $name);
    $name = preg_replace('/\s*\(formerly[^)]*\)/i', '', $name);
    $name = preg_replace('/[",.]/', '', $name);
    return trim(strtolower($name));
}

// Helper: names match if they share significant word-level overlap
function namesMatch(string $caaName, string $dbName): bool {
    $a = cleanName($caaName);
    $b = cleanName($dbName);
    if (!$a || !$b) return false;
    if ($a === $b) return true;
    $wa = preg_split('/\s+/', $a);
    $wb = preg_split('/\s+/', $b);
    $common = array_intersect($wa, $wb);
    $shortest = min(count($wa), count($wb));
    if ($shortest <= 2) return count($common) >= $shortest;
    if ($shortest <= 4) return count($common) >= $shortest - 1;
    return count($common) >= $shortest - 1 && $common;
}

$updated = 0;
$inserted = 0;
$matched = 0;
$skipped = 0;
$digitalInserted = 0;
$digitalUpdated = 0;

echo "Processing " . count($rows) . " Italian CAA AOC entries...\n\n";

foreach ($rows as $r) {
    $icaoCode = $r['icao'];
    $companyName = $r['name'];
    $addr = fullAddress($r);
    $email = $r['email'];
    $phone = $r['phone'];
    $active = 'Y';

    // Determine carrier ICAO for digital properties (may differ from lookup icao)
    $carrierIcao = $icaoCode ?: null;
    $matchedAirline = null;

    if ($icaoCode) {
        // Try matching by ICAO code
        $stmt = $db->prepare("SELECT icao_code, name, active FROM airlines WHERE icao_code=? AND country_code='IT'");
        $stmt->execute([$icaoCode]);
        $existing = $stmt->fetch();

        if ($existing && namesMatch($companyName, $existing['name'])) {
            $matchedAirline = $existing;
            $carrierIcao = $existing['icao_code'];
        } elseif ($existing) {
            // Same ICAO, same country, different name — likely a rename
            echo "  → ICAO $icaoCode: renamed '{$existing['name']}' -> '{$companyName}'\n";
            $db->prepare("UPDATE airlines SET name=?, active='Y', updated_at=NOW() WHERE icao_code=?")
                ->execute([$companyName, $icaoCode]);
            $matchedAirline = ['icao_code' => $icaoCode, 'name' => $companyName, 'active' => 'Y'];
            $carrierIcao = $icaoCode;
        }
    }

    // If no match by ICAO, try by name
    if (!$matchedAirline) {
        $cn = cleanName($companyName);
        $all = $db->prepare("SELECT icao_code, name, active FROM airlines WHERE country_code='IT'");
        $all->execute();
        foreach ($all as $a) {
            if (namesMatch($companyName, $a['name'])) {
                $matchedAirline = $a;
                $carrierIcao = $carrierIcao ?: ($a['icao_code'] ?: null);
                break;
            }
        }
    }

    if ($matchedAirline) {
        // Update active='Y'
        if ($matchedAirline['active'] !== 'Y') {
            $db->prepare("UPDATE airlines SET active='Y', updated_at=NOW() WHERE icao_code=?")
                ->execute([$matchedAirline['icao_code']]);
            echo "  ✓ Updated {$matchedAirline['icao_code']}: active=Y\n";
            $updated++;
        } else {
            echo "  • {$matchedAirline['icao_code']}: already active\n";
        }

        // If the CAA row has an ICAO different from the matched airline, update it
        if ($icaoCode && $icaoCode !== $matchedAirline['icao_code']) {
            $db->prepare("UPDATE airlines SET icao_code=?, updated_at=NOW() WHERE icao_code=?")
                ->execute([$icaoCode, $matchedAirline['icao_code']]);
            echo "  → Updated ICAO: {$matchedAirline['icao_code']} -> $icaoCode\n";
            $carrierIcao = $icaoCode;
        }

        $matched++;
    } else {
        // Insert new airline (requires ICAO code as PK)
        if ($icaoCode) {
            // Check if ICAO is taken by a non-Italian airline (collision)
            $taken = $db->prepare("SELECT name, country_code FROM airlines WHERE icao_code=?");
            $taken->execute([$icaoCode]);
            $takenRow = $taken->fetch();
            if ($takenRow) {
                echo "  ⚠ ICAO $icaoCode already taken by '{$takenRow['name']}' ({$takenRow['country_code']}) — skipping\n";
                $carrierIcao = null;
                $skipped++;
            } else {
                $db->prepare("INSERT INTO airlines (icao_code, name, country, country_code, active, created_at, updated_at)
                    VALUES (?, ?, 'Italy', 'IT', 'Y', NOW(), NOW())")
                    ->execute([$icaoCode, $companyName]);
                $carrierIcao = $icaoCode;
                echo "  + Inserted new airline: '{$companyName}' (ICAO: $icaoCode)\n";
                $inserted++;
            }
        } else {
            echo "  ⚠ Cannot insert '{$companyName}' (no ICAO code — PK required)\n";
            $skipped++;
        }
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
    } else {
        echo "  ⚠ No ICAO code available for digital properties\n";
        $skipped++;
    }
}

// Update regulatory_licensing_categories for Italy
echo "\n--- Updating Italian AOC licensing categories ---\n";
$db->prepare("DELETE FROM regulatory_licensing_categories WHERE iso_country='IT'")->execute();

$licenses = [
    ['iso_country'=>'IT', 'category'=>'AOC', 'name'=>'V', 'validity'=>'Standard', 'cost'=>'', 'requirements'=>'', 'description'=>'Fixed-wing aircraft (aeroplani)'],
    ['iso_country'=>'IT', 'category'=>'AOC', 'name'=>'E', 'validity'=>'Standard', 'cost'=>'', 'requirements'=>'', 'description'=>'Helicopters (elicotteri)'],
    ['iso_country'=>'IT', 'category'=>'AOC', 'name'=>'# (Cargo)', 'validity'=>'', 'cost'=>'', 'requirements'=>'Cargo only operations', 'description'=>'Limited to cargo-only operations'],
    ['iso_country'=>'IT', 'category'=>'AOC', 'name'=>'* (19+ seats)', 'validity'=>'', 'cost'=>'', 'requirements'=>'Aircraft with more than 19 passenger seats', 'description'=>'Aircraft certified for more than 19 seats'],
];
$insLic = $db->prepare("INSERT INTO regulatory_licensing_categories (iso_country, category, name, validity, cost, requirements, description) VALUES (?,?,?,?,?,?,?)");
foreach ($licenses as $l) {
    $insLic->execute([$l['iso_country'], $l['category'], $l['name'], $l['validity'], $l['cost'], $l['requirements'], $l['description']]);
    echo "  + Added licensing category: {$l['name']}\n";
}

echo "\n--- Summary ---\n";
echo "Total CAA entries: " . count($rows) . "\n";
echo "Airlines updated (active=Y): $updated\n";
echo "Airlines matched (already active): $matched\n";
echo "New airlines inserted: $inserted\n";
echo "Digital properties inserted: $digitalInserted\n";
echo "Skipped (no ICAO): $skipped\n";
echo "\nDone.\n";
