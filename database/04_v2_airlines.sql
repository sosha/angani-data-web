SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

RENAME TABLE airlines TO legacy_airlines;

DROP TABLE IF EXISTS airlines;
CREATE TABLE airlines (
  icao_code VARCHAR(16) NOT NULL PRIMARY KEY,
  iata_code VARCHAR(8) DEFAULT NULL,
  name VARCHAR(255) NOT NULL,
  alias VARCHAR(255) DEFAULT NULL,
  callsign VARCHAR(120) DEFAULT NULL,
  country VARCHAR(190) DEFAULT NULL,
  country_code VARCHAR(6) DEFAULT NULL,
  active VARCHAR(10) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_airlines_country (country_code),
  KEY idx_airlines_iata (iata_code),
  FULLTEXT KEY ft_airlines (name, alias, callsign, iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
