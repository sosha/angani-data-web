<?php
// populate_country_time_series.php
// Fetches GDP, population, air traffic data from World Bank API
// Run via: cd /home/ubuntu/angani-data-web && ANGANI_DB_PASS=rootpassword php scripts/populate_country_time_series.php

require_once __DIR__ . '/../includes/db.php';

echo "Country Time Series Populator (World Bank)\n";
echo "===========================================\n\n";

$countries = rows('SELECT iso_alpha_2, iso_alpha_3, name_common FROM countries WHERE iso_alpha_2 IS NOT NULL ORDER BY name_common');

// Indicators to fetch
$indicators = [
    'NY.GDP.MKTP.CD'    => 'gdp_usd',         // GDP (current US$)
    'SP.POP.TOTL'       => 'population',       // Population, total
    'IS.AIR.PSGR'       => 'international_traffic_passengers',  // Air transport, passengers carried
    'IS.AIR.GOOD.MT.K1' => 'international_cargo_tonnes',        // Air transport, freight (million ton-km)
];

$total = count($countries);
$done = 0;
$inserted = 0;

foreach ($countries as $c) {
    $cc = $c['iso_alpha_2'];
    $c3 = $c['iso_alpha_3'];
    $name = $c['name_common'];

    // Build year-by-year data from all indicators
    $yearData = [];

    foreach ($indicators as $indicator => $column) {
        $url = "http://api.worldbank.org/v2/country/$cc/indicator/$indicator?format=json&per_page=50";
        $ctx = stream_context_create([
            'http' => [
                'timeout' => 15,
                'method' => 'GET',
                'header' => "User-Agent: AnganiData/1.0 (aviation intelligence; webmaster@angani.co.uk)\r\nAccept: application/json\r\n",
            ],
        ]);
        $json = @file_get_contents($url, false, $ctx);
        if ($json === false) continue;

        $data = json_decode($json, true);
        if (!is_array($data) || count($data) < 2 || !is_array($data[1])) continue;

        foreach ($data[1] as $entry) {
            if (empty($entry['value']) || !isset($entry['date'])) continue;
            $year = (int)$entry['date'];
            $value = $entry['value'];
            if ($year < 1990 || $year > (int)date('Y')) continue;

            if (!isset($yearData[$year])) {
                $yearData[$year] = ['iso_alpha_2' => $cc, 'year' => $year];
            }
            if ($indicator === 'IS.AIR.GOOD.MT.K1') {
                $value = (float)$value * 1000;
            }
            $yearData[$year][$column] = is_numeric($value) ? $value : null;
        }
    }

    if (empty($yearData)) {
        // Try ISO alpha-3 as fallback
        foreach ($indicators as $indicator => $column) {
            $url = "http://api.worldbank.org/v2/country/$c3/indicator/$indicator?format=json&per_page=50";
            $ctx = stream_context_create([
                'http' => [
                    'timeout' => 15,
                    'method' => 'GET',
                    'header' => "User-Agent: AnganiData/1.0 (aviation intelligence; webmaster@angani.co.uk)\r\nAccept: application/json\r\n",
                ],
            ]);
            $json = @file_get_contents($url, false, $ctx);
            if ($json === false) continue;
            $data = json_decode($json, true);
            if (!is_array($data) || count($data) < 2 || !is_array($data[1])) continue;
            foreach ($data[1] as $entry) {
                if (empty($entry['value']) || !isset($entry['date'])) continue;
                $year = (int)$entry['date'];
                $value = $entry['value'];
                if ($year < 1990 || $year > (int)date('Y')) continue;
                if (!isset($yearData[$year])) {
                    $yearData[$year] = ['iso_alpha_2' => $cc, 'year' => $year];
                }
                if ($indicator === 'IS.AIR.GOOD.MT.K1') {
                    $value = (float)$value * 1000;
                }
                $yearData[$year][$column] = is_numeric($value) ? $value : null;
            }
        }
    }

    foreach ($yearData as $yd) {
        try {
            exec_sql(
                "INSERT INTO country_time_series (iso_alpha_2, year, gdp_usd, population, international_traffic_passengers, international_cargo_tonnes) VALUES (?,?,?,?,?,?) ON DUPLICATE KEY UPDATE gdp_usd=VALUES(gdp_usd), population=VALUES(population), international_traffic_passengers=VALUES(international_traffic_passengers), international_cargo_tonnes=VALUES(international_cargo_tonnes)",
                [$yd['iso_alpha_2'], $yd['year'], $yd['gdp_usd'] ?? null, $yd['population'] ?? null, $yd['international_traffic_passengers'] ?? null, $yd['international_cargo_tonnes'] ?? null]
            );
            $inserted++;
        } catch (Throwable $e) {
            // skip errors
        }
    }

    $done++;
    if ($done % 20 === 0) echo "  Processed $done / $total countries ($inserted time series rows so far)...\n";

    usleep(200000);
}

exec_sql("UPDATE report_dependencies SET needs_update=0, last_run_at=NOW() WHERE report_key='country_time_series'");

echo "\nDone. Processed $done countries.\n";
echo "Inserted/updated $inserted time series rows.\n";
