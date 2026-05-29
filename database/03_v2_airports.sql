SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

RENAME TABLE airports TO legacy_airports;

DROP TABLE IF EXISTS airports;
CREATE TABLE airports (
  ident VARCHAR(20) NOT NULL PRIMARY KEY,
  type VARCHAR(40) DEFAULT NULL,
  name VARCHAR(255) NOT NULL,
  latitude_deg DECIMAL(12,7) DEFAULT NULL,
  longitude_deg DECIMAL(12,7) DEFAULT NULL,
  elevation_ft INT DEFAULT NULL,
  continent VARCHAR(4) DEFAULT NULL,
  iso_country VARCHAR(6) DEFAULT NULL,
  municipality VARCHAR(190) DEFAULT NULL,
  scheduled_service TINYINT(1) DEFAULT 0,
  gps_code VARCHAR(8) DEFAULT NULL,
  iata_code VARCHAR(8) DEFAULT NULL,
  local_code VARCHAR(20) DEFAULT NULL,
  home_link TEXT DEFAULT NULL,
  wikipedia_link TEXT DEFAULT NULL,
  keywords TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_airport_country (iso_country),
  KEY idx_airport_iata (iata_code),
  KEY idx_airport_gps (gps_code),
  KEY idx_airport_type (type),
  FULLTEXT KEY ft_airports (name, municipality, iata_code, gps_code, ident, keywords)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
