SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

RENAME TABLE aircraft_types TO legacy_aircraft_types;

DROP TABLE IF EXISTS aircraft_types;
CREATE TABLE aircraft_types (
  icao_code VARCHAR(16) NOT NULL PRIMARY KEY,
  iata_code VARCHAR(8) DEFAULT NULL,
  manufacturer VARCHAR(190) NOT NULL,
  model VARCHAR(190) DEFAULT NULL,
  type VARCHAR(40) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  engine_type VARCHAR(40) DEFAULT NULL,
  engine_count INT DEFAULT NULL,
  wtc VARCHAR(10) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_type_iata (iata_code),
  KEY idx_type_manufacturer (manufacturer),
  FULLTEXT KEY ft_aircraft_types (manufacturer, model, type, iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
