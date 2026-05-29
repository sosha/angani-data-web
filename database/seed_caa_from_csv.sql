-- seed_caa_from_csv.sql
-- Run after creating the CSV import table:
-- LOAD DATA LOCAL INFILE 'path/to/caa.csv' INTO TABLE _caa_import FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- First create a staging table matching the CSV columns
DROP TABLE IF EXISTS _caa_import;
CREATE TABLE _caa_import (
    country VARCHAR(190),
    caa_name VARCHAR(255),
    caa_website TEXT,
    aoc_holders_list TEXT,
    aircraft_registry TEXT,
    contacts TEXT,
    icao_caa_link TEXT,
    wikipedia_url TEXT,
    verification_notes TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- After loading CSV data, run this to merge into regulatory_authorities:
-- (Note: you'll need to adjust country_code matching based on your CSV's country names)

INSERT INTO regulatory_authorities (country_code, name, abbreviation, website, aoc_holders_list, aircraft_registry, contacts, icao_caa_link, wikipedia_url, verification_notes)
SELECT
    c.iso_alpha_2,
    TRIM(i.caa_name),
    NULL, -- abbreviation extracted manually
    TRIM(i.caa_website),
    TRIM(i.aoc_holders_list),
    TRIM(i.aircraft_registry),
    TRIM(i.contacts),
    TRIM(i.icao_caa_link),
    TRIM(i.wikipedia_url),
    TRIM(i.verification_notes)
FROM _caa_import i
LEFT JOIN countries c ON (c.name_common LIKE CONCAT('%', i.country, '%') OR c.name_official LIKE CONCAT('%', i.country, '%') OR c.iso_alpha_2 = i.country)
ON DUPLICATE KEY UPDATE
    website = VALUES(website),
    aoc_holders_list = VALUES(aoc_holders_list),
    aircraft_registry = VALUES(aircraft_registry),
    contacts = VALUES(contacts),
    icao_caa_link = VALUES(icao_caa_link),
    wikipedia_url = VALUES(wikipedia_url),
    verification_notes = VALUES(verification_notes);

-- Clean up
DROP TABLE IF EXISTS _caa_import;
