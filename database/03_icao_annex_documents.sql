-- =============================================================================
-- Migration: ICAO Annex Documents Registry (Annexes 1-8, 11-15)
-- Covers key safety, operational, and regulatory document types
-- =============================================================================

-- -----------------------------------------------------------------------
-- Annex 1 – Personnel Licensing: licenses, ratings, medical certs, EPL
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS personnel_licenses (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  person_name VARCHAR(190) NOT NULL,
  document_type ENUM('License','Rating','Medical Certificate','EPL') NOT NULL,
  license_type VARCHAR(80) DEFAULT NULL COMMENT 'e.g. PPL, CPL, ATPL, AME, ATC',
  license_number VARCHAR(80) DEFAULT NULL,
  issuing_authority VARCHAR(190) DEFAULT NULL,
  issuing_country VARCHAR(8) DEFAULT NULL,
  medical_class VARCHAR(20) DEFAULT NULL COMMENT 'Class 1,2,3',
  date_issued DATE DEFAULT NULL,
  date_expiry DATE DEFAULT NULL,
  ratings TEXT DEFAULT NULL COMMENT 'Endorsements/ratings (JSON)',
  restrictions TEXT DEFAULT NULL,
  status ENUM('Active','Expired','Suspended','Revoked') DEFAULT 'Active',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_pl_person (person_name),
  INDEX idx_pl_type (license_type),
  INDEX idx_pl_status (status),
  INDEX idx_pl_expiry (date_expiry)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 1 – Personnel Logbooks: flight/duty/rest time records
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS personnel_logbook_entries (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  person_name VARCHAR(190) NOT NULL,
  license_number VARCHAR(80) DEFAULT NULL,
  entry_date DATE DEFAULT NULL,
  aircraft_type VARCHAR(80) DEFAULT NULL,
  aircraft_registration VARCHAR(40) DEFAULT NULL,
  departure_icao VARCHAR(16) DEFAULT NULL,
  arrival_icao VARCHAR(16) DEFAULT NULL,
  departure_time_utc DATETIME DEFAULT NULL,
  arrival_time_utc DATETIME DEFAULT NULL,
  flight_time_minutes INT DEFAULT NULL,
  day_landings INT DEFAULT 0,
  night_landings INT DEFAULT 0,
  instrument_time_minutes INT DEFAULT 0,
  cross_country_time_minutes INT DEFAULT 0,
  duty_time_minutes INT DEFAULT NULL,
  rest_period_minutes INT DEFAULT NULL,
  pilot_function VARCHAR(40) DEFAULT NULL COMMENT 'PIC, Co-pilot, Dual, Instructor, P1, P2',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_logbook_person (person_name),
  INDEX idx_logbook_date (entry_date),
  INDEX idx_logbook_reg (aircraft_registration)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 2 & 11 – Flight Operations Docs: ATC clearances, flight plans
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS flight_operations_documents (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  document_type ENUM('ATC Clearance','Flight Plan','Alerting Message') NOT NULL,
  reference_number VARCHAR(80) DEFAULT NULL,
  aircraft_registration VARCHAR(40) DEFAULT NULL,
  aircraft_type VARCHAR(80) DEFAULT NULL,
  flight_number VARCHAR(20) DEFAULT NULL,
  operator_name VARCHAR(190) DEFAULT NULL,
  departure_icao VARCHAR(16) DEFAULT NULL,
  destination_icao VARCHAR(16) DEFAULT NULL,
  alternate_icao VARCHAR(16) DEFAULT NULL,
  route TEXT DEFAULT NULL,
  requested_altitude VARCHAR(40) DEFAULT NULL,
  assigned_altitude VARCHAR(40) DEFAULT NULL,
  speed VARCHAR(40) DEFAULT NULL,
  estimated_departure_time DATETIME DEFAULT NULL,
  estimated_arrival_time DATETIME DEFAULT NULL,
  fuel_endurance_minutes INT DEFAULT NULL,
  persons_on_board INT DEFAULT NULL,
  pilot_in_command VARCHAR(190) DEFAULT NULL,
  issuing_unit VARCHAR(190) DEFAULT NULL,
  issue_time DATETIME DEFAULT NULL,
  valid_from DATETIME DEFAULT NULL,
  valid_to DATETIME DEFAULT NULL,
  last_known_position TEXT DEFAULT NULL COMMENT 'Lat/Lon for alerting',
  last_contact_time DATETIME DEFAULT NULL,
  status ENUM('Active','Completed','Cancelled','Closed','Alert') DEFAULT 'Active',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_fod_type (document_type),
  INDEX idx_fod_reg (aircraft_registration),
  INDEX idx_fod_flight (flight_number),
  INDEX idx_fod_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 3 – Meteorological Reports: METAR, SPECI, TAF, SIGMET, AIREP
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS meteorological_reports (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  report_type ENUM('METAR','SPECI','TAF','SIGMET','AIREP') NOT NULL,
  station_icao VARCHAR(16) DEFAULT NULL COMMENT 'Airport/station identifier',
  region VARCHAR(80) DEFAULT NULL,
  issue_time DATETIME DEFAULT NULL,
  valid_from DATETIME DEFAULT NULL,
  valid_to DATETIME DEFAULT NULL,
  wind_direction INT DEFAULT NULL COMMENT 'Degrees true',
  wind_speed INT DEFAULT NULL COMMENT 'Knots',
  wind_gust INT DEFAULT NULL COMMENT 'Knots',
  visibility_m INT DEFAULT NULL COMMENT 'Meters',
  weather_phenomena VARCHAR(255) DEFAULT NULL COMMENT 'e.g. RA, SN, DZ, FG, TS',
  clouds VARCHAR(255) DEFAULT NULL COMMENT 'e.g. FEW030, BKN050, OVC100',
  temperature_c DECIMAL(4,1) DEFAULT NULL,
  dewpoint_c DECIMAL(4,1) DEFAULT NULL,
  qnh_hpa INT DEFAULT NULL COMMENT 'Pressure QNH in hPa',
  altimeter_inhg DECIMAL(5,2) DEFAULT NULL COMMENT 'Altimeter inches Hg',
  flight_level VARCHAR(20) DEFAULT NULL COMMENT 'For AIREP/SIGMET',
  turbulence VARCHAR(80) DEFAULT NULL COMMENT 'e.g. Light, Moderate, Severe',
  icing VARCHAR(80) DEFAULT NULL COMMENT 'e.g. Light, Moderate, Severe',
  raw_text TEXT DEFAULT NULL COMMENT 'Full original report text',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_met_type (report_type),
  INDEX idx_met_station (station_icao),
  INDEX idx_met_issue (issue_time),
  INDEX idx_met_valid (valid_from, valid_to)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 4 – Aeronautical Charts: IAC, SID, STAR, WAC, Aerodrome charts
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aeronautical_charts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  chart_type ENUM('IAC','SID','STAR','WAC','Aerodrome/Heliport','Enroute','Area','Other') NOT NULL,
  chart_name VARCHAR(255) NOT NULL,
  airport_ident VARCHAR(20) DEFAULT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  edition_number VARCHAR(40) DEFAULT NULL,
  edition_date DATE DEFAULT NULL,
  effective_date DATE DEFAULT NULL,
  publisher VARCHAR(190) DEFAULT NULL,
  scale VARCHAR(40) DEFAULT NULL,
  file_reference VARCHAR(500) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_chart_type (chart_type),
  INDEX idx_chart_airport (airport_ident),
  INDEX idx_chart_country (country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 6 & 8 – Aircraft Manuals: OM, MEL, AFM, Cabin Safety, ICA
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aircraft_manuals (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  manual_type ENUM('Operations Manual','Minimum Equipment List','Aircraft Flight Manual','Cabin Safety Procedures','Instructions for Continued Airworthiness') NOT NULL,
  aircraft_type VARCHAR(80) DEFAULT NULL,
  manufacturer VARCHAR(190) DEFAULT NULL,
  operator_name VARCHAR(190) DEFAULT NULL,
  document_title VARCHAR(255) DEFAULT NULL,
  document_version VARCHAR(40) DEFAULT NULL,
  approval_authority VARCHAR(190) DEFAULT NULL,
  approval_date DATE DEFAULT NULL,
  effective_date DATE DEFAULT NULL,
  file_reference VARCHAR(500) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_manual_type (manual_type),
  INDEX idx_manual_aircraft (aircraft_type),
  INDEX idx_manual_operator (operator_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 7 & 8 – Aircraft Certificates: C of R, C of A, Type Certificates
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aircraft_certificates (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  certificate_type ENUM('Certificate of Registration','Certificate of Airworthiness','Type Certificate','Export C of A','Import C of A','Special Flight Permit') NOT NULL,
  certificate_number VARCHAR(80) DEFAULT NULL,
  aircraft_type VARCHAR(80) DEFAULT NULL,
  manufacturer VARCHAR(190) DEFAULT NULL,
  manufacturer_serial VARCHAR(80) DEFAULT NULL,
  aircraft_registration VARCHAR(40) DEFAULT NULL,
  owner_name VARCHAR(255) DEFAULT NULL,
  owner_address TEXT DEFAULT NULL,
  holder_name VARCHAR(255) DEFAULT NULL,
  issuing_authority VARCHAR(190) DEFAULT NULL,
  issuing_country VARCHAR(8) DEFAULT NULL,
  date_issued DATE DEFAULT NULL,
  date_expiry DATE DEFAULT NULL,
  classification VARCHAR(80) DEFAULT NULL COMMENT 'e.g. Normal, Transport, Experimental',
  status ENUM('Active','Expired','Revoked','Suspended','Transferred') DEFAULT 'Active',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_cert_type (certificate_type),
  INDEX idx_cert_reg (aircraft_registration),
  INDEX idx_cert_number (certificate_number),
  INDEX idx_cert_serial (manufacturer_serial),
  INDEX idx_cert_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 14 – Aerodrome Documents: Manuals, Certificates, OLS
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aerodrome_documents (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  document_type ENUM('Aerodrome Manual','Aerodrome Certificate','Obstacle Limitation Surface') NOT NULL,
  airport_ident VARCHAR(20) NOT NULL,
  certificate_number VARCHAR(80) DEFAULT NULL,
  document_version VARCHAR(40) DEFAULT NULL,
  issuing_authority VARCHAR(190) DEFAULT NULL,
  approval_date DATE DEFAULT NULL,
  effective_date DATE DEFAULT NULL,
  expiry_date DATE DEFAULT NULL,
  surface_type VARCHAR(80) DEFAULT NULL COMMENT 'For OLS: e.g. Take-off climb, Approach, Transitional',
  dimensions VARCHAR(120) DEFAULT NULL,
  slope VARCHAR(40) DEFAULT NULL,
  category VARCHAR(80) DEFAULT NULL COMMENT 'Aerodrome category (1-4)',
  status ENUM('Current','Superseded','Expired','Draft') DEFAULT 'Current',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_ado_airport (airport_ident),
  INDEX idx_ado_type (document_type),
  INDEX idx_ado_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 15 – AIS Publications: AIP, AMDT, SUP, AIC, PIB
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aeronautical_information_publications (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  publication_type ENUM('AIP','AIP Amendment','AIP Supplement','Aeronautical Information Circular','Pre-flight Information Bulletin') NOT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  publication_number VARCHAR(40) DEFAULT NULL,
  year SMALLINT UNSIGNED DEFAULT NULL,
  subject VARCHAR(255) DEFAULT NULL,
  issuing_authority VARCHAR(190) DEFAULT NULL,
  publication_date DATE DEFAULT NULL,
  effective_date DATE DEFAULT NULL,
  file_reference VARCHAR(500) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_aip_type (publication_type),
  INDEX idx_aip_country (country_code),
  INDEX idx_aip_year (year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------
-- Annex 12 & 13 – Investigation Documents: SAR plans, accident reports
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS investigation_documents (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  document_type ENUM('SAR Plan','Preliminary Report','Final Report','Safety Recommendation') NOT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  region VARCHAR(120) DEFAULT NULL,
  investigation_authority VARCHAR(190) DEFAULT NULL,
  reference_number VARCHAR(80) DEFAULT NULL,
  title VARCHAR(255) DEFAULT NULL,
  incident_date DATE DEFAULT NULL,
  location VARCHAR(255) DEFAULT NULL,
  latitude DECIMAL(12,7) DEFAULT NULL,
  longitude DECIMAL(12,7) DEFAULT NULL,
  aircraft_type VARCHAR(80) DEFAULT NULL,
  aircraft_registration VARCHAR(40) DEFAULT NULL,
  operator_name VARCHAR(190) DEFAULT NULL,
  flight_number VARCHAR(20) DEFAULT NULL,
  findings TEXT DEFAULT NULL,
  causes TEXT DEFAULT NULL,
  contributing_factors TEXT DEFAULT NULL,
  safety_recommendations TEXT DEFAULT NULL,
  document_date DATE DEFAULT NULL,
  status ENUM('Draft','Published','Superseded','Closed') DEFAULT 'Draft',
  file_reference VARCHAR(500) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_inv_type (document_type),
  INDEX idx_inv_country (country_code),
  INDEX idx_inv_date (incident_date),
  INDEX idx_inv_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
