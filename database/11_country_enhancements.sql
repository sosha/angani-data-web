-- 11_country_enhancements.sql
-- Country enhancements: flag, description, stats, time series, CAA columns

-- 1. Add columns to V2 countries table
SET @fc := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='countries' AND column_name='flag');
SET @sql := IF(@fc=0, 'ALTER TABLE countries ADD COLUMN flag TEXT DEFAULT NULL AFTER un_region', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @dc := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='countries' AND column_name='description');
SET @sql2 := IF(@dc=0, 'ALTER TABLE countries ADD COLUMN description TEXT DEFAULT NULL AFTER flag', 'SELECT 1');
PREPARE stmt2 FROM @sql2; EXECUTE stmt2; DEALLOCATE PREPARE stmt2;

-- 2. Populate flag column with default path pattern
UPDATE countries SET flag = CONCAT('assets/country_flag_icons/', LOWER(iso_alpha_2), '.svg') WHERE flag IS NULL AND iso_alpha_2 IS NOT NULL;

-- 3. Populate name_official from Wikipedia-style (use name_common as fallback)
UPDATE countries SET name_official = name_common WHERE name_official IS NULL OR name_official = '';

-- 4. Create country_air_transport_stats table
CREATE TABLE IF NOT EXISTS country_air_transport_stats (
    iso_alpha_2 VARCHAR(6) NOT NULL PRIMARY KEY,
    international_airports INT DEFAULT 0,
    domestic_airports INT DEFAULT 0,
    airlines INT DEFAULT 0,
    airlines_active INT DEFAULT 0,
    airlines_defunct INT DEFAULT 0,
    airlines_with_international INT DEFAULT 0,
    foreign_airline_operations INT DEFAULT NULL COMMENT 'Pending — needs destinations data',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_updated (updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Create country_time_series table
CREATE TABLE IF NOT EXISTS country_time_series (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    iso_alpha_2 VARCHAR(6) NOT NULL,
    year YEAR NOT NULL,
    gdp_usd DECIMAL(20,2) DEFAULT NULL,
    population BIGINT DEFAULT NULL,
    area_sq_km DECIMAL(15,2) DEFAULT NULL,
    currency_code VARCHAR(6) DEFAULT NULL,
    currency_name VARCHAR(120) DEFAULT NULL,
    official_languages VARCHAR(500) DEFAULT NULL,
    capital VARCHAR(190) DEFAULT NULL,
    international_traffic_passengers BIGINT DEFAULT NULL,
    domestic_traffic_passengers BIGINT DEFAULT NULL,
    international_cargo_tonnes DECIMAL(15,2) DEFAULT NULL,
    domestic_cargo_tonnes DECIMAL(15,2) DEFAULT NULL,
    data_year YEAR DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY idx_country_year (iso_alpha_2, year),
    KEY idx_country (iso_alpha_2),
    KEY idx_year (year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Add CAA columns to regulatory_authorities
SET @aoc := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='regulatory_authorities' AND column_name='aoc_holders_list');
SET @sql3 := IF(@aoc=0, 'ALTER TABLE regulatory_authorities ADD COLUMN aoc_holders_list TEXT DEFAULT NULL AFTER unofficial_register_link', 'SELECT 1');
PREPARE stmt3 FROM @sql3; EXECUTE stmt3; DEALLOCATE PREPARE stmt3;

SET @ar := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='regulatory_authorities' AND column_name='aircraft_registry');
SET @sql4 := IF(@ar=0, 'ALTER TABLE regulatory_authorities ADD COLUMN aircraft_registry TEXT DEFAULT NULL AFTER aoc_holders_list', 'SELECT 1');
PREPARE stmt4 FROM @sql4; EXECUTE stmt4; DEALLOCATE PREPARE stmt4;

SET @ct := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='regulatory_authorities' AND column_name='contacts');
SET @sql5 := IF(@ct=0, 'ALTER TABLE regulatory_authorities ADD COLUMN contacts TEXT DEFAULT NULL AFTER aircraft_registry', 'SELECT 1');
PREPARE stmt5 FROM @sql5; EXECUTE stmt5; DEALLOCATE PREPARE stmt5;

SET @il := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='regulatory_authorities' AND column_name='icao_caa_link');
SET @sql6 := IF(@il=0, 'ALTER TABLE regulatory_authorities ADD COLUMN icao_caa_link TEXT DEFAULT NULL AFTER contacts', 'SELECT 1');
PREPARE stmt6 FROM @sql6; EXECUTE stmt6; DEALLOCATE PREPARE stmt6;

SET @wp := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='regulatory_authorities' AND column_name='wikipedia_url');
SET @sql7 := IF(@wp=0, 'ALTER TABLE regulatory_authorities ADD COLUMN wikipedia_url TEXT DEFAULT NULL AFTER icao_caa_link', 'SELECT 1');
PREPARE stmt7 FROM @sql7; EXECUTE stmt7; DEALLOCATE PREPARE stmt7;

SET @vn := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='regulatory_authorities' AND column_name='verification_notes');
SET @sql8 := IF(@vn=0, 'ALTER TABLE regulatory_authorities ADD COLUMN verification_notes TEXT DEFAULT NULL AFTER wikipedia_url', 'SELECT 1');
PREPARE stmt8 FROM @sql8; EXECUTE stmt8; DEALLOCATE PREPARE stmt8;

SET @ims := (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='regulatory_authorities' AND column_name='icao_member_since');
SET @sql9 := IF(@ims=0, 'ALTER TABLE regulatory_authorities ADD COLUMN icao_member_since VARCHAR(12) DEFAULT NULL AFTER verification_notes', 'SELECT 1');
PREPARE stmt9 FROM @sql9; EXECUTE stmt9; DEALLOCATE PREPARE stmt9;

-- 7. Create report_dependency table
CREATE TABLE IF NOT EXISTS report_dependencies (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    report_key VARCHAR(80) NOT NULL UNIQUE,
    report_label VARCHAR(190) NOT NULL,
    dependent_tables JSON DEFAULT NULL COMMENT 'Tables this report queries',
    last_run_at DATETIME DEFAULT NULL,
    needs_update TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed report dependencies
INSERT INTO report_dependencies (report_key, report_label, dependent_tables) VALUES
('country_air_transport_stats', 'Country Air Transport Stats', '["airports","airlines"]'),
('country_time_series', 'Country Time Series', '["country_time_series"]')
ON DUPLICATE KEY UPDATE report_key=report_key;

-- Trigger: mark reports as needing update when their source tables change
DROP TRIGGER IF EXISTS trg_airports_report_flag;
DROP TRIGGER IF EXISTS trg_airports_report_flag_upd;
DROP TRIGGER IF EXISTS trg_airports_report_flag_del;
DROP TRIGGER IF EXISTS trg_airlines_report_flag;
DROP TRIGGER IF EXISTS trg_airlines_report_flag_upd;
DROP TRIGGER IF EXISTS trg_airlines_report_flag_del;
DELIMITER //
CREATE TRIGGER trg_airports_report_flag AFTER INSERT ON airports FOR EACH ROW BEGIN UPDATE report_dependencies SET needs_update=1, updated_at=NOW() WHERE JSON_SEARCH(dependent_tables, 'one', 'airports') IS NOT NULL; END//
CREATE TRIGGER trg_airports_report_flag_upd AFTER UPDATE ON airports FOR EACH ROW BEGIN UPDATE report_dependencies SET needs_update=1, updated_at=NOW() WHERE JSON_SEARCH(dependent_tables, 'one', 'airports') IS NOT NULL; END//
CREATE TRIGGER trg_airports_report_flag_del AFTER DELETE ON airports FOR EACH ROW BEGIN UPDATE report_dependencies SET needs_update=1, updated_at=NOW() WHERE JSON_SEARCH(dependent_tables, 'one', 'airports') IS NOT NULL; END//
CREATE TRIGGER trg_airlines_report_flag AFTER INSERT ON airlines FOR EACH ROW BEGIN UPDATE report_dependencies SET needs_update=1, updated_at=NOW() WHERE JSON_SEARCH(dependent_tables, 'one', 'airlines') IS NOT NULL; END//
CREATE TRIGGER trg_airlines_report_flag_upd AFTER UPDATE ON airlines FOR EACH ROW BEGIN UPDATE report_dependencies SET needs_update=1, updated_at=NOW() WHERE JSON_SEARCH(dependent_tables, 'one', 'airlines') IS NOT NULL; END//
CREATE TRIGGER trg_airlines_report_flag_del AFTER DELETE ON airlines FOR EACH ROW BEGIN UPDATE report_dependencies SET needs_update=1, updated_at=NOW() WHERE JSON_SEARCH(dependent_tables, 'one', 'airlines') IS NOT NULL; END//
DELIMITER ;
