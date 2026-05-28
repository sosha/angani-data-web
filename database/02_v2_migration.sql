-- Angani Data V2 Migration
-- Phase 1: Countries domain + Pipeline infrastructure
-- Run after 01_schema.sql

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1a. Rename old countries table (FKs preserved automatically)
-- ============================================================
RENAME TABLE countries TO legacy_countries;

-- ============================================================
-- 1b. Pipeline infrastructure tables
-- ============================================================
DROP TABLE IF EXISTS pipeline_sources;
CREATE TABLE pipeline_sources (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  source_name VARCHAR(190) NOT NULL,
  source_type ENUM('api','scraper','csv_upload','url_csv') NOT NULL DEFAULT 'api',
  module_key VARCHAR(80) NOT NULL,
  is_active TINYINT(1) DEFAULT 1,
  url VARCHAR(500) DEFAULT NULL,
  http_method VARCHAR(10) DEFAULT 'GET',
  headers_json LONGTEXT DEFAULT NULL,
  scraper_script_path VARCHAR(500) DEFAULT NULL,
  csv_file_path VARCHAR(500) DEFAULT NULL,
  csv_mapping_json LONGTEXT DEFAULT NULL,
  schedule_cron VARCHAR(100) DEFAULT NULL,
  last_run_at DATETIME DEFAULT NULL,
  last_run_status VARCHAR(40) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_module (module_key),
  KEY idx_status (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS pipeline_runs;
CREATE TABLE pipeline_runs (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  pipeline_source_id INT UNSIGNED NOT NULL,
  module_key VARCHAR(80) NOT NULL,
  status ENUM('running','completed','failed','pending_review','approved','rejected') DEFAULT 'running',
  run_type ENUM('scheduled','manual') DEFAULT 'manual',
  records_fetched INT DEFAULT 0,
  records_valid INT DEFAULT 0,
  records_insert INT DEFAULT 0,
  records_update INT DEFAULT 0,
  records_delete INT DEFAULT 0,
  records_approved INT DEFAULT 0,
  records_rejected INT DEFAULT 0,
  raw_content LONGTEXT DEFAULT NULL,
  error_message TEXT DEFAULT NULL,
  started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  finished_at DATETIME DEFAULT NULL,
  approved_by INT UNSIGNED DEFAULT NULL,
  approved_at DATETIME DEFAULT NULL,
  FOREIGN KEY (pipeline_source_id) REFERENCES pipeline_sources(id) ON DELETE CASCADE,
  KEY idx_status (status),
  KEY idx_module (module_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS staging_records;
CREATE TABLE staging_records (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  pipeline_run_id BIGINT UNSIGNED NOT NULL,
  module_key VARCHAR(80) NOT NULL,
  action ENUM('insert','update','delete') NOT NULL,
  row_hash CHAR(64) NOT NULL,
  row_data JSON NOT NULL,
  diff_json JSON DEFAULT NULL,
  status ENUM('pending','approved','rejected','skipped') DEFAULT 'pending',
  reviewed_by INT UNSIGNED DEFAULT NULL,
  reviewed_at DATETIME DEFAULT NULL,
  FOREIGN KEY (pipeline_run_id) REFERENCES pipeline_runs(id) ON DELETE CASCADE,
  KEY idx_status (status),
  KEY idx_module (module_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS archived_records;
CREATE TABLE archived_records (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  source_table VARCHAR(120) NOT NULL,
  record_id INT UNSIGNED NOT NULL,
  record_data JSON NOT NULL,
  pipeline_run_id BIGINT UNSIGNED DEFAULT NULL,
  deleted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  deleted_by INT UNSIGNED DEFAULT NULL,
  FOREIGN KEY (pipeline_run_id) REFERENCES pipeline_runs(id) ON DELETE SET NULL,
  KEY idx_table (source_table)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS admin_action_log;
CREATE TABLE admin_action_log (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  admin_user_id INT UNSIGNED NOT NULL,
  action_type VARCHAR(80) NOT NULL,
  target_type VARCHAR(80) NOT NULL,
  target_id BIGINT UNSIGNED DEFAULT NULL,
  details_json JSON DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  KEY idx_action_type (action_type),
  KEY idx_admin (admin_user_id),
  KEY idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 1c. V2 Countries domain tables (ISO alpha-2 PK)
-- ============================================================
DROP TABLE IF EXISTS country_transport_stats;
DROP TABLE IF EXISTS country_dynamic_facts;
DROP TABLE IF EXISTS country_facts;
DROP TABLE IF EXISTS caas;
DROP TABLE IF EXISTS countries;

CREATE TABLE countries (
  iso_alpha_2 VARCHAR(2) NOT NULL PRIMARY KEY,
  iso_alpha_3 VARCHAR(3) DEFAULT NULL,
  name_common VARCHAR(190) NOT NULL,
  name_official VARCHAR(255) DEFAULT NULL,
  continent VARCHAR(40) DEFAULT NULL,
  un_region VARCHAR(120) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_continent (continent),
  KEY idx_region (un_region)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE caas (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(2) NOT NULL,
  name VARCHAR(255) NOT NULL,
  abbreviation VARCHAR(80) DEFAULT NULL,
  website VARCHAR(500) DEFAULT NULL,
  data_availability_notes TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (country_code) REFERENCES countries(iso_alpha_2) ON DELETE CASCADE,
  KEY idx_caa_country (country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE country_facts (
  country_code VARCHAR(2) NOT NULL,
  fact_key VARCHAR(80) NOT NULL,
  fact_value TEXT DEFAULT NULL,
  source VARCHAR(190) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (country_code, fact_key),
  FOREIGN KEY (country_code) REFERENCES countries(iso_alpha_2) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE country_dynamic_facts (
  country_code VARCHAR(2) NOT NULL,
  metric_key VARCHAR(80) NOT NULL,
  year INT NOT NULL,
  value DECIMAL(20,2) DEFAULT NULL,
  unit VARCHAR(40) DEFAULT NULL,
  source VARCHAR(190) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (country_code, metric_key, year),
  FOREIGN KEY (country_code) REFERENCES countries(iso_alpha_2) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE country_transport_stats (
  country_code VARCHAR(2) NOT NULL,
  statistic_year INT NOT NULL,
  quarter TINYINT DEFAULT NULL,
  mode ENUM('air','rail','road','sea') NOT NULL,
  metric VARCHAR(80) NOT NULL,
  value DECIMAL(20,2) DEFAULT NULL,
  unit VARCHAR(40) DEFAULT NULL,
  source VARCHAR(190) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (country_code, statistic_year, quarter, mode, metric),
  FOREIGN KEY (country_code) REFERENCES countries(iso_alpha_2) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 1d. Seed GB-ENG, GB-SCT, GB-NIR, GB-WLS
-- ============================================================
INSERT INTO countries (iso_alpha_2, iso_alpha_3, name_common, name_official, continent, un_region) VALUES
('GB-ENG', NULL, 'England', 'England', 'Europe', 'Northern Europe'),
('GB-SCT', NULL, 'Scotland', 'Scotland', 'Europe', 'Northern Europe'),
('GB-NIR', NULL, 'Northern Ireland', 'Northern Ireland', 'Europe', 'Northern Europe'),
('GB-WLS', NULL, 'Wales', 'Wales', 'Europe', 'Northern Europe');

-- ============================================================
-- 1e. Seed pipeline sources
-- ============================================================
INSERT INTO pipeline_sources (source_name, source_type, module_key, is_active, url, notes) VALUES
('REST Countries API', 'api', 'countries', 1,
 'https://restcountries.com/v3.1/all',
 'Free API returning country list with static facts (area, capital, currencies, languages, timezones). No authentication required.'),
('CAAs Verified CSV', 'csv_upload', 'caas', 1,
 NULL,
 'Manually curated and verified CSV at data/countries/caas.csv. Authoritative per Angani verification process.'),
('World Bank Transport API', 'api', 'country_transport_stats', 1,
 'https://api.worldbank.org/v2/country/all/indicator/IS.AIR.DPRT;IS.AIR.PSGR;IS.AIR.FRGT?format=json&per_page=5000',
 'World Bank API for air transport indicators: aircraft departures (IS.AIR.DPRT), passengers carried (IS.AIR.PSGR), freight tonnes (IS.AIR.FRGT).');

SET FOREIGN_KEY_CHECKS = 1;
