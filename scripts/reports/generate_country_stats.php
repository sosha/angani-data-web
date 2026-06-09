<?php
// generate_country_stats.php
// Pre-computes country air transport statistics from existing data
// Run via: php scripts/reports/generate_country_stats.php

require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../includes/functions.php';

echo "Country Air Transport Stats Generator\n";
echo "======================================\n\n";

$countries = rows('SELECT iso_alpha_2, name_common FROM countries');
$total = count($countries);
$done = 0;

foreach ($countries as $c) {
    $cc = $c['iso_alpha_2'];

    // International airports: type = 'large_airport' or 'medium_airport'
    $intl = (int)scalar("SELECT COUNT(*) FROM airports WHERE iso_country=? AND type IN ('large_airport','medium_airport')", [$cc]);

    // Domestic airports: type = 'small_airport' or 'heliport' or 'seaplane_base' or 'closed'
    $dom = (int)scalar("SELECT COUNT(*) FROM airports WHERE iso_country=? AND type IN ('small_airport','heliport','seaplane_base')", [$cc]);

    // Total airlines based in this country
    $als = (int)scalar("SELECT COUNT(*) FROM airlines WHERE country_code=?", [$cc]);

    // Airlines with international services: status_bucket='active' airlines
    $alsIntl = (int)scalar("SELECT COUNT(*) FROM airlines WHERE country_code=? AND status_bucket='active'", [$cc]);
    $alsActive = (int)scalar("SELECT COUNT(*) FROM airlines WHERE country_code=? AND status_bucket='active'", [$cc]);
    $alsDefunct = (int)scalar("SELECT COUNT(*) FROM airlines WHERE country_code=? AND status_bucket='defunct'", [$cc]);

    exec_sql(
        'INSERT INTO country_air_transport_stats (iso_alpha_2, international_airports, domestic_airports, airlines, airlines_active, airlines_defunct, airlines_with_international) VALUES (?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE international_airports=VALUES(international_airports), domestic_airports=VALUES(domestic_airports), airlines=VALUES(airlines), airlines_active=VALUES(airlines_active), airlines_defunct=VALUES(airlines_defunct), airlines_with_international=VALUES(airlines_with_international)',
        [$cc, $intl, $dom, $als, $alsActive, $alsDefunct, $alsIntl]
    );

    $done++;
    if ($done % 20 === 0) echo "  Processed $done / $total countries...\n";
}

// Mark report as up-to-date
exec_sql("UPDATE report_dependencies SET needs_update=0, last_run_at=NOW() WHERE report_key='country_air_transport_stats'");

echo "\nDone. Processed $done countries.\n";
echo "International airports, domestic airports, airlines, and airlines_with_international computed.\n";
echo "Foreign airline operations skipped — pending destinations data.\n";
