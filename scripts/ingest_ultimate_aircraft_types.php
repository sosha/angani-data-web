<?php
$dbPass = getenv('ANGANI_DB_PASS');
if (!$dbPass) { fwrite(STDERR, "ERROR: ANGANI_DB_PASS not set.\n"); exit(1); }

$csvPath = $argv[1] ?? null;
if (!$csvPath) { fwrite(STDERR, "Usage: php ingest_ultimate_aircraft_types.php <path/to/csv>\n"); exit(1); }
if (!file_exists($csvPath)) { fwrite(STDERR, "ERROR: CSV not found at $csvPath\n"); exit(1); }

$db = new PDO('mysql:host=localhost;dbname=angani_data;charset=utf8mb4', 'root', $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

function val($row, $key) { $v = $row[$key] ?? ''; return ($v === '' || $v === null) ? null : $v; }
function nval($row, $key) { $v = val($row, $key); return ($v !== null && is_numeric($v)) ? $v : null; }
function inval($row, $key) { $v = nval($row, $key); return $v !== null ? (int)$v : null; }

$handle = fopen($csvPath, 'r');
if (!$handle) { fwrite(STDERR, "ERROR: Cannot open CSV\n"); exit(1); }

$headers = fgetcsv($handle);
if (!$headers) { fwrite(STDERR, "ERROR: Empty CSV\n"); exit(1); }
$hdr = array_flip($headers);

$rows = [];
while (($data = fgetcsv($handle)) !== false) {
    $row = [];
    foreach ($headers as $i => $name) {
        $row[$name] = $data[$i] ?? '';
    }
    $rows[] = $row;
}
fclose($handle);

echo "Loaded " . count($rows) . " rows from CSV\n\n";

$counts = ['aircraft_types'=>0, 'operational_performance'=>0, 'technical_specs'=>0,
           'cabin_payload'=>0, 'economic_data'=>0, 'engine_data'=>0,
           'environmental_data'=>0, 'manufacturer_support'=>0, 'runway_requirements'=>0];

foreach ($rows as $r) {
    $icao = val($r, 'enhanced_icao_code') ?: val($r, 'enhanced_icao_code');
    if (!$icao) continue;

    // --- aircraft_types ---
    $stmt = $db->prepare(
        "INSERT INTO aircraft_types (icao_code, iata_code, manufacturer, model, type, engine_type, engine_count, wtc, created_at, updated_at)
         VALUES (?,?,?,?,?,?,?,?, NOW(), NOW())
         ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), manufacturer=VALUES(manufacturer), model=VALUES(model),
           type=VALUES(type), engine_type=VALUES(engine_type), engine_count=VALUES(engine_count), wtc=VALUES(wtc), updated_at=NOW()"
    );
    $stmt->execute([
        $icao,
        val($r, 'enhanced_iata_code'),
        val($r, 'enhanced_manufacturer') ?: val($r, 'Make'),
        val($r, 'enhanced_model') ?: val($r, 'Model'),
        val($r, 'enhanced_type'),
        val($r, 'enhanced_engine_type'),
        inval($r, 'enhanced_engine_count'),
        val($r, 'enhanced_wtc'),
    ]);
    if ($stmt->rowCount()) $counts['aircraft_types']++;

    // --- aircraft_type_operational_performance ---
    $maxRange = nval($r, 'enhanced_max_range_nm') ?: nval($r, 'Max Range nm');
    if ($maxRange || val($r, 'enhanced_cruise_speed_mach') || val($r, 'enhanced_max_speed') || nval($r, 'enhanced_service_ceiling_ft')) {
        $stmt = $db->prepare(
            "INSERT INTO aircraft_type_operational_performance (icao_code, iata_code, max_range_nm, service_ceiling_ft, cruise_speed_mach, max_speed)
             VALUES (?,?,?,?,?,?)
             ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), max_range_nm=VALUES(max_range_nm),
               service_ceiling_ft=VALUES(service_ceiling_ft), cruise_speed_mach=VALUES(cruise_speed_mach), max_speed=VALUES(max_speed)"
        );
        $stmt->execute([
            $icao,
            val($r, 'enhanced_iata_code'),
            $maxRange,
            inval($r, 'enhanced_service_ceiling_ft') ?: inval($r, 'enhanced_ceiling_ft'),
            val($r, 'enhanced_cruise_speed_mach'),
            val($r, 'enhanced_max_speed'),
        ]);
        if ($stmt->rowCount()) $counts['operational_performance']++;
    }

    // --- aircraft_type_technical_specs ---
    if (nval($r, 'enhanced_mtow_kg') || nval($r, 'enhanced_mzfw_kg') || nval($r, 'enhanced_empty_weight_kg') ||
        nval($r, 'enhanced_wingspan_m') || nval($r, 'enhanced_length_m') || nval($r, 'enhanced_height_m')) {
        $stmt = $db->prepare(
            "INSERT INTO aircraft_type_technical_specs (icao_code, iata_code, mtow_kg, mzfw_kg, empty_weight_kg, wingspan_m, length_m, height_m)
             VALUES (?,?,?,?,?,?,?,?)
             ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), mtow_kg=VALUES(mtow_kg), mzfw_kg=VALUES(mzfw_kg),
               empty_weight_kg=VALUES(empty_weight_kg), wingspan_m=VALUES(wingspan_m), length_m=VALUES(length_m), height_m=VALUES(height_m)"
        );
        $stmt->execute([
            $icao,
            val($r, 'enhanced_iata_code'),
            nval($r, 'enhanced_mtow_kg'),
            nval($r, 'enhanced_mzfw_kg'),
            nval($r, 'enhanced_empty_weight_kg'),
            nval($r, 'enhanced_wingspan_m'),
            nval($r, 'enhanced_length_m'),
            nval($r, 'enhanced_height_m'),
        ]);
        if ($stmt->rowCount()) $counts['technical_specs']++;
    }

    // --- aircraft_type_cabin_payload ---
    if (nval($r, 'enhanced_typical_c_seats') || nval($r, 'enhanced_typical_y_seats') || nval($r, 'enhanced_max_capacity') ||
        nval($r, 'enhanced_cargo_volume_m3') || nval($r, 'enhanced_max_payload_kg')) {
        $stmt = $db->prepare(
            "INSERT INTO aircraft_type_cabin_payload (icao_code, iata_code, typical_c_seats, typical_y_seats, max_capacity, cargo_volume_m3, max_payload_kg)
             VALUES (?,?,?,?,?,?,?)
             ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), typical_c_seats=VALUES(typical_c_seats),
               typical_y_seats=VALUES(typical_y_seats), max_capacity=VALUES(max_capacity),
               cargo_volume_m3=VALUES(cargo_volume_m3), max_payload_kg=VALUES(max_payload_kg)"
        );
        $stmt->execute([
            $icao,
            val($r, 'enhanced_iata_code'),
            inval($r, 'enhanced_typical_c_seats'),
            inval($r, 'enhanced_typical_y_seats'),
            inval($r, 'enhanced_max_capacity') ?: inval($r, 'Capacity'),
            nval($r, 'enhanced_cargo_volume_m3'),
            nval($r, 'enhanced_max_payload_kg'),
        ]);
        if ($stmt->rowCount()) $counts['cabin_payload']++;
    }

    // --- aircraft_type_economic_data ---
    if (nval($r, 'enhanced_list_price_usd') || nval($r, 'enhanced_op_cost_per_hour') || nval($r, 'enhanced_lease_rate_monthly') ||
        val($r, 'enhanced_residual_value_trend') || nval($r, 'Purchase Price')) {
        $price = nval($r, 'enhanced_list_price_usd') ?: nval($r, 'Purchase Price');
        $stmt = $db->prepare(
            "INSERT INTO aircraft_type_economic_data (icao_code, iata_code, list_price_usd, op_cost_per_hour, lease_rate_monthly, residual_value_trend)
             VALUES (?,?,?,?,?,?)
             ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), list_price_usd=VALUES(list_price_usd),
               op_cost_per_hour=VALUES(op_cost_per_hour), lease_rate_monthly=VALUES(lease_rate_monthly),
               residual_value_trend=VALUES(residual_value_trend)"
        );
        $stmt->execute([
            $icao,
            val($r, 'enhanced_iata_code'),
            $price,
            nval($r, 'enhanced_op_cost_per_hour'),
            nval($r, 'enhanced_lease_rate_monthly'),
            val($r, 'enhanced_residual_value_trend'),
        ]);
        if ($stmt->rowCount()) $counts['economic_data']++;
    }

    // --- aircraft_type_engine_data ---
    if (val($r, 'enhanced_engine_type') || nval($r, 'enhanced_engine_count') || nval($r, 'enhanced_thrust_per_engine_kn') ||
        val($r, 'enhanced_saf_compatible') || val($r, 'enhanced_powerplant')) {
        $stmt = $db->prepare(
            "INSERT INTO aircraft_type_engine_data (icao_code, iata_code, engine_variants, engine_type, engine_count, thrust_per_engine_kn, saf_compatible)
             VALUES (?,?,?,?,?,?,?)
             ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), engine_variants=VALUES(engine_variants),
               engine_type=VALUES(engine_type), engine_count=VALUES(engine_count),
               thrust_per_engine_kn=VALUES(thrust_per_engine_kn), saf_compatible=VALUES(saf_compatible)"
        );
        $stmt->execute([
            $icao,
            val($r, 'enhanced_iata_code'),
            val($r, 'enhanced_powerplant'),
            val($r, 'enhanced_engine_type'),
            inval($r, 'enhanced_engine_count'),
            nval($r, 'enhanced_thrust_per_engine_kn'),
            val($r, 'enhanced_saf_compatible'),
        ]);
        if ($stmt->rowCount()) $counts['engine_data']++;
    }

    // --- aircraft_type_environmental_data ---
    if (val($r, 'enhanced_carbon_intensity') || val($r, 'enhanced_noise_chapter') || val($r, 'enhanced_fuel_type')) {
        $stmt = $db->prepare(
            "INSERT INTO aircraft_type_environmental_data (icao_code, iata_code, carbon_intensity, noise_chapter, fuel_type)
             VALUES (?,?,?,?,?)
             ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), carbon_intensity=VALUES(carbon_intensity),
               noise_chapter=VALUES(noise_chapter), fuel_type=VALUES(fuel_type)"
        );
        $stmt->execute([
            $icao,
            val($r, 'enhanced_iata_code'),
            val($r, 'enhanced_carbon_intensity'),
            val($r, 'enhanced_noise_chapter'),
            val($r, 'enhanced_fuel_type'),
        ]);
        if ($stmt->rowCount()) $counts['environmental_data']++;
    }

    // --- aircraft_type_manufacturer_support ---
    if (val($r, 'enhanced_production_start') || val($r, 'enhanced_production_end') || nval($r, 'enhanced_total_built') ||
        val($r, 'enhanced_mro_availability')) {
        $stmt = $db->prepare(
            "INSERT INTO aircraft_type_manufacturer_support (icao_code, iata_code, production_start, production_end, total_built, mro_availability)
             VALUES (?,?,?,?,?,?)
             ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), production_start=VALUES(production_start),
               production_end=VALUES(production_end), total_built=VALUES(total_built), mro_availability=VALUES(mro_availability)"
        );
        $stmt->execute([
            $icao,
            val($r, 'enhanced_iata_code'),
            val($r, 'enhanced_production_start'),
            val($r, 'enhanced_production_end'),
            inval($r, 'enhanced_total_built'),
            val($r, 'enhanced_mro_availability'),
        ]);
        if ($stmt->rowCount()) $counts['manufacturer_support']++;
    }

    // --- aircraft_type_runway_requirements ---
    if (nval($r, 'enhanced_min_takeoff_length_ft') || nval($r, 'enhanced_min_landing_length_ft') || val($r, 'enhanced_surface_compatibility')) {
        $stmt = $db->prepare(
            "INSERT INTO aircraft_type_runway_requirements (icao_code, iata_code, min_takeoff_length_ft, min_landing_length_ft, surface_compatibility)
             VALUES (?,?,?,?,?)
             ON DUPLICATE KEY UPDATE iata_code=VALUES(iata_code), min_takeoff_length_ft=VALUES(min_takeoff_length_ft),
               min_landing_length_ft=VALUES(min_landing_length_ft), surface_compatibility=VALUES(surface_compatibility)"
        );
        $stmt->execute([
            $icao,
            val($r, 'enhanced_iata_code'),
            inval($r, 'enhanced_min_takeoff_length_ft'),
            inval($r, 'enhanced_min_landing_length_ft'),
            val($r, 'enhanced_surface_compatibility'),
        ]);
        if ($stmt->rowCount()) $counts['runway_requirements']++;
    }
}

echo "\n--- Summary ---\n";
foreach ($counts as $table => $cnt) {
    echo str_pad($table, 30, ' ', STR_PAD_LEFT) . ": $cnt\n";
}
echo "\nDone.\n";
