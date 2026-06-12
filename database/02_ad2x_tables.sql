-- =============================================================================
-- Migration: ICAO AD 2.x Aerodrome Data Tables
-- Covers AD 2.3 through AD 2.23 (excluding existing AD 2.18 ATS Comms)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- AD 2.3 – Operating Hours
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_operating_hours (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  service VARCHAR(120) NOT NULL COMMENT 'e.g. Customs, AIS, ARO, MET, ATS, Fuelling, Handling, Security, De-icing, RFFS',
  schedule VARCHAR(255) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_operating_hours_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.4 – Handling Services and Facilities
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_handling_services (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  service_type VARCHAR(120) NOT NULL COMMENT 'e.g. Cargo handling, Fuel types, De-icing, Hangar, Repair, Catering',
  provider VARCHAR(190) DEFAULT NULL,
  capacity_text VARCHAR(255) DEFAULT NULL COMMENT 'e.g. Fuel capacity (L), Hangar size',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_handling_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.5 – Passenger Facilities
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_passenger_facilities (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  facility_type VARCHAR(120) NOT NULL COMMENT 'e.g. Hotel, Restaurant, Transport, Medical, Bank/Post, Tourist, VIP Lounge',
  available VARCHAR(40) DEFAULT NULL COMMENT 'Yes/No/Limited',
  operator VARCHAR(190) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_passenger_facilities_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.6 – Rescue and Fire Fighting Services (RFFS)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_rescue_firefighting (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  rffs_category VARCHAR(20) DEFAULT NULL COMMENT 'ICAO Category 1-10',
  rffs_level VARCHAR(80) DEFAULT NULL COMMENT 'e.g. Level 3, Level 5',
  equipment_list TEXT DEFAULT NULL,
  disabled_aircraft_removal VARCHAR(80) DEFAULT NULL COMMENT 'Yes/No/Partial',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_rffs_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.7 – Seasonal Clearance (Snow/Winter Operations)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_seasonal_clearance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  area VARCHAR(120) NOT NULL COMMENT 'e.g. RWY, TWY, Apron',
  equipment VARCHAR(255) DEFAULT NULL,
  clearing_priorities TEXT DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_seasonal_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.8 – Aprons, Taxiways and Check Points/Positions
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_movement_areas (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  area_type ENUM('Apron','Taxiway','Check Point','Holding Position','Other') NOT NULL DEFAULT 'Apron',
  designator VARCHAR(40) NOT NULL COMMENT 'e.g. Apron 1, TWY A, CP 1',
  surface VARCHAR(120) DEFAULT NULL,
  strength_pcn VARCHAR(40) DEFAULT NULL COMMENT 'PCN value for aprons/taxiways',
  dimensions VARCHAR(120) DEFAULT NULL COMMENT 'e.g. 120 x 80 m',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_movement_areas_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.9 – Surface Movement Guidance and Control Systems
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_surface_guidance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  guidance_type VARCHAR(120) NOT NULL COMMENT 'e.g. Stand ID signs, TWY guidance lines, Docking system, Stop bars, Markings',
  description TEXT DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_surface_guidance_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.10 – Aerodrome Obstacles
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_obstacles (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  obstacle_id VARCHAR(40) DEFAULT NULL,
  obstacle_type VARCHAR(120) DEFAULT NULL COMMENT 'e.g. Building, Antenna, Crane, Tree, Terrain',
  position_lat DECIMAL(12,7) DEFAULT NULL,
  position_lon DECIMAL(12,7) DEFAULT NULL,
  elevation_ft INT DEFAULT NULL COMMENT 'Elevation of obstacle base AMSL',
  height_ft INT DEFAULT NULL COMMENT 'Height above ground',
  marking VARCHAR(120) DEFAULT NULL COMMENT 'e.g. Red/white bands',
  lighting VARCHAR(120) DEFAULT NULL COMMENT 'e.g. Red steady, Medium intensity',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_obstacles_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.11 – Meteorological Information
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_meteorological (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  met_office_name VARCHAR(190) DEFAULT NULL,
  operating_hours VARCHAR(255) DEFAULT NULL,
  briefing_available ENUM('Yes','No','On request') DEFAULT 'No',
  charts_available TEXT DEFAULT NULL COMMENT 'e.g. SIGWX, Upper wind, etc.',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_met_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.12/2.13/2.14 – Runway Characteristics (per-direction extension)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_runway_directions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  runway_id BIGINT UNSIGNED NOT NULL,
  direction_ident VARCHAR(10) NOT NULL COMMENT 'e.g. 08L, 26R',
  true_bearing DECIMAL(6,2) DEFAULT NULL COMMENT 'Degrees true',
  threshold_elevation_ft INT DEFAULT NULL,
  threshold_displacement_ft INT DEFAULT NULL COMMENT 'Displaced threshold length',
  tora INT DEFAULT NULL COMMENT 'Take-off Run Available (ft)',
  toda INT DEFAULT NULL COMMENT 'Take-off Distance Available (ft)',
  asda INT DEFAULT NULL COMMENT 'Accelerate-Stop Distance Available (ft)',
  lda INT DEFAULT NULL COMMENT 'Landing Distance Available (ft)',
  approach_lighting_system VARCHAR(120) DEFAULT NULL COMMENT 'e.g. ALS, CAT I, CAT II, SALS, PALS',
  papi_available ENUM('Yes','No') DEFAULT 'No',
  papi_location VARCHAR(40) DEFAULT NULL COMMENT 'e.g. Left, Right, Both sides',
  papi_angle DECIMAL(4,2) DEFAULT NULL COMMENT 'Glide path angle (degrees)',
  centerline_lights ENUM('Yes','No') DEFAULT 'No',
  touchdown_zone_lights ENUM('Yes','No') DEFAULT 'No',
  runway_end_lights ENUM('Yes','No') DEFAULT 'No',
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_runway_dir_runway (runway_id),
  CONSTRAINT fk_runway_dir_runway FOREIGN KEY (runway_id) REFERENCES airport_runways(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.12 – Additional Runway Columns (shared per-runway, not per-direction)
-- -----------------------------------------------------------------------------
ALTER TABLE airport_runways ADD COLUMN pcr VARCHAR(20) DEFAULT NULL COMMENT 'Pavement Classification Rating';
ALTER TABLE airport_runways ADD COLUMN strip_length_ft INT DEFAULT NULL;
ALTER TABLE airport_runways ADD COLUMN strip_width_ft INT DEFAULT NULL;
ALTER TABLE airport_runways ADD COLUMN resa_length_ft INT DEFAULT NULL COMMENT 'Runway End Safety Area length';
ALTER TABLE airport_runways ADD COLUMN resa_width_ft INT DEFAULT NULL;
ALTER TABLE airport_runways ADD COLUMN ofz_length_ft INT DEFAULT NULL COMMENT 'Obstacle Free Zone length';
ALTER TABLE airport_runways ADD COLUMN ofz_width_ft INT DEFAULT NULL;
ALTER TABLE airport_runways ADD COLUMN stopway_length_ft INT DEFAULT NULL;
ALTER TABLE airport_runways ADD COLUMN clearway_length_ft INT DEFAULT NULL;
ALTER TABLE airport_runways ADD COLUMN shoulder_surface VARCHAR(120) DEFAULT NULL;
ALTER TABLE airport_runways ADD COLUMN runway_width_shoulders_ft INT DEFAULT NULL;

-- -----------------------------------------------------------------------------
-- AD 2.15 – Other Lighting and Secondary Power Supply
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_lighting_secondary_power (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  facility_type VARCHAR(120) NOT NULL COMMENT 'e.g. ABN/IBN, LDI, TWY edge lights, Secondary power supply',
  available ENUM('Yes','No') DEFAULT 'No',
  description TEXT DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_lighting_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.16 – Helicopter Landing Area
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_helipads (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  helipad_ident VARCHAR(40) NOT NULL,
  tlof_lat DECIMAL(12,7) DEFAULT NULL COMMENT 'TLOF centre latitude',
  tlof_lon DECIMAL(12,7) DEFAULT NULL COMMENT 'TLOF centre longitude',
  tlof_elevation_ft INT DEFAULT NULL,
  tlof_dimensions VARCHAR(80) DEFAULT NULL COMMENT 'e.g. D 20 m',
  tlof_surface VARCHAR(120) DEFAULT NULL,
  tlof_strength VARCHAR(40) DEFAULT NULL,
  fato_dimensions VARCHAR(80) DEFAULT NULL,
  marking VARCHAR(120) DEFAULT NULL,
  lighting VARCHAR(120) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_helipads_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.17 – ATS Airspace
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_ats_airspace (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  airspace_type VARCHAR(40) NOT NULL COMMENT 'e.g. CTR, CTA, TMA, FIR',
  classification VARCHAR(20) DEFAULT NULL COMMENT 'e.g. A, B, C, D, E, F, G',
  vertical_limits VARCHAR(120) DEFAULT NULL COMMENT 'e.g. SFC - 4500 ft AMSL',
  transition_altitude_ft INT DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_ats_airspace_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.19 – Radio Navigation and Landing Aids
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_radio_navaids (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  navaid_type VARCHAR(40) NOT NULL COMMENT 'e.g. VOR, DME, NDB, ILS, TACAN, GBAS',
  ident VARCHAR(20) DEFAULT NULL,
  frequency_mhz DECIMAL(12,4) DEFAULT NULL,
  name VARCHAR(190) DEFAULT NULL,
  position_lat DECIMAL(12,7) DEFAULT NULL,
  position_lon DECIMAL(12,7) DEFAULT NULL,
  elevation_ft INT DEFAULT NULL,
  operating_hours VARCHAR(255) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_radio_navaids_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.20 – Local Traffic Regulations
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_local_traffic_regulations (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  regulation_type VARCHAR(120) NOT NULL COMMENT 'e.g. Low visibility, Noise abatement, Taxi restrictions',
  description TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_local_traffic_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.21 – Noise Abatement Procedures
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_noise_abatement (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  procedure_type VARCHAR(120) NOT NULL COMMENT 'e.g. NADP 1, NADP 2, Preferential runway, Curfew',
  description TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_noise_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.22 – Flight Procedures
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_flight_procedures (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  procedure_type VARCHAR(120) NOT NULL COMMENT 'e.g. IAP, SID, STAR, Holding, Missed approach',
  designator VARCHAR(80) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_flight_procedures_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- AD 2.23 – Additional Information
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS airport_additional_information (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_ident VARCHAR(20) NOT NULL,
  info_type VARCHAR(120) NOT NULL COMMENT 'e.g. Bird hazard, Volcanic ash, Rescue agreement',
  description TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_additional_info_airport (airport_ident)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
