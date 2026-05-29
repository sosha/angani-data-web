<?php
// populate_country_descriptions.php
// Fetches country descriptions from Wikipedia (air-transport-biased)
// Run via: cd /home/ubuntu/angani-data-web && ANGANI_DB_PASS=rootpassword php scripts/populate_country_descriptions.php

require_once __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/functions.php';

echo "Country Description Populator (Wikipedia)\n";
echo "==========================================\n\n";

// Only re-fetch countries with short or missing descriptions
$countries = rows('SELECT iso_alpha_2, name_common FROM countries WHERE description IS NULL OR LENGTH(description) < 100 ORDER BY name_common');
$total = count($countries);
$done = 0;
$fetched = 0;
$skipped = 0;

foreach ($countries as $c) {
    $cc = $c['iso_alpha_2'];
    $name = $c['name_common'];

    // Priority 1: Main country article, extract aviation paragraphs
    $text = fetch_wikipedia_extract($name, true);

    // Priority 2: If too short, try Transport in {Country}
    if ($text === null || strlen($text) < 100) {
        $text2 = fetch_wikipedia_extract('Transport in ' . $name, false);
        if ($text2 !== null && strlen($text2) >= 50) {
            $text = $text2;
        }
    }

    // Priority 3: Use main article text even without aviation bias
    if ($text === null || strlen($text) < 100) {
        $text = fetch_wikipedia_extract($name, false);
    }

    if ($text !== null && strlen(trim($text)) >= 20) {
        if (mb_strlen($text) > 2000) {
            $text = mb_substr($text, 0, 1997) . '...';
        }
        exec_sql('UPDATE countries SET description=? WHERE iso_alpha_2=?', [$text, $cc]);
        $fetched++;
    } else {
        $skipped++;
    }

    $done++;
    if ($done % 20 === 0) echo "  Processed $done / $total (fetched: $fetched, skipped: $skipped)...\n";

    usleep(500000);
}

echo "\nDone. Processed $done countries.\n";
echo "Fetched: $fetched, Skipped: $skipped\n";

function fetch_wikipedia_extract(string $title, bool $aviationBias = true): ?string {
    $api = 'https://en.wikipedia.org/api/rest_v1/page/summary/' . rawurlencode(str_replace(' ', '_', $title));
    $ctx = stream_context_create([
        'http' => [
            'timeout' => 15,
            'method' => 'GET',
            'header' => "User-Agent: AnganiData/1.0 (aviation intelligence; webmaster@angani.co.uk)\r\nAccept: application/json\r\n",
        ],
    ]);
    $json = @file_get_contents($api, false, $ctx);
    if ($json === false) return null;

    $data = json_decode($json, true);
    if (!$data) return null;
    if (isset($data['title']) && ($data['title'] === 'Not found.' || strpos($data['title'] ?? '', '(page does not exist)') !== false)) return null;
    if (isset($data['type']) && $data['type'] === 'disambiguation') return null;
    if (empty($data['extract'])) return null;

    $extract = $data['extract'];
    $paras = array_values(array_filter(array_map('trim', explode("\n", $extract))));

    if ($aviationBias) {
        $aviation = [];
        foreach ($paras as $p) {
            if (preg_match('/\b(airport|airline|aviation|air\s*transport|carrier|airspace|ICAO|IATA|runway|terminal|flight|air\s*cargo|airstrip|heliport|aerodrome)\b/i', $p)) {
                $aviation[] = $p;
            }
        }
        if (!empty($aviation)) {
            return implode("\n\n", $aviation);
        }
        // No aviation paras found — return first 2 paragraphs as fallback
        return implode("\n\n", array_slice($paras, 0, 2));
    }

    return implode("\n\n", array_slice($paras, 0, 3));
}
