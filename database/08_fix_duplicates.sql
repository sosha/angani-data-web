-- Remove duplicate rows in airport_frequencies, keeping the lowest id per natural key
DELETE t1 FROM airport_frequencies t1
INNER JOIN airport_frequencies t2
WHERE t1.id > t2.id
  AND t1.airport_ident = t2.airport_ident
  AND t1.`type` = t2.`type`
  AND t1.frequency_mhz = t2.frequency_mhz;

ALTER TABLE airport_frequencies ADD UNIQUE KEY uq_airport_freq (airport_ident, `type`, frequency_mhz);

-- Remove duplicate rows in navaids, keeping the lowest id per (ident, type, frequency_khz)
DELETE t1 FROM navaids t1
INNER JOIN navaids t2
WHERE t1.id > t2.id
  AND t1.ident = t2.ident
  AND t1.`type` = t2.`type`
  AND t1.frequency_khz = t2.frequency_khz;

ALTER TABLE navaids ADD UNIQUE KEY uq_navaid_ident_type_freq (ident, `type`, frequency_khz);

-- Add UNIQUE KEY to airlines (if we get data later)
ALTER TABLE airlines ADD UNIQUE KEY uq_airline_icao (icao_code);

-- Add UNIQUE KEY to aircraft_types
ALTER TABLE aircraft_types ADD UNIQUE KEY uq_aircraft_type_icao (icao_code);
