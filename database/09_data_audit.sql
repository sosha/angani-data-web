-- 09_data_audit.sql
-- Data provenance & audit trail tables
-- Every CUD operation on data tables must write to data_audit_log

CREATE TABLE IF NOT EXISTS data_licenses (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    url VARCHAR(500) DEFAULT NULL,
    description TEXT DEFAULT NULL,
    allows_commercial_use TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS data_audit_log (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(190) NOT NULL,
    record_id VARCHAR(190) DEFAULT NULL,
    action ENUM('INSERT','UPDATE','DELETE','TRUNCATE','IMPORT') NOT NULL,
    collection_method TEXT DEFAULT NULL COMMENT 'How this data was collected/procured',
    old_values JSON DEFAULT NULL,
    new_values JSON DEFAULT NULL,
    changed_by VARCHAR(190) DEFAULT NULL,
    notes TEXT DEFAULT NULL,
    license_id INT UNSIGNED DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_table_name (table_name),
    INDEX idx_record_id (record_id),
    INDEX idx_action (action),
    INDEX idx_license (license_id),
    INDEX idx_created (created_at),
    KEY idx_table_created (table_name, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS data_table_provenance (
    table_name VARCHAR(190) PRIMARY KEY,
    collection_method TEXT DEFAULT NULL COMMENT 'How the data for this table was originally collected',
    primary_source_url VARCHAR(500) DEFAULT NULL,
    primary_license_id INT UNSIGNED DEFAULT NULL,
    notes TEXT DEFAULT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(190) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed common licenses
INSERT INTO data_licenses (name, url, description, allows_commercial_use) VALUES
('Public Domain', 'https://creativecommons.org/publicdomain/', 'No copyright restrictions. Free for any use.', 1),
('CC0 1.0 Universal', 'https://creativecommons.org/publicdomain/zero/1.0/', 'Creative Commons Zero — no rights reserved.', 1),
('CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0/', 'Creative Commons Attribution 4.0 International — free to share and adapt with attribution.', 1),
('CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0/', 'Creative Commons Attribution-ShareAlike 4.0 — share adaptations under same terms.', 1),
('CC BY-NC 4.0', 'https://creativecommons.org/licenses/by-nc/4.0/', 'Creative Commons Attribution-NonCommercial 4.0 — non-commercial use only.', 0),
('ODbL 1.0', 'https://opendatacommons.org/licenses/odbl/', 'Open Database License — share and adapt with attribution and share-alike.', 1),
('ODC-BY 1.0', 'https://opendatacommons.org/licenses/by/', 'Open Data Commons Attribution License.', 1),
('OurAirports (Public Domain)', 'https://ourairports.com/data/', 'OurAirports airport/frequency/navaid data. Dedicated to the public domain.', 1),
('OpenTravelData (CC BY 4.0)', 'https://opentraveldata.com/', 'OpenTravelData airline and aircraft type data under CC BY 4.0.', 1),
('Wikipedia (CC BY-SA 4.0)', 'https://en.wikipedia.org/', 'Wikipedia content used under CC BY-SA 4.0.', 1),
('World Bank Data (CC BY 4.0)', 'https://data.worldbank.org/', 'World Bank open data under CC BY 4.0.', 1),
('Proprietary — Commercial', NULL, 'Data obtained under a commercial license agreement.', 0)
ON DUPLICATE KEY UPDATE name=name;

-- Seed table-level provenance for known sources
INSERT INTO data_table_provenance (table_name, collection_method, primary_source_url, primary_license_id, notes) VALUES
('countries', 'Sourced from OurAirports country data and augmented with UN region classifications.', 'https://ourairports.com/data/', (SELECT id FROM data_licenses WHERE name='OurAirports (Public Domain)'), 'Core reference table used by all other modules.'),
('airlines', 'Started with Wikipedia List of Airline Codes to fill country_code. Primary ICAO/IATA/callsign data sourced from OpenTravelData (OPTD) CC BY 4.0, replacing legacy OpenFlights data (ODbL with commercial restrictions).', 'https://opentraveldata.com/', (SELECT id FROM data_licenses WHERE name='OpenTravelData (CC BY 4.0)'), '974 airlines reviewed & published from OPTD. Country codes backfilled via Wikipedia.'),
('airports', 'Sourced from OurAirports airport dataset. Includes ident, ICAO, IATA, name, location, elevation, timezone, and coordinates.', 'https://ourairports.com/data/', (SELECT id FROM data_licenses WHERE name='OurAirports (Public Domain)'), '~72,000 records. Public domain — no commercial restrictions.'),
('airport_frequencies', 'Sourced from OurAirports frequency dataset. Includes type, frequency, and airport association.', 'https://ourairports.com/data/', (SELECT id FROM data_licenses WHERE name='OurAirports (Public Domain)'), '~30,000 records. Deduped with UNIQUE(airport_ident, type, frequency_mhz).'),
('navaids', 'Sourced from OurAirports navaid dataset. Includes ident, type, frequency, and location data.', 'https://ourairports.com/data/', (SELECT id FROM data_licenses WHERE name='OurAirports (Public Domain)'), '~11,000 records. Deduped with UNIQUE(ident, type, frequency_khz).'),
('aircraft_types', 'Sourced from OpenTravelData (OPTD) aircraft type data under CC BY 4.0, replacing legacy OurAirports data.', 'https://opentraveldata.com/', (SELECT id FROM data_licenses WHERE name='OpenTravelData (CC BY 4.0)'), '~380 records reviewed & published. Includes ICAO code, IATA code, manufacturer, model.')
ON DUPLICATE KEY UPDATE table_name=table_name;
