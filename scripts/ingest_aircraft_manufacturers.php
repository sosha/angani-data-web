<?php
/**
 * Ingest ultimate_aircraft_manufacturers.csv into aircraft_manufacturers table.
 * Downloads logos locally and resolves parent/predecessor/successor FKs.
 * Usage: php scripts/ingest_aircraft_manufacturers.php <csv_path>
 */

declare(strict_types=1);

$csvPath = $argv[1] ?? __DIR__ . '/../data/ultimate_aircraft_manufacturers.csv';
$logoDir = __DIR__ . '/../assets/manufacturer_logos';

require __DIR__ . '/../includes/db.php';

function logMsg(string $msg): void { echo '[' . date('H:i:s') . '] ' . $msg . PHP_EOL; }

// --- Create table if not exists ---
logMsg('Ensuring aircraft_manufacturers table exists...');
$db = db();
$schema = file_get_contents(__DIR__ . '/../database/01_schema.sql');
preg_match('/CREATE TABLE IF NOT EXISTS aircraft_manufacturers.*?ENGINE=InnoDB[^;]+;/s', $schema, $m);
if (!$m) { logMsg('ERROR: Could not extract CREATE TABLE from schema'); exit(1); }
try { $db->exec($m[0]); } catch (Throwable $e) { logMsg('WARN: Table may already exist: ' . $e->getMessage()); }

// --- Drop existing data for idempotency ---
$db->exec('DELETE FROM aircraft_manufacturers');
logMsg('Cleared existing manufacturer data');

// --- Read CSV ---
logMsg('Reading CSV: ' . $csvPath);
$rows = [];
$csvFile = fopen($csvPath, 'r');
if (!$csvFile) { logMsg('ERROR: Cannot open CSV'); exit(1); }
$headers = fgetcsv($csvFile);
$colMap = array_flip($headers);
$totalRows = 0;
while ($row = fgetcsv($csvFile)) {
    $totalRows++;
    $rows[] = $row;
}
fclose($csvFile);
logMsg("Read $totalRows data rows");

// --- Phase 1: Insert all rows without FK refs ---
logMsg('Phase 1: Inserting manufacturer rows...');
$stmt = $db->prepare('INSERT INTO aircraft_manufacturers
    (name, legal_name, organisation_type, industry, headquarters, founded_year, ceased_year,
     key_people, products, employee_count, website, logo_url, is_active, status, fate)
    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)');

$inserted = 0;
$logoDir = realpath($logoDir) ?: $logoDir;
if (!is_dir($logoDir)) { mkdir($logoDir, 0775, true); }

$nameRowMap = []; // name => original row for phase 2 FK resolution
$idByName = []; // name => inserted id

foreach ($rows as $row) {
    $name = trim($row[$colMap['Name']] ?? '');
    if (!$name) continue;

    $companyType = trim($row[$colMap['Company Type']] ?? '');
    $founded = trim($row[$colMap['Founded']] ?? '');
    $foundedYear = is_numeric($founded) ? (int)$founded : null;
    $hq = trim($row[$colMap['Headquarters']] ?? '');
    $keyPeople = trim($row[$colMap['Key People']] ?? '');
    $products = trim($row[$colMap['Products']] ?? '');
    $employees = trim($row[$colMap['No of Employees']] ?? '');
    $website = trim($row[$colMap['Website']] ?? '');
    $logoUrl = trim($row[$colMap['Logo']] ?? '');
    $industry = trim($row[$colMap['Industry']] ?? '');
    $fate = trim($row[$colMap['Fate']] ?? '');
    $successor = trim($row[$colMap['Successor']] ?? '');
    $defunct = trim($row[$colMap['Defunct']] ?? '');
    $active = trim($row[$colMap['Active']] ?? 'Unknown');

    // Map Active column
    $isActive = match (strtolower($active)) {
        'yes', 'true', '1' => 'Yes',
        'no', 'false', '0' => 'No',
        default => 'Unknown',
    };
    // Map Defunct
    $status = match (strtolower($defunct)) {
        'yes', 'true', '1' => 'Defunct',
        'no', 'false', '0' => 'Active',
        default => $isActive === 'No' ? 'Defunct' : ($isActive === 'Yes' ? 'Active' : 'Unknown'),
    };

    // Download logo
    $localLogo = '';
    if ($logoUrl && preg_match('#https?://#', $logoUrl)) {
        $ext = 'png';
        $urlParts = parse_url($logoUrl);
        $pathParts = pathinfo($urlParts['path'] ?? '');
        if (!empty($pathParts['extension'])) $ext = $pathParts['extension'];
        $safeName = preg_replace('/[^a-zA-Z0-9_-]/', '_', $name);
        $logoFilename = $safeName . '.' . $ext;

        // Skip if file already exists
        if (!file_exists($logoDir . '/' . $logoFilename)) {
            logMsg("  Downloading logo for $name...");
            $ctx = stream_context_create(['http' => ['timeout' => 15, 'user_agent' => 'AnganiData/1.0']]);
            $logoData = @file_get_contents($logoUrl, false, $ctx);
            if ($logoData !== false) {
                // Verify it's an image
                $finfo = finfo_open(FILEINFO_MIME_TYPE);
                $mime = finfo_buffer($finfo, $logoData);
                finfo_close($finfo);
                if (str_starts_with($mime, 'image/')) {
                    // Determine correct extension from mime
                    $extMap = ['image/png' => 'png', 'image/jpeg' => 'jpg', 'image/gif' => 'gif', 'image/svg+xml' => 'svg', 'image/webp' => 'webp'];
                    $correctExt = $extMap[$mime] ?? $ext;
                    if ($correctExt !== $ext) {
                        $logoFilename = $safeName . '.' . $correctExt;
                    }
                    file_put_contents($logoDir . '/' . $logoFilename, $logoData);
                    logMsg("    Saved $logoFilename (" . strlen($logoData) . ' bytes, ' . $mime . ')');
                } else {
                    logMsg("    Skipped (bad mime: $mime)");
                    $logoFilename = '';
                }
            } else {
                logMsg("    Failed to download");
                $logoFilename = '';
            }
        } else {
            logMsg("  Logo exists for $name, skipping download");
        }
        $localLogo = $logoFilename;
    }

    $stmt->execute([
        $name,              // name
        $name,              // legal_name (default to name)
        $companyType ?: null, // organisation_type
        $industry ?: null,    // industry
        $hq ?: null,          // headquarters
        $foundedYear,         // founded_year
        null,                 // ceased_year
        $keyPeople ?: null,   // key_people
        $products ?: null,    // products
        $employees ?: null,   // employee_count
        $website ?: null,     // website
        $localLogo ?: null,   // logo_url
        $isActive,            // is_active
        $status ?: null,      // status
        $fate ?: null,        // fate
    ]);

    $idByName[$name] = (int)$db->lastInsertId();
    $nameRowMap[$name] = [
        'parent' => trim($row[$colMap['Parent'] ?? ''] ?? ''),
        'predecessor' => trim($row[$colMap['Predecessor'] ?? ''] ?? ''),
        'successor' => $successor,
    ];
    $inserted++;
}

logMsg("Inserted $inserted manufacturers");

// --- Phase 2: Resolve FK references ---
logMsg('Phase 2: Resolving parent/predecessor/successor relationships...');
$updateParent = $db->prepare('UPDATE aircraft_manufacturers SET parent_manufacturer_id=? WHERE id=?');
$updatePredecessor = $db->prepare('UPDATE aircraft_manufacturers SET predecessor_manufacturer_id=? WHERE id=?');
$updateSuccessor = $db->prepare('UPDATE aircraft_manufacturers SET successor_manufacturer_id=? WHERE id=?');
$resolved = 0;
$notFound = [];

foreach ($idByName as $name => $id) {
    $refs = $nameRowMap[$name];

    // Parent
    if ($refs['parent']) {
        // Try exact match first, then partial
        $parentId = $idByName[$refs['parent']] ?? null;
        if (!$parentId) {
            foreach ($idByName as $n => $nid) {
                if (str_contains($n, $refs['parent']) || str_contains($refs['parent'], $n)) {
                    $parentId = $nid;
                    break;
                }
            }
        }
        if ($parentId) {
            $updateParent->execute([$parentId, $id]);
            $resolved++;
        } else {
            $notFound[] = "Parent '$refs[parent]' for $name";
        }
    }

    // Predecessor
    if ($refs['predecessor']) {
        $predId = $idByName[$refs['predecessor']] ?? null;
        if (!$predId) {
            foreach ($idByName as $n => $nid) {
                if (str_contains($n, $refs['predecessor']) || str_contains($refs['predecessor'], $n)) {
                    $predId = $nid;
                    break;
                }
            }
        }
        if ($predId) {
            $updatePredecessor->execute([$predId, $id]);
            $resolved++;
        } else {
            $notFound[] = "Predecessor '$refs[predecessor]' for $name";
        }
    }

    // Successor
    if ($refs['successor']) {
        $succId = $idByName[$refs['successor']] ?? null;
        if (!$succId) {
            foreach ($idByName as $n => $nid) {
                if (str_contains($n, $refs['successor']) || str_contains($refs['successor'], $n)) {
                    $succId = $nid;
                    break;
                }
            }
        }
        if ($succId) {
            $updateSuccessor->execute([$succId, $id]);
            $resolved++;
        } else {
            $notFound[] = "Successor '$refs[successor]' for $name";
        }
    }
}

logMsg("Resolved $resolved FK references");
if ($notFound) {
    logMsg('Unresolved (' . count($notFound) . '):');
    foreach (array_slice($notFound, 0, 20) as $nf) logMsg("  - $nf");
    if (count($notFound) > 20) logMsg('  ... and ' . (count($notFound) - 20) . ' more');
}

// --- Summary ---
$count = $db->query('SELECT COUNT(*) FROM aircraft_manufacturers')->fetchColumn();
$logoCount = $db->query("SELECT COUNT(*) FROM aircraft_manufacturers WHERE logo_url IS NOT NULL AND logo_url!=''")->fetchColumn();
$activeCount = $db->query("SELECT COUNT(*) FROM aircraft_manufacturers WHERE is_active='Yes'")->fetchColumn();
logMsg("Done. Total: $count, With logos: $logoCount, Active: $activeCount");
