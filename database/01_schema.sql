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
