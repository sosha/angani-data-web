# Database Schema Overview

**Database**: `angani_data` (utf8mb4 charset)  
**Server**: MySQL 8.x on `43.134.34.14:3306`  
**Connection**: PHP PDO via `includes/db.php` / `includes/config.php`

## Schema Evolution

### V1 (Original)
- Tables: `countries`, `airlines`, `airports`, `aircraft_types`, `aircraft_registrations`, `users`, `subscription_tiers`
- Schema file: `database/01_schema.sql`

### V2 (Migration)
- Renames V1 tables to `legacy_*` prefix
- Creates new tables with updated schemas (e.g., `countries` with `iso_alpha_2` as PK)
- Adds: pipeline tables, audit logs, provenance, stats, time series
- Files: `database/02_v2_migration.sql` through `database/11_country_enhancements.sql`

### V3 (Extension -- current)
- Extended tables for airline/airport/aircraft/regulatory/commercial intelligence
- Platform tables: questions, insights, data reports, email, backup, mirror
- Mostly in `database/01_schema.sql` (single CREATE TABLE for all)

## Table Categories

### Core (authentication + platform)
| Table | Engine | PK | Notes |
|-------|--------|----|-------|
| `users` | InnoDB | `id` BIGINT AUTO | `email` UNIQUE, `tier_id` FK, `role` ENUM(user/admin) |
| `subscription_tiers` | InnoDB | `id` INT AUTO | `code` UNIQUE (free/pro/ultimate) |
| `tier_features` | InnoDB | `id` INT AUTO | `tier_id` FK, `feature_code` |
| `question_presets` | InnoDB | `id` INT AUTO | `code` UNIQUE, `answer_key`, `required_tier_id` FK |
| `insight_cards` | InnoDB | `id` INT AUTO | `query_key`, `required_tier_id` FK |
| `data_reports` | InnoDB | `id` INT AUTO | Entity type + ID, status workflow |
| `data_audit_log` | InnoDB | `id` BIGINT AUTO | Table, record ID, action, old/new JSON |
| `data_table_provenance` | InnoDB | `table_name` PK | Collection method, source URL, license FK |
| `data_licenses` | InnoDB | `id` INT AUTO | `name` UNIQUE, commercial use flag |
| `email_providers` | InnoDB | `id` INT AUTO | Provider type, API key, is_default |
| `email_queue` | InnoDB | `id` INT AUTO | To, subject, body, status, sent_at |
| `admin_tasks` | InnoDB | `id` INT AUTO | Category, status, priority, notes |

### Core (geography + transport)
| Table | PK | Key Indexes | Records |
|-------|----|-------------|---------|
| `countries` | `iso_alpha_2` VARCHAR(6) | INDEX on continent, un_region | 253 |
| `airlines` | `icao_code` VARCHAR(16) | INDEX on iata_code, country_code, status_bucket | 9,202 |
| `airports` | `ident` VARCHAR(20) | INDEX on iso_country, type, iata_code | 84,146 |
| `aircraft_types` | `icao_code` VARCHAR(16) | INDEX on iata_code, manufacturer | 345 |
| `aircraft_registrations` | `id` BIGINT AUTO | INDEX on registration, country_code, operator_icao | 35,522 |
| `aircraft_manufacturers` | `name` VARCHAR(128) | INDEX on is_active | 522 |
| `aircraft_models` | `model_id` VARCHAR(64) | INDEX on iata_type_ref | 742 |

### Airline Intelligence
| Table | Join Fields | Records |
|-------|-------------|---------|
| `airline_digital_properties` | iata_code, icao_code | 6,796 |
| `frequent_flyer_programs` | airline_code, iata_code, icao_code | 394 |
| `airline_fleet_list` | operator_airline (LIKE on name) | 0 |
| `airline_fleet_summary` | iata_code, icao_code | 1,090 |
| `airline_hubs` | iata_code, icao_code | 222 |
| `airline_it_infrastructure` | iata_code, icao_code | 0 |
| `airline_key_personnel` | iata_code, icao_code | 0 |
| `airline_operational_stats` | iata_code, icao_code | 0 |
| `airline_iata_membership` | iata_code, icao_code | 0 |
| `airline_iosa_registration` | iata_code, icao_code | 0 |
| `airline_destinations` | iata_code, icao_code | 290 |
| `airline_route_services` | airline_id | 0 |

### Airport & Infrastructure
| Table | Join Fields | Records |
|-------|-------------|---------|
| `airport_frequencies` | airport_ident, iata_code, icao_code | 30,250 |
| `airport_runways` | iata_code, icao_code | 0 |
| `airport_terminals` | iata_code, icao_code | 0 |
| `airport_digital_properties` | iata_code, icao_code | 21,309 |
| `airport_financial_performance` | iata_code, icao_code | 0 |
| `airport_ground_handling` | iata_code, icao_code | 0 |
| `airport_ground_transport` | iata_code, icao_code | 0 |
| `airport_hubs_and_airlines` | iata_code, icao_code | 0 |
| `airport_it_infrastructure` | iata_code, icao_code | 0 |
| `airport_key_personnel` | iata_code, icao_code | 0 |
| `airport_operational_stats` | iata_code, icao_code | 0 |
| `airport_services` | iata_code, icao_code | 0 |
| `navaids` | iso_country, ident | 10,953 |
| `navaid_technical` | source_navaid_id, country_code | 11,010 |
| `navaid_operational` | source_navaid_id, country_code | 11,010 |
| `navaid_connectivity` | source_navaid_id, country_code | 11,010 |
| `navaid_references` | source_navaid_id, country_code | 11,010 |
| `notam_sources` | iso_country (PK) | 8 |
| `notams` | source_notam_id, country_code | 12 |

### Aircraft Intelligence
| Table | Join Fields | Records |
|-------|-------------|---------|
| `aircraft_type_profile_data` | aircraft_name (LIKE model) | 0 |
| `aircraft_type_cabin_payload` | iata_code, icao_code | 0 |
| `aircraft_type_engine_data` | iata_code, icao_code | 0 |
| `aircraft_type_economic_data` | iata_code, icao_code | 0 |
| `aircraft_type_environmental_data` | iata_code, icao_code | 0 |
| `aircraft_type_operational_performance` | iata_code, icao_code | 0 |
| `aircraft_type_runway_requirements` | iata_code, icao_code | 0 |
| `aircraft_type_technical_specs` | iata_code, icao_code | 0 |
| `aircraft_type_manufacturer_support` | iata_code, icao_code | 0 |
| `aircraft_type_assets` | iata_code, icao_code | 0 |
| `aircraft_model_history` | model_id | 18 |
| `aircraft_model_capacity` | model_id | 200 |
| `aircraft_model_specs` | model_id | 400 |
| `aircraft_model_production` | model_id | 20 |
| `aircraft_model_sources` | model_id | 0 |

### Regulatory
| Table | Join Fields | Records |
|-------|-------------|---------|
| `regulatory_authorities` | country_code | 233 |
| `regulatory_records` | country_code, airline_iata, airline_icao | 160 |
| `regulatory_economic_licensing` | country_code | 163 |
| `regulatory_operational_certification` | country_code | 565 |
| `regulatory_environmental_security` | country_code | 0 |
| `regulatory_safety_oversight` | country_code | 0 |
| `regulatory_licensing_categories` | iso_country | 0 |
| `regulatory_references` | country_code | 0 |

### Commercial
| Table | Join Fields | Records |
|-------|-------------|---------|
| `commercial_fares` | fare_id (PK) | 0 |
| `commercial_fare_inventory` | fare_id | 0 |
| `commercial_fare_rules` | fare_id | 0 |
| `commercial_taxes_fees` | fare_id | 0 |
| `commercial_yield_analysis` | fare_id | 0 |
| `country_fare_policies` | country_code | 0 |
| `gds_systems` | gds_code (PK) | 15 |

### Reference
| Table | PK | Records |
|-------|----|---------|
| `ref_country_codes` | alpha_2 | 249 |
| `ref_service_types` | service_type_code | 12 |
| `ref_meal_service_codes` | code | 36 |
| `ref_booking_classes` | class_code + category | 88 |
| `ref_passenger_terminal_codes` | code | 12 |
| `ref_reject_reasons` | reject_reason | 12 |
| `ref_phonetic_alphabet` | character_code | 26 |
| `ref_timezones` | timezone_name | — |

### Standards
| Table | PK | Records |
|-------|----|---------|
| `iata_membership_requirements` | id | 13 |
| `iosa_registration_steps` | id | 8 |

### Operations (Pipeline)
| Table | PK | Notes |
|-------|----|-------|
| `import_batches` | id BIGINT | Batch tracking |
| `staging_import_records` | id BIGINT | Rows needing review |
| `dataset_files` | id BIGINT | Imported file metadata |
| `dataset_records` | id BIGINT | Raw JSON row storage |
| `export_logs` | id BIGINT | Export history |
| `entity_change_log` | id BIGINT | Field-level change tracking |
| `source_records` | id BIGINT | Source data raw storage |
| `pipeline_sources` | id INT | Source definitions |
| `pipeline_runs` | id BIGINT | Pipeline execution logs |

### Service Providers
| Table | PK | Records | Notes |
|-------|----|---------|-------|
| `organisations` | id BIGINT | 0 | Service providers (lessors, MRO, etc.) -- currently all cleared |
| `lessors` | lessor_code VARCHAR(32) | 35 | Aircraft lessors, separate from organisations to avoid duplication |

### Country Computed
| Table | PK | Records |
|-------|----|---------|
| `country_air_transport_stats` | iso_alpha_2 | Computed |
| `country_time_series` | id BIGINT | World Bank data |

## Key Relationships

```
countries <-- airline_destinations, airline_digital_properties, airline_fleet_list (via country_code)
countries <-- navaids, airports, aircraft_registrations (via iso_country / country_code)
countries <-- regulatory_authorities, country_air_transport_stats (via country_code / iso_alpha_2)
airlines  <-- airline_digital_properties, airline_fleet_summary, airline_hubs, etc. (via iata_code / icao_code)
airlines  <-- frequent_flyer_programs (via airline_code / iata_code / icao_code)
airports  <-- airport_frequencies, airport_runways, airport_terminals, etc. (via ident / iata_code / icao_code)
aircraft_types <-- aircraft_registrations (via icao_code / type_code)
aircraft_types <-- aircraft_type_* tables (via iata_code / icao_code)
aircraft_models <-- aircraft_model_* tables (via model_id)
```
