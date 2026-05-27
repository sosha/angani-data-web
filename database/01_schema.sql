SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
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
CREATE TABLE airlines (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,source_scope VARCHAR(40) DEFAULT NULL,country_code VARCHAR(8) DEFAULT NULL,region VARCHAR(80) DEFAULT NULL,name VARCHAR(255) NOT NULL,iata_code VARCHAR(16) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,prefix VARCHAR(32) DEFAULT NULL,callsign VARCHAR(120) DEFAULT NULL,fleet_size INT DEFAULT NULL,destinations_count INT DEFAULT NULL,logo_url TEXT DEFAULT NULL,wikipedia_url TEXT DEFAULT NULL,website_url TEXT DEFAULT NULL,status VARCHAR(80) DEFAULT NULL,status_bucket ENUM('active','defunct','unknown') NOT NULL DEFAULT 'unknown',source_url TEXT DEFAULT NULL,founded VARCHAR(80) DEFAULT NULL,hubs TEXT DEFAULT NULL,alliance VARCHAR(120) DEFAULT NULL,parent_company VARCHAR(190) DEFAULT NULL,record_status VARCHAR(80) DEFAULT NULL,date_added VARCHAR(32) DEFAULT NULL,date_modified VARCHAR(32) DEFAULT NULL,data_source VARCHAR(120) DEFAULT NULL,FULLTEXT KEY ft_airlines (name, callsign, iata_code, icao_code, alliance, hubs, parent_company),INDEX idx_airlines_status (status_bucket),INDEX idx_airlines_country (country_code),INDEX idx_airlines_region (region),INDEX idx_airlines_icao (icao_code),INDEX idx_airlines_iata (iata_code)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE aircraft_registrations (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,country_code VARCHAR(8) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,aircraft_type VARCHAR(190) DEFAULT NULL,registration VARCHAR(80) DEFAULT NULL,adshex VARCHAR(80) DEFAULT NULL,type_code VARCHAR(80) DEFAULT NULL,construction_number VARCHAR(120) DEFAULT NULL,age DECIMAL(8,2) DEFAULT NULL,operator_icao VARCHAR(16) DEFAULT NULL,operator_name VARCHAR(190) DEFAULT NULL,record_status VARCHAR(80) DEFAULT NULL,date_added VARCHAR(32) DEFAULT NULL,date_modified VARCHAR(32) DEFAULT NULL,data_source VARCHAR(120) DEFAULT NULL,FULLTEXT KEY ft_aircraft (aircraft_type, registration, icao_code, operator_icao, operator_name, type_code),INDEX idx_aircraft_country (country_code),INDEX idx_aircraft_icao (icao_code),INDEX idx_aircraft_operator (operator_icao),INDEX idx_aircraft_type (aircraft_type)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE aircraft_types (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,aircraft_type VARCHAR(190) DEFAULT NULL,common_name VARCHAR(190) DEFAULT NULL,full_designation VARCHAR(190) DEFAULT NULL,manufacturer VARCHAR(190) DEFAULT NULL,model VARCHAR(190) DEFAULT NULL,iata_code VARCHAR(16) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,engine_type VARCHAR(80) DEFAULT NULL,engine_count INT DEFAULT NULL,max_pax INT DEFAULT NULL,range_km DECIMAL(12,2) DEFAULT NULL,mtow_kg DECIMAL(12,2) DEFAULT NULL,status VARCHAR(120) DEFAULT NULL,record_status VARCHAR(80) DEFAULT NULL,source_url TEXT DEFAULT NULL,FULLTEXT KEY ft_aircraft_types (aircraft_type, common_name, full_designation, manufacturer, model, iata_code, icao_code),INDEX idx_type_icao (icao_code),INDEX idx_type_iata (iata_code),INDEX idx_type_manufacturer (manufacturer)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE airports (id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,country_code VARCHAR(8) DEFAULT NULL,iata_code VARCHAR(16) DEFAULT NULL,icao_code VARCHAR(16) DEFAULT NULL,airport_name VARCHAR(255) DEFAULT NULL,city_name VARCHAR(190) DEFAULT NULL,latitude DECIMAL(12,7) DEFAULT NULL,longitude DECIMAL(12,7) DEFAULT NULL,elevation_ft INT DEFAULT NULL,slot_coordination_level VARCHAR(80) DEFAULT NULL,status VARCHAR(80) DEFAULT NULL,last_updated VARCHAR(80) DEFAULT NULL,FULLTEXT KEY ft_airports (airport_name, city_name, iata_code, icao_code),INDEX idx_airports_country (country_code),INDEX idx_airports_iata (iata_code),INDEX idx_airports_icao (icao_code)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
-- Normalised aviation entities layered on top of the current source tables
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
  organisation_id BIGINT UNSIGNED NOT NULL,
  headquarters_country_code VARCHAR(8) DEFAULT NULL,
  fleet_count INT DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_lessors_org FOREIGN KEY (organisation_id) REFERENCES organisations(id) ON DELETE CASCADE,
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
