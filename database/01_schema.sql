SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS record_verifications;
DROP TABLE IF EXISTS site_slides;
DROP TABLE IF EXISTS site_pages;
DROP TABLE IF EXISTS personnel_logbook_entries;
DROP TABLE IF EXISTS personnel_licenses;
DROP TABLE IF EXISTS flight_operations_documents;
DROP TABLE IF EXISTS meteorological_reports;
DROP TABLE IF EXISTS aeronautical_charts;
DROP TABLE IF EXISTS aircraft_manuals;
DROP TABLE IF EXISTS aircraft_certificates;
DROP TABLE IF EXISTS aerodrome_documents;
DROP TABLE IF EXISTS aeronautical_information_publications;
DROP TABLE IF EXISTS investigation_documents;
DROP TABLE IF EXISTS airport_runway_directions;
DROP TABLE IF EXISTS airport_radio_navaids;
DROP TABLE IF EXISTS airport_additional_information;
DROP TABLE IF EXISTS airport_flight_procedures;
DROP TABLE IF EXISTS airport_noise_abatement;
DROP TABLE IF EXISTS airport_local_traffic_regulations;
DROP TABLE IF EXISTS airport_ats_airspace;
DROP TABLE IF EXISTS airport_helipads;
DROP TABLE IF EXISTS airport_lighting_secondary_power;
DROP TABLE IF EXISTS airport_meteorological;
DROP TABLE IF EXISTS airport_obstacles;
DROP TABLE IF EXISTS airport_surface_guidance;
DROP TABLE IF EXISTS airport_movement_areas;
DROP TABLE IF EXISTS airport_seasonal_clearance;
DROP TABLE IF EXISTS airport_rescue_firefighting;
DROP TABLE IF EXISTS airport_passenger_facilities;
DROP TABLE IF EXISTS airport_handling_services;
DROP TABLE IF EXISTS airport_operating_hours;
DROP TABLE IF EXISTS airport_runways;
DROP TABLE IF EXISTS entity_change_log;
DROP TABLE IF EXISTS source_records;
DROP TABLE IF EXISTS sources;
DROP TABLE IF EXISTS saved_searches;
DROP TABLE IF EXISTS question_presets;
DROP TABLE IF EXISTS insight_cards;
DROP TABLE IF EXISTS tier_features;
DROP TABLE IF EXISTS user_subscriptions;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS subscription_tiers;
DROP TABLE IF EXISTS route_traffic_statistics;
DROP TABLE IF EXISTS route_service_equipment;
DROP TABLE IF EXISTS route_schedule_days;
DROP TABLE IF EXISTS route_schedule_patterns;
DROP TABLE IF EXISTS airline_route_services;
DROP TABLE IF EXISTS route_markets;
DROP TABLE IF EXISTS airport_airline_roles;
DROP TABLE IF EXISTS aircraft_engine_installations;
DROP TABLE IF EXISTS engine_models;
DROP TABLE IF EXISTS engine_manufacturers;
DROP TABLE IF EXISTS aircraft_cabin_classes;
DROP TABLE IF EXISTS aircraft_cabin_configurations;
DROP TABLE IF EXISTS aircraft_lease_history;
DROP TABLE IF EXISTS aircraft_ownership_history;
DROP TABLE IF EXISTS aircraft_operator_history;
DROP TABLE IF EXISTS aircraft_registration_history;
DROP TABLE IF EXISTS lessors;
DROP TABLE IF EXISTS airline_aocs;
DROP TABLE IF EXISTS organisation_people;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS organisation_roles;
DROP TABLE IF EXISTS organisations;
DROP TABLE IF EXISTS dataset_records;
DROP TABLE IF EXISTS dataset_files;
DROP TABLE IF EXISTS regulatory_records;
DROP TABLE IF EXISTS airline_destinations;
DROP TABLE IF EXISTS airports;
DROP TABLE IF EXISTS aircraft_types;
DROP TABLE IF EXISTS aircraft_registrations;
DROP TABLE IF EXISTS airlines;
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (code VARCHAR(8) NOT NULL PRIMARY KEY,name VARCHAR(190) NOT NULL,region VARCHAR(80) DEFAULT NULL,subregion VARCHAR(120) DEFAULT NULL,INDEX idx_region (region)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE airlines (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,source_scope VARCHAR(40) DEFAULT NULL,country_code VARCHAR(8) DEFAULT NULL,region VARCHAR(80) DEFAULT NULL,name VARCHAR(255) NOT NULL,legal_name VARCHAR(255) DEFAULT NULL,trading_name VARCHAR(255) DEFAULT NULL,iata_code VARCHAR(16) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,prefix VARCHAR(32) DEFAULT NULL,callsign VARCHAR(120) DEFAULT NULL,fleet_size INT DEFAULT NULL,destinations_count INT DEFAULT NULL,logo_url TEXT DEFAULT NULL,wikipedia_url TEXT DEFAULT NULL,website_url TEXT DEFAULT NULL,status VARCHAR(80) DEFAULT NULL,status_bucket ENUM('active','defunct','unknown') NOT NULL DEFAULT 'unknown',source_url TEXT DEFAULT NULL,founded VARCHAR(80) DEFAULT NULL,hubs TEXT DEFAULT NULL,alliance VARCHAR(120) DEFAULT NULL,parent_company VARCHAR(190) DEFAULT NULL,ownership_type VARCHAR(120) DEFAULT NULL,ceo_accountable_manager VARCHAR(255) DEFAULT NULL,record_status VARCHAR(80) DEFAULT NULL,date_added VARCHAR(32) DEFAULT NULL,date_modified VARCHAR(32) DEFAULT NULL,data_source VARCHAR(120) DEFAULT NULL,last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FULLTEXT KEY ft_airlines (name, callsign, iata_code, icao_code, alliance, hubs, parent_company),INDEX idx_airlines_status (status_bucket),INDEX idx_airlines_country (country_code),INDEX idx_airlines_region (region),INDEX idx_airlines_icao (icao_code),INDEX idx_airlines_iata (iata_code)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE aircraft_registrations (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,country_code VARCHAR(8) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,aircraft_type VARCHAR(190) DEFAULT NULL,registration VARCHAR(80) DEFAULT NULL,adshex VARCHAR(80) DEFAULT NULL,type_code VARCHAR(80) DEFAULT NULL,construction_number VARCHAR(120) DEFAULT NULL,age DECIMAL(8,2) DEFAULT NULL,operator_icao VARCHAR(16) DEFAULT NULL,operator_name VARCHAR(190) DEFAULT NULL,record_status VARCHAR(80) DEFAULT NULL,date_added VARCHAR(32) DEFAULT NULL,date_modified VARCHAR(32) DEFAULT NULL,data_source VARCHAR(120) DEFAULT NULL,FULLTEXT KEY ft_aircraft (aircraft_type, registration, icao_code, operator_icao, operator_name, type_code),INDEX idx_aircraft_country (country_code),INDEX idx_aircraft_icao (icao_code),INDEX idx_aircraft_operator (operator_icao),INDEX idx_aircraft_type (aircraft_type)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE aircraft_types (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,aircraft_type VARCHAR(190) DEFAULT NULL,common_name VARCHAR(190) DEFAULT NULL,full_designation VARCHAR(190) DEFAULT NULL,manufacturer VARCHAR(190) DEFAULT NULL,model VARCHAR(190) DEFAULT NULL,iata_code VARCHAR(16) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,engine_type VARCHAR(80) DEFAULT NULL,engine_count INT DEFAULT NULL,max_pax INT DEFAULT NULL,range_km DECIMAL(12,2) DEFAULT NULL,mtow_kg DECIMAL(12,2) DEFAULT NULL,status VARCHAR(120) DEFAULT NULL,generation VARCHAR(120) DEFAULT NULL,category VARCHAR(120) DEFAULT NULL,mission_type VARCHAR(120) DEFAULT NULL,wtc VARCHAR(40) DEFAULT NULL,record_status VARCHAR(80) DEFAULT NULL,source_url TEXT DEFAULT NULL,last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FULLTEXT KEY ft_aircraft_types (aircraft_type, common_name, full_designation, manufacturer, model, iata_code, icao_code),INDEX idx_type_icao (icao_code),INDEX idx_type_iata (iata_code),INDEX idx_type_manufacturer (manufacturer)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE airports (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,country_code VARCHAR(8) DEFAULT NULL,iata_code VARCHAR(16) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,airport_name VARCHAR(255) DEFAULT NULL,city_name VARCHAR(190) DEFAULT NULL,latitude DECIMAL(12,7) DEFAULT NULL,longitude DECIMAL(12,7) DEFAULT NULL,elevation_ft INT DEFAULT NULL,slot_coordination_level VARCHAR(80) DEFAULT NULL,status VARCHAR(80) DEFAULT NULL,last_updated VARCHAR(80) DEFAULT NULL,airport_type VARCHAR(120) DEFAULT NULL,municipality VARCHAR(190) DEFAULT NULL,region_name VARCHAR(190) DEFAULT NULL,trading_name VARCHAR(255) DEFAULT NULL,ident VARCHAR(80) DEFAULT NULL,callsign VARCHAR(120) DEFAULT NULL,founding_year VARCHAR(40) DEFAULT NULL,introduction TEXT DEFAULT NULL,last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FULLTEXT KEY ft_airports (airport_name, city_name, iata_code, icao_code),INDEX idx_airports_country (country_code),INDEX idx_airports_iata (iata_code),INDEX idx_airports_icao (icao_code)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE airline_destinations (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,country_code VARCHAR(8) DEFAULT NULL,airline_name VARCHAR(255) DEFAULT NULL,airline_iata VARCHAR(16) DEFAULT NULL,airline_icao VARCHAR(16) DEFAULT NULL,city VARCHAR(190) DEFAULT NULL,country VARCHAR(190) DEFAULT NULL,airport_name VARCHAR(255) DEFAULT NULL,iata_code VARCHAR(16) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,status VARCHAR(80) DEFAULT NULL,hub VARCHAR(40) DEFAULT NULL,notes TEXT DEFAULT NULL,record_status VARCHAR(80) DEFAULT NULL,date_added VARCHAR(32) DEFAULT NULL,date_modified VARCHAR(32) DEFAULT NULL,FULLTEXT KEY ft_destinations (airline_name, airline_iata, airline_icao, city, country, airport_name, iata_code, icao_code),INDEX idx_dest_airline_iata (airline_iata),INDEX idx_dest_airline_icao (airline_icao),INDEX idx_dest_country (country_code)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE regulatory_records (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,type VARCHAR(120) DEFAULT NULL,country_code VARCHAR(8) DEFAULT NULL,name VARCHAR(255) DEFAULT NULL,regulator_name VARCHAR(255) DEFAULT NULL,airline_iata VARCHAR(16) DEFAULT NULL,airline_icao VARCHAR(16) DEFAULT NULL,aoc_number VARCHAR(120) DEFAULT NULL,authority VARCHAR(190) DEFAULT NULL,city VARCHAR(190) DEFAULT NULL,country VARCHAR(190) DEFAULT NULL,email VARCHAR(190) DEFAULT NULL,phone VARCHAR(120) DEFAULT NULL,website TEXT DEFAULT NULL,status VARCHAR(80) DEFAULT NULL,status_bucket ENUM('active','defunct','unknown') NOT NULL DEFAULT 'unknown',fields_json LONGTEXT DEFAULT NULL,FULLTEXT KEY ft_regulatory (type, name, regulator_name, airline_iata, airline_icao, aoc_number, authority, city, country, email, phone),INDEX idx_reg_country (country_code),INDEX idx_reg_type (type),INDEX idx_reg_status (status_bucket)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE dataset_files (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,path VARCHAR(512) NOT NULL,scope VARCHAR(80) DEFAULT NULL,category VARCHAR(160) DEFAULT NULL,filename VARCHAR(190) DEFAULT NULL,country_code VARCHAR(8) DEFAULT NULL,row_count INT NOT NULL DEFAULT 0,is_populated TINYINT(1) NOT NULL DEFAULT 0,headers_json LONGTEXT DEFAULT NULL,UNIQUE KEY uq_dataset_path (path),INDEX idx_dataset_category (category),INDEX idx_dataset_populated (is_populated),INDEX idx_dataset_country (country_code)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE dataset_records (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,dataset_file_id INT UNSIGNED NOT NULL,country_code VARCHAR(8) DEFAULT NULL,category VARCHAR(160) DEFAULT NULL,filename VARCHAR(190) DEFAULT NULL,row_json LONGTEXT NOT NULL,INDEX idx_records_file (dataset_file_id),INDEX idx_records_country (country_code),INDEX idx_records_category (category),CONSTRAINT fk_dataset_records_file FOREIGN KEY (dataset_file_id) REFERENCES dataset_files(id) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------------------------------
-- Platform access, accounts and tier control
-- -----------------------------------------------------------------------------
CREATE TABLE subscription_tiers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(40) NOT NULL UNIQUE,
  name VARCHAR(80) NOT NULL,
  description TEXT DEFAULT NULL,
  monthly_usd DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  annual_usd DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  search_limit_daily INT NOT NULL DEFAULT 0,
  export_limit_monthly INT NOT NULL DEFAULT 0,
  api_limit_monthly INT NOT NULL DEFAULT 0,
  display_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_tier_order (display_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tier_features (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tier_id INT UNSIGNED NOT NULL,
  feature_code VARCHAR(80) NOT NULL,
  feature_label VARCHAR(190) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_tier_feature (tier_id, feature_code),
  CONSTRAINT fk_tier_features_tier FOREIGN KEY (tier_id) REFERENCES subscription_tiers(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(190) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  tier_id INT UNSIGNED NOT NULL,
  role ENUM('user','admin') NOT NULL DEFAULT 'user',
  status ENUM('active','suspended','deleted') NOT NULL DEFAULT 'active',
  email_verified_at DATETIME DEFAULT NULL,
  last_login_at DATETIME DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_users_tier (tier_id),
  CONSTRAINT fk_users_tier FOREIGN KEY (tier_id) REFERENCES subscription_tiers(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE user_subscriptions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  tier_id INT UNSIGNED NOT NULL,
  status ENUM('trial','active','past_due','cancelled','expired') NOT NULL DEFAULT 'active',
  starts_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  ends_at DATETIME DEFAULT NULL,
  payment_reference VARCHAR(190) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_subscription_user (user_id),
  CONSTRAINT fk_user_subscriptions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_user_subscriptions_tier FOREIGN KEY (tier_id) REFERENCES subscription_tiers(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE saved_searches (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  title VARCHAR(190) NOT NULL,
  page VARCHAR(80) NOT NULL,
  query_params LONGTEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_saved_searches_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE question_presets (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(80) NOT NULL UNIQUE,
  title VARCHAR(190) NOT NULL,
  question_text TEXT NOT NULL,
  category VARCHAR(80) NOT NULL,
  answer_key VARCHAR(80) NOT NULL,
  required_tier_id INT UNSIGNED DEFAULT NULL,
  display_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_question_order (display_order),
  CONSTRAINT fk_question_tier FOREIGN KEY (required_tier_id) REFERENCES subscription_tiers(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE insight_cards (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(190) NOT NULL,
  metric_label VARCHAR(80) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  query_key VARCHAR(80) NOT NULL,
  chart_type VARCHAR(40) NOT NULL DEFAULT 'ranked_bar',
  required_tier_id INT UNSIGNED DEFAULT NULL,
  display_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  last_rotated_at DATETIME DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_insight_tier FOREIGN KEY (required_tier_id) REFERENCES subscription_tiers(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- Service providers to the aviation industry (lessors, MRO, maintenance, 
-- ground handling, catering, training, etc.)
-- -----------------------------------------------------------------------------
CREATE TABLE organisations (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  legal_name VARCHAR(255) DEFAULT NULL,
  organisation_type VARCHAR(80) DEFAULT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  website VARCHAR(255) DEFAULT NULL,
  email VARCHAR(190) DEFAULT NULL,
  phone VARCHAR(120) DEFAULT NULL,
  status VARCHAR(60) DEFAULT 'active',
  founded_date DATE DEFAULT NULL,
  ceased_date DATE DEFAULT NULL,
  parent_organisation_id BIGINT UNSIGNED DEFAULT NULL,
  description TEXT DEFAULT NULL,
  logo_url VARCHAR(500) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_org_country (country_code),
  INDEX idx_org_type (organisation_type),
  CONSTRAINT fk_org_country FOREIGN KEY (country_code) REFERENCES countries(code) ON DELETE SET NULL,
  CONSTRAINT fk_org_parent FOREIGN KEY (parent_organisation_id) REFERENCES organisations(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE organisation_roles (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  organisation_id BIGINT UNSIGNED NOT NULL,
  role_type VARCHAR(80) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_org_role (organisation_id, role_type),
  CONSTRAINT fk_org_roles_org FOREIGN KEY (organisation_id) REFERENCES organisations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE people (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(190) NOT NULL,
  nationality_country_code VARCHAR(8) DEFAULT NULL,
  linkedin_url VARCHAR(500) DEFAULT NULL,
  bio TEXT DEFAULT NULL,
  photo_url VARCHAR(500) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_people_country FOREIGN KEY (nationality_country_code) REFERENCES countries(code) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE organisation_people (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  organisation_id BIGINT UNSIGNED NOT NULL,
  person_id BIGINT UNSIGNED NOT NULL,
  title VARCHAR(190) NOT NULL,
  department VARCHAR(120) DEFAULT NULL,
  role_type VARCHAR(100) DEFAULT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  is_current TINYINT(1) NOT NULL DEFAULT 1,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_org_people_current (is_current),
  CONSTRAINT fk_org_people_org FOREIGN KEY (organisation_id) REFERENCES organisations(id) ON DELETE CASCADE,
  CONSTRAINT fk_org_people_person FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE airline_aocs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airline_id INT UNSIGNED NOT NULL,
  regulator_organisation_id BIGINT UNSIGNED DEFAULT NULL,
  aoc_number VARCHAR(120) DEFAULT NULL,
  certificate_type VARCHAR(120) DEFAULT NULL,
  issue_date DATE DEFAULT NULL,
  expiry_date DATE DEFAULT NULL,
  status VARCHAR(60) DEFAULT 'active',
  permitted_operations LONGTEXT DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_aoc_airline FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE CASCADE,
  CONSTRAINT fk_aoc_regulator_org FOREIGN KEY (regulator_organisation_id) REFERENCES organisations(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE lessors (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  lessor_code VARCHAR(80) DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL,
  organisation_id BIGINT UNSIGNED DEFAULT NULL,
  headquarters_country_code VARCHAR(8) DEFAULT NULL,
  hq_location VARCHAR(190) DEFAULT NULL,
  fleet_count INT DEFAULT NULL,
  contact_info TEXT DEFAULT NULL,
  status VARCHAR(120) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_lessors_name (name),
  CONSTRAINT fk_lessors_org FOREIGN KEY (organisation_id) REFERENCES organisations(id) ON DELETE SET NULL,
  CONSTRAINT fk_lessors_country FOREIGN KEY (headquarters_country_code) REFERENCES countries(code) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE aircraft_registration_history (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  aircraft_id INT UNSIGNED NOT NULL,
  registration VARCHAR(80) NOT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  valid_from DATE DEFAULT NULL,
  valid_to DATE DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  CONSTRAINT fk_reg_history_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft_registrations(id) ON DELETE CASCADE,
  CONSTRAINT fk_reg_history_country FOREIGN KEY (country_code) REFERENCES countries(code) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE aircraft_operator_history (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  aircraft_id INT UNSIGNED NOT NULL,
  airline_id INT UNSIGNED NOT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  operation_type VARCHAR(80) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  CONSTRAINT fk_operator_history_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft_registrations(id) ON DELETE CASCADE,
  CONSTRAINT fk_operator_history_airline FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE aircraft_ownership_history (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  aircraft_id INT UNSIGNED NOT NULL,
  owner_organisation_id BIGINT UNSIGNED NOT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  ownership_type VARCHAR(80) DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  CONSTRAINT fk_owner_history_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft_registrations(id) ON DELETE CASCADE,
  CONSTRAINT fk_owner_history_org FOREIGN KEY (owner_organisation_id) REFERENCES organisations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE aircraft_lease_history (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  aircraft_id INT UNSIGNED NOT NULL,
  lessor_organisation_id BIGINT UNSIGNED NOT NULL,
  lessee_airline_id INT UNSIGNED NOT NULL,
  lease_type VARCHAR(80) DEFAULT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  lease_status VARCHAR(80) DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  CONSTRAINT fk_lease_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft_registrations(id) ON DELETE CASCADE,
  CONSTRAINT fk_lease_lessor FOREIGN KEY (lessor_organisation_id) REFERENCES organisations(id) ON DELETE CASCADE,
  CONSTRAINT fk_lease_lessee FOREIGN KEY (lessee_airline_id) REFERENCES airlines(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE aircraft_cabin_configurations (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  aircraft_id INT UNSIGNED NOT NULL,
  airline_id INT UNSIGNED DEFAULT NULL,
  config_name VARCHAR(120) DEFAULT NULL,
  total_seats SMALLINT DEFAULT NULL,
  valid_from DATE DEFAULT NULL,
  valid_to DATE DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  CONSTRAINT fk_cabin_config_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft_registrations(id) ON DELETE CASCADE,
  CONSTRAINT fk_cabin_config_airline FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE aircraft_cabin_classes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cabin_configuration_id BIGINT UNSIGNED NOT NULL,
  cabin_class VARCHAR(80) NOT NULL,
  seat_count SMALLINT DEFAULT NULL,
  seat_pitch VARCHAR(40) DEFAULT NULL,
  seat_width VARCHAR(40) DEFAULT NULL,
  CONSTRAINT fk_cabin_class_config FOREIGN KEY (cabin_configuration_id) REFERENCES aircraft_cabin_configurations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE engine_manufacturers (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  organisation_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_engine_mfr_org FOREIGN KEY (organisation_id) REFERENCES organisations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE engine_models (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  manufacturer_id BIGINT UNSIGNED NOT NULL,
  family_name VARCHAR(120) DEFAULT NULL,
  model_name VARCHAR(120) NOT NULL,
  thrust_lbf INT DEFAULT NULL,
  engine_type VARCHAR(80) DEFAULT NULL,
  CONSTRAINT fk_engine_models_mfr FOREIGN KEY (manufacturer_id) REFERENCES engine_manufacturers(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE aircraft_engine_installations (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  aircraft_id INT UNSIGNED NOT NULL,
  engine_model_id BIGINT UNSIGNED NOT NULL,
  position VARCHAR(40) DEFAULT NULL,
  serial_number VARCHAR(120) DEFAULT NULL,
  installed_date DATE DEFAULT NULL,
  removed_date DATE DEFAULT NULL,
  CONSTRAINT fk_engine_install_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft_registrations(id) ON DELETE CASCADE,
  CONSTRAINT fk_engine_install_model FOREIGN KEY (engine_model_id) REFERENCES engine_models(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE airport_airline_roles (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airport_id INT UNSIGNED NOT NULL,
  airline_id INT UNSIGNED NOT NULL,
  role_type VARCHAR(80) NOT NULL,
  valid_from DATE DEFAULT NULL,
  valid_to DATE DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  INDEX idx_airport_airline_role (airport_id, airline_id, role_type),
  CONSTRAINT fk_airport_role_airport FOREIGN KEY (airport_id) REFERENCES airports(id) ON DELETE CASCADE,
  CONSTRAINT fk_airport_role_airline FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE route_markets (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  origin_airport_id INT UNSIGNED NOT NULL,
  destination_airport_id INT UNSIGNED NOT NULL,
  route_type VARCHAR(80) DEFAULT 'international',
  distance_km INT DEFAULT NULL,
  is_directional TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_route_market (origin_airport_id, destination_airport_id),
  CONSTRAINT fk_route_origin FOREIGN KEY (origin_airport_id) REFERENCES airports(id) ON DELETE CASCADE,
  CONSTRAINT fk_route_destination FOREIGN KEY (destination_airport_id) REFERENCES airports(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE airline_route_services (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  route_market_id BIGINT UNSIGNED NOT NULL,
  airline_id INT UNSIGNED NOT NULL,
  flight_number_prefix VARCHAR(20) DEFAULT NULL,
  service_type VARCHAR(80) DEFAULT 'scheduled passenger',
  status VARCHAR(60) DEFAULT 'active',
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  booking_url VARCHAR(500) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_route_service_airline (airline_id),
  CONSTRAINT fk_route_service_market FOREIGN KEY (route_market_id) REFERENCES route_markets(id) ON DELETE CASCADE,
  CONSTRAINT fk_route_service_airline FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE route_schedule_patterns (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airline_route_service_id BIGINT UNSIGNED NOT NULL,
  season VARCHAR(40) DEFAULT NULL,
  valid_from DATE DEFAULT NULL,
  valid_to DATE DEFAULT NULL,
  flight_number VARCHAR(30) DEFAULT NULL,
  departure_time_local TIME DEFAULT NULL,
  arrival_time_local TIME DEFAULT NULL,
  departure_terminal VARCHAR(60) DEFAULT NULL,
  arrival_terminal VARCHAR(60) DEFAULT NULL,
  operating_days VARCHAR(20) DEFAULT NULL,
  frequency_per_week TINYINT DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  CONSTRAINT fk_schedule_service FOREIGN KEY (airline_route_service_id) REFERENCES airline_route_services(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE route_schedule_days (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  schedule_pattern_id BIGINT UNSIGNED NOT NULL,
  day_of_week TINYINT NOT NULL,
  CONSTRAINT fk_schedule_days_pattern FOREIGN KEY (schedule_pattern_id) REFERENCES route_schedule_patterns(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE route_service_equipment (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airline_route_service_id BIGINT UNSIGNED NOT NULL,
  aircraft_type_id INT UNSIGNED DEFAULT NULL,
  aircraft_id INT UNSIGNED DEFAULT NULL,
  usage_type VARCHAR(80) DEFAULT 'scheduled',
  valid_from DATE DEFAULT NULL,
  valid_to DATE DEFAULT NULL,
  CONSTRAINT fk_route_equipment_service FOREIGN KEY (airline_route_service_id) REFERENCES airline_route_services(id) ON DELETE CASCADE,
  CONSTRAINT fk_route_equipment_type FOREIGN KEY (aircraft_type_id) REFERENCES aircraft_types(id) ON DELETE SET NULL,
  CONSTRAINT fk_route_equipment_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft_registrations(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE route_traffic_statistics (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  route_market_id BIGINT UNSIGNED NOT NULL,
  airline_id INT UNSIGNED DEFAULT NULL,
  period_type VARCHAR(20) NOT NULL DEFAULT 'year',
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  passengers INT DEFAULT NULL,
  seats INT DEFAULT NULL,
  cargo_tonnes DECIMAL(12,2) DEFAULT NULL,
  movements INT DEFAULT NULL,
  load_factor DECIMAL(5,2) DEFAULT NULL,
  traffic_basis VARCHAR(80) DEFAULT NULL,
  source_id BIGINT UNSIGNED DEFAULT NULL,
  CONSTRAINT fk_route_traffic_market FOREIGN KEY (route_market_id) REFERENCES route_markets(id) ON DELETE CASCADE,
  CONSTRAINT fk_route_traffic_airline FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- Evidence, source control and change history
-- -----------------------------------------------------------------------------
CREATE TABLE sources (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  source_name VARCHAR(190) NOT NULL,
  source_type VARCHAR(80) NOT NULL,
  base_url VARCHAR(500) DEFAULT NULL,
  reliability_score DECIMAL(5,2) DEFAULT NULL,
  licence_notes TEXT DEFAULT NULL,
  scraping_allowed TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE source_records (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  source_id BIGINT UNSIGNED NOT NULL,
  entity_type VARCHAR(100) NOT NULL,
  entity_id BIGINT UNSIGNED NOT NULL,
  url VARCHAR(500) DEFAULT NULL,
  title VARCHAR(255) DEFAULT NULL,
  retrieved_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  raw_hash CHAR(64) DEFAULT NULL,
  raw_text MEDIUMTEXT DEFAULT NULL,
  screenshot_path VARCHAR(500) DEFAULT NULL,
  CONSTRAINT fk_source_records_source FOREIGN KEY (source_id) REFERENCES sources(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE entity_change_log (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  entity_type VARCHAR(100) NOT NULL,
  entity_id BIGINT UNSIGNED NOT NULL,
  field_name VARCHAR(120) NOT NULL,
  old_value TEXT DEFAULT NULL,
  new_value TEXT DEFAULT NULL,
  changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  changed_by_user_id BIGINT UNSIGNED DEFAULT NULL,
  change_source VARCHAR(100) DEFAULT 'manual',
  source_record_id BIGINT UNSIGNED DEFAULT NULL,
  confidence_score DECIMAL(5,2) DEFAULT NULL,
  INDEX idx_change_entity (entity_type, entity_id),
  CONSTRAINT fk_change_user FOREIGN KEY (changed_by_user_id) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_change_source_record FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------------------------------
-- Data Reports (user-submitted feedback on data accuracy)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS data_reports (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  entity_type VARCHAR(80) DEFAULT NULL,
  entity_id VARCHAR(80) DEFAULT NULL,
  page_url TEXT DEFAULT NULL,
  report_type ENUM('wrong','old','other') NOT NULL DEFAULT 'other',
  description TEXT NOT NULL,
  contact_info VARCHAR(255) DEFAULT NULL,
  reporter_ip VARCHAR(45) DEFAULT NULL,
  status ENUM('open','in_progress','resolved','dismissed') NOT NULL DEFAULT 'open',
  admin_notes TEXT DEFAULT NULL,
  resolved_by INT UNSIGNED DEFAULT NULL,
  resolved_at DATETIME DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_reports_status (status),
  INDEX idx_reports_entity (entity_type, entity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS email_providers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  provider_type VARCHAR(40) NOT NULL,
  api_key TEXT DEFAULT NULL,
  api_secret TEXT DEFAULT NULL,
  config_json TEXT DEFAULT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 0,
  is_default TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS email_queue (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  recipient_email VARCHAR(255) NOT NULL,
  subject VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  status ENUM('pending','sent','failed') NOT NULL DEFAULT 'pending',
  provider_used VARCHAR(40) DEFAULT NULL,
  error_message TEXT DEFAULT NULL,
  sent_at DATETIME DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_email_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------------------------------
-- Angani Data 100% readiness extension: admin CRUD, imports, reference, commercial,
-- infrastructure, IATA/IOSA, GDS, airport details and aircraft type intelligence.
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS import_batches (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  batch_name VARCHAR(190) NOT NULL,
  source_file VARCHAR(512) DEFAULT NULL,
  module_key VARCHAR(120) DEFAULT NULL,
  status ENUM('pending','running','completed','failed','needs_review') NOT NULL DEFAULT 'pending',
  rows_total INT NOT NULL DEFAULT 0,
  rows_imported INT NOT NULL DEFAULT 0,
  rows_failed INT NOT NULL DEFAULT 0,
  started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  finished_at DATETIME DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_by BIGINT UNSIGNED DEFAULT NULL,
  INDEX idx_import_module (module_key),
  INDEX idx_import_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS staging_import_records (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  import_batch_id BIGINT UNSIGNED NOT NULL,
  module_key VARCHAR(120) NOT NULL,
  source_row_number INT DEFAULT NULL,
  status ENUM('pending','accepted','rejected','duplicate','conflict','needs_review') NOT NULL DEFAULT 'pending',
  row_json LONGTEXT NOT NULL,
  issue_summary TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_stage_batch (import_batch_id),
  INDEX idx_stage_module (module_key),
  INDEX idx_stage_status (status),
  CONSTRAINT fk_stage_batch FOREIGN KEY (import_batch_id) REFERENCES import_batches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS export_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED DEFAULT NULL,
  module_key VARCHAR(120) NOT NULL,
  filters_json LONGTEXT DEFAULT NULL,
  rows_exported INT NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_export_user (user_id),
  INDEX idx_export_module (module_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS admin_tasks (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(120) NOT NULL,
  task_title VARCHAR(255) NOT NULL,
  description TEXT DEFAULT NULL,
  status ENUM('pending','in_progress','done','blocked') NOT NULL DEFAULT 'pending',
  priority ENUM('low','medium','high','critical') NOT NULL DEFAULT 'medium',
  sort_order INT NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_digital_properties (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  airline_name VARCHAR(255) DEFAULT NULL,
  category VARCHAR(120) DEFAULT NULL,
  platform VARCHAR(120) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  url_or_handle TEXT DEFAULT NULL,
  is_primary TINYINT(1) NOT NULL DEFAULT 0,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airline_digital_codes (iata_code, icao_code),
  FULLTEXT KEY ft_airline_digital (airline_name, category, platform, description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_fleet_list (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  registration VARCHAR(80) DEFAULT NULL,
  msn VARCHAR(120) DEFAULT NULL,
  aircraft_model VARCHAR(190) DEFAULT NULL,
  aircraft_subtype VARCHAR(190) DEFAULT NULL,
  delivery_date VARCHAR(80) DEFAULT NULL,
  operator_airline VARCHAR(255) DEFAULT NULL,
  current_status VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_fleet_registration (registration),
  FULLTEXT KEY ft_fleet_list (registration, msn, aircraft_model, aircraft_subtype, operator_airline)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_fleet_summary (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  aircraft_type VARCHAR(190) DEFAULT NULL,
  aircraft_count INT DEFAULT NULL,
  configuration_lopa VARCHAR(190) DEFAULT NULL,
  average_age DECIMAL(8,2) DEFAULT NULL,
  engine_type VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_fleet_summary_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_hubs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  airport_code VARCHAR(16) DEFAULT NULL,
  hub_type VARCHAR(120) DEFAULT NULL,
  region_served VARCHAR(190) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airline_hubs_codes (iata_code, icao_code, airport_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_it_infrastructure (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  system_category VARCHAR(120) DEFAULT NULL,
  system_name VARCHAR(190) DEFAULT NULL,
  provider VARCHAR(190) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_airline_it (system_category, system_name, provider, description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_key_personnel (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  person_name VARCHAR(255) DEFAULT NULL,
  title VARCHAR(255) DEFAULT NULL,
  category VARCHAR(120) DEFAULT NULL,
  email VARCHAR(190) DEFAULT NULL,
  phone VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_airline_people (person_name, title, category, email, phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_operational_stats (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  stat_year VARCHAR(20) DEFAULT NULL,
  pax_count BIGINT DEFAULT NULL,
  cargo_volume DECIMAL(18,2) DEFAULT NULL,
  revenue DECIMAL(18,2) DEFAULT NULL,
  ebit DECIMAL(18,2) DEFAULT NULL,
  staff_count INT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airline_stats_codes (iata_code, icao_code, stat_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_brand_assets (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  asset_category VARCHAR(120) DEFAULT NULL,
  asset_name VARCHAR(190) DEFAULT NULL,
  asset_value TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS frequent_flyer_programs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  airline_name VARCHAR(255) DEFAULT NULL,
  airline_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  program_name VARCHAR(190) DEFAULT NULL,
  tier_level VARCHAR(120) DEFAULT NULL,
  points_unit VARCHAR(120) DEFAULT NULL,
  website_url TEXT DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_ffp (airline_name, airline_code, program_name, points_unit, notes)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_digital_properties (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  category VARCHAR(120) DEFAULT NULL,
  platform VARCHAR(120) DEFAULT NULL,
  url_or_handle TEXT DEFAULT NULL,
  is_primary TINYINT(1) NOT NULL DEFAULT 0,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airport_digital_codes (icao_code, iata_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_frequencies (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  airport_ref VARCHAR(80) DEFAULT NULL,
  airport_ident VARCHAR(80) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  frequency_type VARCHAR(120) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  frequency_mhz DECIMAL(12,4) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_freq_airport (icao_code, iata_code, airport_ident),
  INDEX idx_freq_type (frequency_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_runways (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  runway_ident VARCHAR(40) DEFAULT NULL,
  length_ft INT DEFAULT NULL,
  width_ft INT DEFAULT NULL,
  surface VARCHAR(120) DEFAULT NULL,
  lighting VARCHAR(120) DEFAULT NULL,
  ils_frequency VARCHAR(80) DEFAULT NULL,
  pcr VARCHAR(20) DEFAULT NULL COMMENT 'Pavement Classification Rating',
  strip_length_ft INT DEFAULT NULL,
  strip_width_ft INT DEFAULT NULL,
  resa_length_ft INT DEFAULT NULL COMMENT 'Runway End Safety Area length',
  resa_width_ft INT DEFAULT NULL,
  ofz_length_ft INT DEFAULT NULL COMMENT 'Obstacle Free Zone length',
  ofz_width_ft INT DEFAULT NULL,
  stopway_length_ft INT DEFAULT NULL,
  clearway_length_ft INT DEFAULT NULL,
  shoulder_surface VARCHAR(120) DEFAULT NULL,
  runway_width_shoulders_ft INT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_runway_airport (icao_code, iata_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_terminals (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  terminal_type VARCHAR(120) DEFAULT NULL,
  terminal_name VARCHAR(190) DEFAULT NULL,
  capacity VARCHAR(120) DEFAULT NULL,
  facilities TEXT DEFAULT NULL,
  gates_count INT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_terminal_airport (icao_code, iata_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_services (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  service_category VARCHAR(120) DEFAULT NULL,
  provider VARCHAR(190) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_hubs_and_airlines (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  airline_name VARCHAR(255) DEFAULT NULL,
  relation VARCHAR(120) DEFAULT NULL,
  destinations_served TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_airport_hub_airlines (airline_name, relation, destinations_served)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_operational_stats (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  stat_year VARCHAR(20) DEFAULT NULL,
  pax_count BIGINT DEFAULT NULL,
  cargo_tonnes DECIMAL(18,2) DEFAULT NULL,
  movements BIGINT DEFAULT NULL,
  slot_status VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS navaids (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  source_navaid_id VARCHAR(80) DEFAULT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  navaid_type VARCHAR(120) DEFAULT NULL,
  identifier_code VARCHAR(80) DEFAULT NULL,
  navaid_name VARCHAR(255) DEFAULT NULL,
  latitude DECIMAL(12,7) DEFAULT NULL,
  longitude DECIMAL(12,7) DEFAULT NULL,
  elevation_ft INT DEFAULT NULL,
  country_name VARCHAR(190) DEFAULT NULL,
  region_fir VARCHAR(190) DEFAULT NULL,
  chart_reference VARCHAR(190) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_navaid_country (country_code),
  INDEX idx_navaid_ident (identifier_code),
  FULLTEXT KEY ft_navaids (navaid_type, identifier_code, navaid_name, country_name, region_fir)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS navaid_technical (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  source_navaid_id VARCHAR(80) DEFAULT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  frequency VARCHAR(80) DEFAULT NULL,
  channel_number VARCHAR(80) DEFAULT NULL,
  morse_code VARCHAR(80) DEFAULT NULL,
  signal_type VARCHAR(120) DEFAULT NULL,
  power_output VARCHAR(120) DEFAULT NULL,
  equipment_model VARCHAR(190) DEFAULT NULL,
  redundancy_systems TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_navtech_source (source_navaid_id, country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS navaid_operational (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  source_navaid_id VARCHAR(80) DEFAULT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  service_volume VARCHAR(120) DEFAULT NULL,
  range_nm DECIMAL(10,2) DEFAULT NULL,
  mag_variation VARCHAR(80) DEFAULT NULL,
  status VARCHAR(120) DEFAULT NULL,
  maintenance_authority VARCHAR(190) DEFAULT NULL,
  date_commissioned VARCHAR(80) DEFAULT NULL,
  last_inspection VARCHAR(80) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_navop_source (source_navaid_id, country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS navaid_connectivity (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  source_navaid_id VARCHAR(80) DEFAULT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  associated_airports TEXT DEFAULT NULL,
  associated_airways TEXT DEFAULT NULL,
  system_integration TEXT DEFAULT NULL,
  interoperability_notes TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS navaid_references (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  source_navaid_id VARCHAR(80) DEFAULT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  additional_notes TEXT DEFAULT NULL,
  data_sources TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notam_sources (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iso_country VARCHAR(8) DEFAULT NULL,
  country_name VARCHAR(190) DEFAULT NULL,
  official_source_name VARCHAR(255) DEFAULT NULL,
  notam_portal_url TEXT DEFAULT NULL,
  icao_nof_code VARCHAR(80) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  last_verified_at DATETIME DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_notam_source_country (iso_country)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notams (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  source_notam_id VARCHAR(80) DEFAULT NULL,
  country_code VARCHAR(8) DEFAULT NULL,
  series_number VARCHAR(120) DEFAULT NULL,
  notam_type VARCHAR(120) DEFAULT NULL,
  issuing_authority VARCHAR(190) DEFAULT NULL,
  summary TEXT DEFAULT NULL,
  raw_text LONGTEXT DEFAULT NULL,
  start_utc VARCHAR(80) DEFAULT NULL,
  end_utc VARCHAR(80) DEFAULT NULL,
  status VARCHAR(80) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_notams (series_number, notam_type, issuing_authority, summary, raw_text)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS regulatory_authorities (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL,
  abbreviation VARCHAR(80) DEFAULT NULL,
  jurisdiction TEXT DEFAULT NULL,
  hq_location VARCHAR(190) DEFAULT NULL,
  founding_year VARCHAR(40) DEFAULT NULL,
  governance_structure TEXT DEFAULT NULL,
  key_officials TEXT DEFAULT NULL,
  website TEXT DEFAULT NULL,
  official_register_link TEXT DEFAULT NULL,
  unofficial_register_link TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_reg_auth (name, abbreviation, jurisdiction, hq_location, key_officials)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS regulatory_economic_licensing (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  license_types TEXT DEFAULT NULL,
  foreign_ownership_limit TEXT DEFAULT NULL,
  cabotage_rights TEXT DEFAULT NULL,
  air_service_agreements TEXT DEFAULT NULL,
  market_access_policies TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS regulatory_operational_certification (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  aoc_registry TEXT DEFAULT NULL,
  authorized_aircraft TEXT DEFAULT NULL,
  operational_limits TEXT DEFAULT NULL,
  amo_mro_approvals TEXT DEFAULT NULL,
  ato_approvals TEXT DEFAULT NULL,
  renewal_dates TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS regulatory_licensing_categories (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iso_country VARCHAR(8) DEFAULT NULL,
  category VARCHAR(120) DEFAULT NULL,
  name VARCHAR(190) DEFAULT NULL,
  validity VARCHAR(120) DEFAULT NULL,
  cost VARCHAR(120) DEFAULT NULL,
  requirements TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS gds_systems (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  gds_code VARCHAR(32) DEFAULT NULL,
  company VARCHAR(190) DEFAULT NULL,
  region VARCHAR(120) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_gds (gds_code, company, region, notes)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS iata_membership_requirements (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  section VARCHAR(120) DEFAULT NULL,
  detail VARCHAR(255) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_iata_membership (section, detail, description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS iosa_registration_steps (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  step VARCHAR(120) DEFAULT NULL,
  action VARCHAR(255) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_iosa_steps (step, action, description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_iata_membership (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airline_name VARCHAR(255) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  membership_status VARCHAR(80) DEFAULT NULL,
  membership_type VARCHAR(120) DEFAULT NULL,
  joined_date VARCHAR(80) DEFAULT NULL,
  ended_date VARCHAR(80) DEFAULT NULL,
  source_url TEXT DEFAULT NULL,
  last_verified_at DATETIME DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airline_iosa_registration (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  airline_name VARCHAR(255) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iosa_status VARCHAR(80) DEFAULT NULL,
  registration_number VARCHAR(120) DEFAULT NULL,
  valid_from VARCHAR(80) DEFAULT NULL,
  valid_until VARCHAR(80) DEFAULT NULL,
  source_url TEXT DEFAULT NULL,
  last_verified_at DATETIME DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS aircraft_type_profile_data (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  aircraft_name VARCHAR(255) DEFAULT NULL,
  country_of_origin VARCHAR(190) DEFAULT NULL,
  aircraft_role VARCHAR(190) DEFAULT NULL,
  powerplants TEXT DEFAULT NULL,
  performance TEXT DEFAULT NULL,
  weights TEXT DEFAULT NULL,
  dimensions TEXT DEFAULT NULL,
  capacity TEXT DEFAULT NULL,
  production TEXT DEFAULT NULL,
  history LONGTEXT DEFAULT NULL,
  source_url TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FULLTEXT KEY ft_aircraft_profile (aircraft_name, country_of_origin, aircraft_role, powerplants, performance, history)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_assets (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  primary_livery_url TEXT DEFAULT NULL,
  lopa_template_url TEXT DEFAULT NULL,
  cockpit_reference_url TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acasset_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_cabin_payload (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  typical_c_seats INT DEFAULT NULL,
  typical_y_seats INT DEFAULT NULL,
  max_capacity INT DEFAULT NULL,
  cargo_volume_m3 DECIMAL(12,2) DEFAULT NULL,
  max_payload_kg DECIMAL(12,2) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_accabin_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_economic_data (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  list_price_usd DECIMAL(18,2) DEFAULT NULL,
  op_cost_per_hour DECIMAL(18,2) DEFAULT NULL,
  lease_rate_monthly DECIMAL(18,2) DEFAULT NULL,
  residual_value_trend VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acecon_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_engine_data (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  engine_variants TEXT DEFAULT NULL,
  engine_type VARCHAR(120) DEFAULT NULL,
  engine_count INT DEFAULT NULL,
  thrust_per_engine_kn DECIMAL(12,2) DEFAULT NULL,
  fuel_burn_rate VARCHAR(120) DEFAULT NULL,
  saf_compatible VARCHAR(40) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acengine_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_environmental_data (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  carbon_intensity VARCHAR(120) DEFAULT NULL,
  noise_chapter VARCHAR(120) DEFAULT NULL,
  fuel_type VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acenv_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_manufacturer_support (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  production_start VARCHAR(80) DEFAULT NULL,
  production_end VARCHAR(80) DEFAULT NULL,
  total_built INT DEFAULT NULL,
  mro_availability TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acms_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_operational_performance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  max_range_nm DECIMAL(12,2) DEFAULT NULL,
  service_ceiling_ft INT DEFAULT NULL,
  v1 VARCHAR(40) DEFAULT NULL,
  vr VARCHAR(40) DEFAULT NULL,
  v2 VARCHAR(40) DEFAULT NULL,
  vref VARCHAR(40) DEFAULT NULL,
  cruise_speed_mach VARCHAR(40) DEFAULT NULL,
  max_speed VARCHAR(80) DEFAULT NULL,
  climb_rate VARCHAR(80) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acperf_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_runway_requirements (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  min_takeoff_length_ft INT DEFAULT NULL,
  min_landing_length_ft INT DEFAULT NULL,
  surface_compatibility TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acrun_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_type_technical_specs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(16) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  mtow_kg DECIMAL(12,2) DEFAULT NULL,
  mzfw_kg DECIMAL(12,2) DEFAULT NULL,
  empty_weight_kg DECIMAL(12,2) DEFAULT NULL,
  wingspan_m DECIMAL(12,2) DEFAULT NULL,
  length_m DECIMAL(12,2) DEFAULT NULL,
  height_m DECIMAL(12,2) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acts_codes (iata_code, icao_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_models (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  model_id VARCHAR(80) DEFAULT NULL,
  model_name VARCHAR(255) DEFAULT NULL,
  origin VARCHAR(190) DEFAULT NULL,
  role VARCHAR(190) DEFAULT NULL,
  iata_type_ref VARCHAR(16) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_acmodel_id (model_id),
  FULLTEXT KEY ft_acmodels (model_name, origin, role, iata_type_ref)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_model_history (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  model_id VARCHAR(80) DEFAULT NULL,
  development_story LONGTEXT DEFAULT NULL,
  milestones LONGTEXT DEFAULT NULL,
  status VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_model_history_id (model_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_model_capacity (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  model_id VARCHAR(80) DEFAULT NULL,
  seating_config TEXT DEFAULT NULL,
  cargo_vol TEXT DEFAULT NULL,
  configurations TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_model_cap_id (model_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_model_specs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  model_id VARCHAR(80) DEFAULT NULL,
  powerplant_desc TEXT DEFAULT NULL,
  weights TEXT DEFAULT NULL,
  dimensions TEXT DEFAULT NULL,
  performance TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_model_specs_id (model_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_model_production (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  model_id VARCHAR(80) DEFAULT NULL,
  units_built VARCHAR(80) DEFAULT NULL,
  production_years VARCHAR(120) DEFAULT NULL,
  price_usd VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_model_prod_id (model_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_model_sources (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  model_id VARCHAR(80) DEFAULT NULL,
  source_url TEXT DEFAULT NULL,
  bibliography TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_model_source_id (model_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS airport_financial_performance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  stat_year VARCHAR(20) DEFAULT NULL,
  revenue DECIMAL(18,2) DEFAULT NULL,
  profit_loss DECIMAL(18,2) DEFAULT NULL,
  investment DECIMAL(18,2) DEFAULT NULL,
  staff_count INT DEFAULT NULL,
  ownership_structure TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airport_fin_codes (icao_code, iata_code, country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_ground_handling (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  company VARCHAR(190) DEFAULT NULL,
  categories TEXT DEFAULT NULL,
  contract_info TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airport_gh_codes (icao_code, iata_code, country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_ground_transport (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  transport_mode VARCHAR(120) DEFAULT NULL,
  provider VARCHAR(190) DEFAULT NULL,
  link_description TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airport_gt_codes (icao_code, iata_code, country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_it_infrastructure (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  category VARCHAR(120) DEFAULT NULL,
  system_name VARCHAR(190) DEFAULT NULL,
  provider VARCHAR(190) DEFAULT NULL,
  innovation_notes TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airport_it_codes (icao_code, iata_code, country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS airport_key_personnel (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  icao_code VARCHAR(16) DEFAULT NULL,
  iata_code VARCHAR(16) DEFAULT NULL,
  person_name VARCHAR(190) DEFAULT NULL,
  title VARCHAR(190) DEFAULT NULL,
  category VARCHAR(120) DEFAULT NULL,
  contact TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_airport_people_codes (icao_code, iata_code, country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS regulatory_environmental_security (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  corsia_status TEXT DEFAULT NULL,
  emissions_programs TEXT DEFAULT NULL,
  noise_regulations TEXT DEFAULT NULL,
  security_program TEXT DEFAULT NULL,
  cybersecurity_oversight TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_reg_env_country (country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS regulatory_references (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  additional_notes TEXT DEFAULT NULL,
  data_sources TEXT DEFAULT NULL,
  cross_links TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_reg_ref_country (country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS regulatory_safety_oversight (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  global_programs TEXT DEFAULT NULL,
  usoap_scores TEXT DEFAULT NULL,
  national_programs TEXT DEFAULT NULL,
  accident_authority TEXT DEFAULT NULL,
  icao_annexes TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_reg_safety_country (country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notam_classification (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  source_notam_id VARCHAR(80) DEFAULT NULL,
  subject_code VARCHAR(80) DEFAULT NULL,
  modifier_code VARCHAR(80) DEFAULT NULL,
  traffic_code VARCHAR(80) DEFAULT NULL,
  purpose_code VARCHAR(80) DEFAULT NULL,
  scope VARCHAR(120) DEFAULT NULL,
  issuing_nof VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_notam_class_source (country_code, source_notam_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notam_content (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  source_notam_id VARCHAR(80) DEFAULT NULL,
  raw_text LONGTEXT DEFAULT NULL,
  cleaned_text LONGTEXT DEFAULT NULL,
  flight_level_limits VARCHAR(120) DEFAULT NULL,
  affected_area_radius VARCHAR(120) DEFAULT NULL,
  restriction_type VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_notam_content_source (country_code, source_notam_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notam_schedule (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  source_notam_id VARCHAR(80) DEFAULT NULL,
  start_utc VARCHAR(80) DEFAULT NULL,
  end_utc VARCHAR(80) DEFAULT NULL,
  schedule_notes TEXT DEFAULT NULL,
  perm_temp_flag VARCHAR(80) DEFAULT NULL,
  date_issued VARCHAR(80) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_notam_schedule_source (country_code, source_notam_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notam_connectivity (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  source_notam_id VARCHAR(80) DEFAULT NULL,
  associated_airports TEXT DEFAULT NULL,
  associated_navaids TEXT DEFAULT NULL,
  associated_airways TEXT DEFAULT NULL,
  affected_procedures TEXT DEFAULT NULL,
  interoperability_notes TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_notam_conn_source (country_code, source_notam_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notam_references (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  source_notam_id VARCHAR(80) DEFAULT NULL,
  additional_notes TEXT DEFAULT NULL,
  data_sources TEXT DEFAULT NULL,
  replacement_reference TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_notam_ref_source (country_code, source_notam_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ref_country_codes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_name VARCHAR(190) DEFAULT NULL,
  alpha_2 VARCHAR(8) DEFAULT NULL,
  alpha_3 VARCHAR(8) DEFAULT NULL,
  numeric_code VARCHAR(8) DEFAULT NULL,
  aircraft_prefix VARCHAR(80) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_ref_country_alpha2 (alpha_2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ref_service_types (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  service_type_code VARCHAR(20) DEFAULT NULL,
  application VARCHAR(120) DEFAULT NULL,
  type_of_operation VARCHAR(120) DEFAULT NULL,
  service_type VARCHAR(190) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ref_meal_service_codes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(40) DEFAULT NULL,
  meaning VARCHAR(255) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ref_booking_classes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(120) DEFAULT NULL,
  class_code VARCHAR(20) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  class_type VARCHAR(120) DEFAULT NULL,
  rank_order INT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_booking_class_code (class_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ref_passenger_terminal_codes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(40) DEFAULT NULL,
  meaning VARCHAR(255) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ref_reject_reasons (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  reject_reason TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ref_phonetic_alphabet (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  character_code VARCHAR(20) DEFAULT NULL,
  phonetic VARCHAR(120) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS commercial_fares (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fare_id VARCHAR(120) DEFAULT NULL,
  airline_code VARCHAR(16) DEFAULT NULL,
  flight_number_schedule_id VARCHAR(120) DEFAULT NULL,
  origin_iata VARCHAR(16) DEFAULT NULL,
  destination_iata VARCHAR(16) DEFAULT NULL,
  date_seasonality VARCHAR(120) DEFAULT NULL,
  base_fare DECIMAL(18,2) DEFAULT NULL,
  total_fare DECIMAL(18,2) DEFAULT NULL,
  currency_code VARCHAR(8) DEFAULT NULL,
  snapshot_date DATE DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_fares_market (origin_iata, destination_iata, airline_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS commercial_fare_inventory (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fare_id VARCHAR(120) DEFAULT NULL,
  cabin_class VARCHAR(120) DEFAULT NULL,
  fare_family VARCHAR(120) DEFAULT NULL,
  booking_class_code_rbd VARCHAR(20) DEFAULT NULL,
  baggage_allowance VARCHAR(190) DEFAULT NULL,
  ancillary_services TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS commercial_fare_rules (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fare_id VARCHAR(120) DEFAULT NULL,
  refundability VARCHAR(120) DEFAULT NULL,
  change_fees VARCHAR(120) DEFAULT NULL,
  advance_purchase_requirement_days INT DEFAULT NULL,
  min_stay VARCHAR(120) DEFAULT NULL,
  max_stay VARCHAR(120) DEFAULT NULL,
  blackout_dates_restrictions TEXT DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS commercial_taxes_fees (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fare_id VARCHAR(120) DEFAULT NULL,
  surcharge_yq_yr DECIMAL(18,2) DEFAULT NULL,
  airport_taxes DECIMAL(18,2) DEFAULT NULL,
  government_taxes DECIMAL(18,2) DEFAULT NULL,
  other_fees DECIMAL(18,2) DEFAULT NULL,
  total_taxes_fees DECIMAL(18,2) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS commercial_yield_analysis (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fare_id VARCHAR(120) DEFAULT NULL,
  yield_per_km_cpk DECIMAL(18,4) DEFAULT NULL,
  revenue_per_passenger DECIMAL(18,2) DEFAULT NULL,
  load_factor_impact VARCHAR(120) DEFAULT NULL,
  competitor_benchmark TEXT DEFAULT NULL,
  price_gap_vs_competitor DECIMAL(18,2) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS country_fare_policies (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country_code VARCHAR(8) DEFAULT NULL,
  carrier_code VARCHAR(16) DEFAULT NULL,
  avg_domestic_yield DECIMAL(18,4) DEFAULT NULL,
  avg_intl_yield DECIMAL(18,4) DEFAULT NULL,
  tax_policy TEXT DEFAULT NULL,
  currency_standard VARCHAR(16) DEFAULT NULL,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aircraft_manufacturers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  legal_name VARCHAR(255) DEFAULT NULL,
  organisation_type VARCHAR(80) DEFAULT NULL,
  industry VARCHAR(255) DEFAULT NULL,
  headquarters VARCHAR(255) DEFAULT NULL,
  founded_year SMALLINT UNSIGNED DEFAULT NULL,
  ceased_year SMALLINT UNSIGNED DEFAULT NULL,
  key_people TEXT DEFAULT NULL,
  products TEXT DEFAULT NULL,
  employee_count VARCHAR(60) DEFAULT NULL,
  website VARCHAR(500) DEFAULT NULL,
  logo_url VARCHAR(500) DEFAULT NULL,
  is_active ENUM('Yes','No','Unknown') DEFAULT 'Unknown',
  status VARCHAR(80) DEFAULT NULL,
  fate TEXT DEFAULT NULL,
  parent_manufacturer_id INT UNSIGNED DEFAULT NULL,
  predecessor_manufacturer_id INT UNSIGNED DEFAULT NULL,
  successor_manufacturer_id INT UNSIGNED DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_am_name (name),
  INDEX idx_am_active (is_active),
  CONSTRAINT fk_am_parent FOREIGN KEY (parent_manufacturer_id) REFERENCES aircraft_manufacturers(id) ON DELETE SET NULL,
  CONSTRAINT fk_am_predecessor FOREIGN KEY (predecessor_manufacturer_id) REFERENCES aircraft_manufacturers(id) ON DELETE SET NULL,
  CONSTRAINT fk_am_successor FOREIGN KEY (successor_manufacturer_id) REFERENCES aircraft_manufacturers(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ref_timezones (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  continent VARCHAR(40) DEFAULT NULL,
  timezone_name VARCHAR(120) NOT NULL,
  utc_offset VARCHAR(40) DEFAULT NULL,
  dst_info VARCHAR(80) DEFAULT NULL,
  has_dst TINYINT(1) NOT NULL DEFAULT 0,
  last_modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_tz_continent (continent),
  INDEX idx_tz_name (timezone_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
-- =============================================================================
-- Migration: Site content management & data quality tracking
-- site_pages – editable static pages (terms, privacy, beta-status, etc.)
-- site_slides – homepage hero slider configuration
-- record_verifications – user completeness/accuracy markings per record
-- =============================================================================

CREATE TABLE IF NOT EXISTS site_pages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  page_key VARCHAR(80) NOT NULL UNIQUE,
  title VARCHAR(255) NOT NULL,
  content LONGTEXT DEFAULT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO site_pages (page_key, title, content) VALUES
('terms','Terms and Conditions','<h2>Terms and Conditions</h2><p>The data provided through the Aviation Intelligence Atlas is furnished on an "as is" basis. Angani Solutions makes no warranties, express or implied, regarding the accuracy, completeness, reliability, or timeliness of any data presented. Users rely on the data at their own risk. Angani Solutions shall not be held liable for any inaccuracies, omissions, errors, or any damages arising from the use of this platform.</p><p>By accessing this platform, you agree to these terms. All data is for informational purposes only and should not be used as the sole basis for operational, financial, or safety-critical decisions. Always cross-reference with official sources and national aviation authorities.</p>'),
('privacy','Privacy Policy','<h2>Privacy Policy</h2><p>Angani Solutions is committed to protecting your privacy. Any personal data you provide to us — including your name, email address, and organisation details — will be stored securely and processed in accordance with the UK General Data Protection Regulation (UK GDPR) and the Data Protection Act 2018.</p><p>We collect only the information necessary to provide you with access to the Aviation Intelligence Atlas platform. Your data will not be sold, traded, or shared with third parties for marketing purposes. We implement appropriate technical and organisational measures to safeguard your information against unauthorised access, alteration, disclosure, or destruction.</p><p>You have the right to request access to, correction of, or deletion of your personal data at any time by contacting us. We retain your data only as long as necessary to provide our services or as required by law.</p>'),
('beta-status','Beta Status','<h2>Beta Status — Aviation Intelligence Atlas</h2><p>The Aviation Intelligence Atlas is currently in beta. This means the platform is still a work in progress and may contain errors, omissions, incomplete datasets, and unverified information. We are actively working to improve data quality and expand coverage.</p><p>While we strive for accuracy, some records may be incomplete or based on sources that have not yet been fully validated. We encourage users to check the <a href="?page=data-quality">Data Quality page</a> for the current verification and completeness status of individual datasets before relying on any specific data point.</p><p>Your feedback is invaluable. If you encounter any issues or have suggestions, please use the "Report Data Problem" feature available on every record or contact our support team directly.</p><p>Thank you for being part of our beta programme.</p>');

CREATE TABLE IF NOT EXISTS site_slides (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  slide_key VARCHAR(80) DEFAULT NULL,
  title VARCHAR(255) NOT NULL,
  subtitle VARCHAR(255) DEFAULT NULL,
  image_url VARCHAR(500) DEFAULT NULL,
  stat_label VARCHAR(120) DEFAULT NULL,
  stat_value VARCHAR(40) DEFAULT NULL,
  link_url VARCHAR(500) DEFAULT NULL,
  display_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_slides_order (display_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO site_slides (slide_key, title, subtitle, image_url, stat_label, link_url, display_order) VALUES
('airlines','Active Airlines','Browse our comprehensive airline registry with fleet details and operational status.','http://43.134.34.14/assets/site_images/airlines.webp','airlines','?page=catalogue&module=airlines',1),
('aircraft_types','Aircraft Types','Explore detailed specifications for aircraft models across all manufacturers.','http://43.134.34.14/assets/site_images/plane.gif','aircraft_types','?page=catalogue&module=aircraft_types',2),
('airport_aips','Airport AIPs','Access aerodrome information publications with full AD 2.x data.','http://43.134.34.14/assets/site_images/navigation.gif','airports','?page=catalogue&module=airports',3);

CREATE TABLE IF NOT EXISTS record_verifications (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  entity_type VARCHAR(80) NOT NULL,
  entity_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED DEFAULT NULL,
  completeness ENUM('complete','incomplete') DEFAULT NULL,
  accuracy ENUM('accurate','inaccurate','unverified') DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_verification (entity_type, entity_id, user_id),
  INDEX idx_verification_type (entity_type, entity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
