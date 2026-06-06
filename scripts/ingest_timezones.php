<?php
declare(strict_types=1);

require __DIR__ . '/../includes/db.php';

$inputFile = $argv[1] ?? __DIR__ . '/../data/timezones.txt';
if (!file_exists($inputFile)) {
    echo "File not found: $inputFile\n";
    exit(1);
}

$lines = file($inputFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
if ($lines === false) {
    echo "Failed to read $inputFile\n";
    exit(1);
}

$timezones = [];
$currentContinent = '';

foreach ($lines as $line) {
    $line = trim($line);
    if ($line === '') continue;

    // Continent/Region headers don't contain parentheses
    if (!str_contains($line, '(') && !str_contains($line, '/')) {
        $currentContinent = rtrim($line, '/');
        continue;
    }

    // Parse: "Timezone/Name (UTC+offset)"
    if (preg_match('/^(.+?)\s+\(UTC([^)]+)\)\s*(.*)$/', $line, $m)) {
        $timezoneName = trim($m[1]);
        $utcPart = trim($m[2]);
        $extra = trim($m[3]);

        // Normalize the UTC offset: replace en-dash/minus with standard minus
        $utcPart = str_replace(['–', '−', '—'], '-', $utcPart);

        // Build utc_offset string
        $utcOffset = 'UTC' . $utcPart;

        // Check for DST
        $hasDst = false;
        $dstInfo = null;

        // Parse patterns like "UTC−5 / UTC−4 DST" or "UTC+0 / UTC+1 DST"
        if (preg_match('/^(.*?)\s*\/\s*UTC([^)]+?)\s*DST\s*$/i', $utcPart, $dm)) {
            $hasDst = true;
            $dstInfo = $utcOffset . ' / UTC' . trim($dm[2]) . ' DST';
            $utcOffset = 'UTC' . trim($dm[1]);
        } elseif (preg_match('/\b(DST|Daylight\s+Saving)\b/i', $extra)) {
            $hasDst = true;
            $dstInfo = $utcOffset;
        } elseif (stripos($utcPart, 'dst') !== false) {
            $hasDst = true;
            $dstInfo = $utcOffset;
            $utcOffset = str_ireplace(' dst', '', $utcOffset);
        } elseif (stripos($utcPart, 'no DST') !== false) {
            $utcOffset = str_ireplace(', no DST', '', $utcOffset);
        }

        $timezones[] = [
            'continent' => $currentContinent,
            'timezone_name' => $timezoneName,
            'utc_offset' => $utcOffset,
            'dst_info' => $dstInfo,
            'has_dst' => $hasDst ? 1 : 0,
        ];
    }
}

echo "Parsed " . count($timezones) . " timezones\n";

// Truncate and insert
db()->exec('TRUNCATE TABLE ref_timezones');
$stmt = db()->prepare(
    'INSERT INTO ref_timezones (continent, timezone_name, utc_offset, dst_info, has_dst) VALUES (?,?,?,?,?)'
);

$inserted = 0;
foreach ($timezones as $tz) {
    $stmt->execute([
        $tz['continent'],
        $tz['timezone_name'],
        $tz['utc_offset'],
        $tz['dst_info'],
        $tz['has_dst'],
    ]);
    $inserted++;
}

echo "Inserted $inserted timezones\n";
