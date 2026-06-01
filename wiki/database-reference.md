# Database Reference — Complete Schema Documentation

This document describes every table in the `angani_data` MySQL database, what each column stores, and where the data is used in the application.

> **Database**: `angani_data` (utf8mb4 charset)  
> **Connections**: PHP PDO via `includes/db.php`  
> **Migration**: V1 schema files in `database/*.sql`, V2 migration files in `database/0*_v2_*.sql`

---

## 1. Core Tables

### `countries` (V2)

Stores country information. Used on the Countries listing page, country detail page, and as a reference for all other tables.

| Column | Type | Description | Used In |
|--------|------|-------------|---------|
| `iso_alpha_2` | VARCHAR(6) PK | Two-letter country code (e.g., "GB") | Detail URL, country detail overview |
| `iso_alpha_3` | VARCHAR(5) | Three-letter code (e.g., "GBR") | Country detail Identity section |
| `name_common` | VARCHAR(255) | Common name (e.g., "United Kingdom") | Card title, search |
| `name_official` | VARCHAR(255) | Official name | Country detail Identity section |
| `continent` | VARCHAR(32) | Continent name | Card filter by continent, detail GEOGRAPHY section |
| `un_region` | VARCHAR(64) | UN region (e.g., "Northern Europe") | Card chip display, detail |
| `flag` | TEXT | SVG flag path | Country detail flag image |
| `description` | TEXT | Aviation-biased description | Country detail, country_select dropdown |

**Used in these pages**: `?page=countries`, `?page=detail&module=countries&id={iso}`, home page stats, country filter dropdowns across all modules.

### `airlines` (V2)

Stores airline information. Used on Airlines listing and detail pages.

| Column | Type | Description | Used In |
|--------|------|-------------|---------|
| `icao_code` | VARCHAR(16) PK | ICAO airline code (e.g., "BAW") | Detail URL, all related queries |
| `iata_code` | VARCHAR(8) | IATA code (e.g., "BA") | Card display, search |
| `name` | VARCHAR(255) | Airline name | Card title, search |
| `alias` | VARCHAR(255) | Alternate name | Detail overview Identity section |
| `callsign` | VARCHAR(64) | Radio callsign (e.g., "SPEEDBIRD") | Card, search, detail |
| `country` | VARCHAR(128) | Country name | Card, detail, search |
| `country_code` | VARCHAR(6) | ISO country code | Card filter, related queries |
| `active` | VARCHAR(10) | "Y"=active, "N"=defunct | Status chip, filter |
| `logo_url` | TEXT | Airline logo URL | Detail overview logo display |

**Used in**: `?page=airlines`, airline detail page (all tabs), home page stats, global search, country detail Airlines tab.

### `airports` (V2)

Stores airport information. Used on Airports listing and detail pages.

| Column | Type | Description | Used In |
|--------|------|-------------|---------|
| `ident` | VARCHAR(20) PK | Airport identifier (usually ICAO code) | Detail URL |
| `type` | VARCHAR(32) | Airport type (large/medium/small/seaplane/closed) | Card, filter, detail |
| `name` | VARCHAR(255) | Airport name | Card title, search |
| `latitude_deg` | DECIMAL | Latitude | Detail overview |
| `longitude_deg` | DECIMAL | Longitude | Detail overview |
| `elevation_ft` | INT | Elevation in feet | Card stat, insight "highest airports" |
| `continent` | VARCHAR(4) | Continent code | Card filter |
| `iso_country` | VARCHAR(6) | Country code | Card filter, related queries |
| `municipality` | VARCHAR(128) | City/municipality | Card, search |
| `scheduled_service` | TINYINT | Has scheduled flights | Filter |
| `gps_code` | VARCHAR(8) | GPS code (usually ICAO) | Card, search |
| `iata_code` | VARCHAR(8) | IATA code (e.g., "LHR") | Card, search, related queries |
| `local_code` | VARCHAR(8) | Local code | Detail |
| `home_link` | TEXT | Official website | Detail |
| `wikipedia_link` | TEXT | Wikipedia page | Detail |
| `keywords` | TEXT | Search keywords | Search |

**Used in**: `?page=airports`, airport detail page (all tabs), country detail Airports tab, insight "highest airports".

### `aircraft_types` (V2)

Stores aircraft type/model information. Free tier, used on Aircraft Types listing and detail pages.

| Column | Type | Description | Used In |
|--------|------|-------------|---------|
| `icao_code` | VARCHAR(16) PK | ICAO type code (e.g., "B738") | Detail URL, related queries |
| `iata_code` | VARCHAR(8) | IATA type code (e.g., "738") | Card, search, related queries |
| `manufacturer` | VARCHAR(128) | Manufacturer (e.g., "Boeing") | Card title, search |
| `model` | VARCHAR(128) | Model name (e.g., "737-800") | Card subtitle, search |
| `type` | VARCHAR(64) | Type (e.g., "Jet", "Turboprop") | Card, search, filter |
| `description` | TEXT | Aircraft description | Detail overview |
| `engine_type` | VARCHAR(64) | Engine type (e.g., "Turbofan") | Card, search |
| `engine_count` | INT | Number of engines | Card stat |
| `wtc` | VARCHAR(8) | Wake turbulence category (L/M/H) | Card chip |

**Used in**: `?page=aircraft_types`, aircraft type detail page (all 8 tabs), home page stats, global search.

### `aircraft_registrations` (V1 — Pro tier)

Stores individual aircraft (by tail number). Used on Aircraft Registry listing and detail pages.

| Column | Type | Description | Used In |
|--------|------|-------------|---------|
| `id` | BIGINT PK AUTO | Internal ID | — |
| `country_code` | VARCHAR(6) | Registration country | Card, filter, country detail |
| `icao_code` | VARCHAR(16) | Aircraft type ICAO code | Related type queries |
| `aircraft_type` | VARCHAR(128) | Type description (e.g., "Boeing 737-800") | Card title, search |
| `registration` | VARCHAR(32) | Tail number (e.g., "G-EZAT") | Card title |
| `type_code` | VARCHAR(16) | IATA type code | Related queries |
| `construction_number` | VARCHAR(32) | MSN / serial number | Detail |
| `adshex` | VARCHAR(16) | Mode S hex code | Detail |
| `age` | DECIMAL | Aircraft age in years | Card stat, insight "oldest aircraft" |
| `operator_icao` | VARCHAR(16) | Operator ICAO code | Related queries |
| `operator_name` | VARCHAR(255) | Operator name | Card, search, detail |
| `record_status` | VARCHAR(32) | Status (active/stored/scrapped/etc.) | Card chip |

**Used in**: `?page=aircraft` (Pro), aircraft detail page, country detail Registry tab, aircraft type detail Registry tab, home page stats.

---

## 2. Country Intelligence Tables (V2)

### `country_air_transport_stats`

Pre-computed air transport statistics per country. Used in country detail Statistics tab.

| Column | Type | Description |
|--------|------|-------------|
| `iso_alpha_2` | VARCHAR(6) PK | Country code |
| `international_airports` | INT | Count of international airports |
| `domestic_airports` | INT | Count of domestic airports |
| `airlines` | INT | Total airlines |
| `airlines_active` | INT | Active airlines |
| `airlines_defunct` | INT | Defunct airlines |
| `airlines_with_international` | INT | Airlines flying internationally |
| `foreign_airline_operations` | INT | Foreign airlines operating |
| `updated_at` | DATETIME | Last computation time |

**Computed by**: `scripts/reports/generate_country_stats.php` (run from Admin → Reports)

### `country_time_series`

Year-by-year economic and traffic data per country. Used in country detail Timeseries tab for Chart.js visualisation.

| Column | Type | Description |
|--------|------|-------------|
| `id` | BIGINT PK AUTO | Internal ID |
| `iso_alpha_2` | VARCHAR(6) | Country code |
| `year` | YEAR(4) | Data year |
| `gdp_usd` | DECIMAL(18,2) | GDP in US dollars |
| `population` | BIGINT | Population |
| `area_sq_km` | DECIMAL(12,2) | Area in square km |
| `currency_code` | VARCHAR(8) | Currency code |
| `currency_name` | VARCHAR(64) | Currency name |
| `official_languages` | VARCHAR(255) | Languages |
| `capital` | VARCHAR(128) | Capital city |
| `international_traffic_passengers` | BIGINT | Intl passenger count |
| `domestic_traffic_passengers` | BIGINT | Domestic passenger count |
| `international_cargo_tonnes` | DECIMAL(14,2) | Cargo in tonnes |

**Populated by**: `scripts/populate_country_time_series.php` (fetches World Bank API data)

---

## 3. Airline Intelligence Tables (V1 extension)

### `airline_digital_properties`

Airline digital presence: websites, social media, etc. Used in airline detail Digital tab.

**Key columns**: `iata_code`, `icao_code`, `airline_name`, `category` (website/twitter/facebook/instagram/youtube/wikipedia), `platform`, `url_or_handle`, `is_primary`

**Joined by**: `iata_code` or `icao_code` matching the airline record.

### `airline_fleet_list`

Individual aircraft in each airline's fleet. Used in airline detail Fleet tab.

**Key columns**: `registration`, `msn`, `aircraft_model`, `aircraft_subtype`, `delivery_date`, `operator_airline`, `current_status`

**Joined by**: `operator_airline` (LIKE match on airline name) or `operator_airline` matching `airlines.name`.

### `airline_fleet_summary`

Fleet composition summary per airline. Used in airline detail Fleet tab.

**Key columns**: `iata_code`, `icao_code`, `aircraft_type`, `aircraft_count`, `configuration_lopa`, `average_age`, `engine_type`

**Joined by**: `iata_code` or `icao_code` matching the airline.

### `airline_hubs`

Airline hub airports. Used in airline detail Hubs tab.

**Key columns**: `iata_code`, `icao_code`, `airport_code`, `hub_type` (hub/base/focus_city), `region_served`

**Joined by**: `iata_code` or `icao_code`.

### `airline_it_infrastructure`

Airline IT systems. Used in airline detail IT section.

**Key columns**: `iata_code`, `icao_code`, `system_category` (reservation/checkin/crew/ops), `system_name`, `provider`

### `airline_key_personnel`

Key people at airlines. Used in airline detail Personnel section.

**Key columns**: `iata_code`, `icao_code`, `person_name`, `title`, `category`, `email`

### `airline_operational_stats`

Yearly operational statistics. Used in airline detail Operations tab.

**Key columns**: `iata_code`, `icao_code`, `stat_year`, `pax_count`, `cargo_volume`, `revenue`, `ebit`, `staff_count`

### `frequent_flyer_programs`

Airline loyalty programmes. Free tier.

**Key columns**: `airline_code`, `iata_code`, `icao_code`, `airline_name`, `program_name`, `points_unit`, `tier_level`

### `airline_iata_membership`

IATA membership status per airline. Pro tier.

**Key columns**: `iata_code`, `icao_code`, `airline_name`, `membership_status`, `membership_type`, `joined_date`, `ended_date`

### `airline_iosa_registration`

IOSA registration status per airline. Pro tier.

**Key columns**: `iata_code`, `icao_code`, `airline_name`, `iosa_status`, `registration_number`, `valid_from`, `valid_until`

---

## 4. Airport & Infrastructure Tables (V1 extension)

### `airport_frequencies`

Radio frequencies at airports. Free tier. Used in airport detail Frequencies tab.

**Key columns**: `airport_ident`, `frequency_mhz`, `type` (ATIS/UNICOM/APP/DEP/TWR/GND/CLD), `description`

**Joined by**: `airport_ident` matching `airports.ident`, OR `iata_code`/`icao_code`.

### `airport_runways`

Runway data. Pro tier. Used in airport detail Runways tab.

**Key columns**: `iata_code`, `icao_code`, `runway_ident`, `length_ft`, `width_ft`, `surface`, `lighting`, `ils_frequency`

### `airport_terminals`

Terminal data. Pro tier. Used in airport detail Terminals tab.

**Key columns**: `iata_code`, `icao_code`, `terminal_type`, `terminal_name`, `capacity`, `facilities`, `gates_count`

### `airport_services`

Airport services. Pro tier.

**Key columns**: `iata_code`, `icao_code`, `service_category`, `provider`

### `airport_hubs_and_airlines`

Hub/base airline relationships. Pro tier. Used in airport detail Hubs tab.

**Key columns**: `iata_code`, `icao_code`, `airline_name`, `relation` (hub/base), `destinations_served`

### `airport_financial_performance`

Airport financial data. Pro tier.

**Key columns**: `iata_code`, `icao_code`, `stat_year`, `revenue`, `profit_loss`, `investment`, `staff_count`

### `airport_ground_handling`, `airport_ground_transport`, `airport_it_infrastructure`, `airport_key_personnel`

Extended airport data, all Pro tier. Similar structure to airline equivalents.

### `navaids` (V2)

Navigation aids. Free tier. Used in country detail Navaids tab, homepage stats.

**Key columns**: `ident`, `name`, `type` (VOR/DME/NDB/ILS), `frequency_khz`, `latitude_deg`, `longitude_deg`, `elevation_ft`, `iso_country`

### `navaid_technical`, `navaid_operational`, `navaid_connectivity`, `navaid_references`

Navaid extended data. All Pro tier. Joined by `source_navaid_id` and `country_code`.

### NOTAM Tables (`notam_sources`, `notams`, `notam_classification`, `notam_content`, `notam_schedule`, `notam_connectivity`, `notam_references`)

NOTAM (Notice to Air Missions) data. Sources are Free, content is Pro. All joined by `source_notam_id` and `country_code`.

---

## 5. Aircraft Intelligence Tables (V1 extension)

All aircraft intelligence tables are **Pro tier** except `aircraft_models` (free).

### `aircraft_type_profile_data`

Aircraft type profile. Joined by `aircraft_name` matching `aircraft_types.model`.

**Key columns**: `aircraft_name`, `country_of_origin`, `aircraft_role` (e.g., "Narrowbody jet"), `powerplants`, `performance`, `weights`, `dimensions`, `capacity`, `production`, `history`

**Used in**: Aircraft type detail Profile tab.

### `aircraft_type_cabin_payload`

Cabin configuration and payload. Joined by `iata_code` or `icao_code`.

**Key columns**: `typical_c_seats` (business), `typical_y_seats` (economy), `max_capacity`, `cargo_volume_m3`, `max_payload_kg`

**Used in**: Aircraft type detail Cabin & Payload tab.

### `aircraft_type_engine_data`

Engine specifications. Joined by `iata_code` or `icao_code`.

**Key columns**: `engine_variants`, `engine_type`, `engine_count`, `thrust_per_engine_kn`, `fuel_burn_rate`, `saf_compatible`

**Used in**: Aircraft type detail Engine tab.

### `aircraft_type_economic_data`

Economic data. Joined by `iata_code` or `icao_code`.

**Key columns**: `list_price_usd`, `op_cost_per_hour`, `lease_rate_monthly`, `residual_value_trend`

**Used in**: Aircraft type detail Economic Data tab.

### `aircraft_type_environmental_data`

Environmental impact. Joined by `iata_code` or `icao_code`.

**Key columns**: `carbon_intensity`, `noise_chapter`, `fuel_type`

**Used in**: Aircraft type detail Environmental tab.

### `aircraft_type_operational_performance`

Performance specs. Joined by `iata_code` or `icao_code`.

**Key columns**: `max_range_nm`, `service_ceiling_ft`, `v1`, `vr`, `v2`, `vref`, `cruise_speed_mach`, `max_speed`, `climb_rate`

### `aircraft_type_runway_requirements`

Runway performance. Joined by `iata_code` or `icao_code`.

**Key columns**: `min_takeoff_length_ft`, `min_landing_length_ft`, `surface_compatibility`

### `aircraft_type_technical_specs`

Physical specifications. Joined by `iata_code` or `icao_code`.

**Key columns**: `mtow_kg`, `mzfw_kg`, `empty_weight_kg`, `wingspan_m`, `length_m`, `height_m`

**Used in**: Aircraft type detail Specs tab.

### `aircraft_type_manufacturer_support`

Manufacturer support info. Joined by `iata_code` or `icao_code`.

**Key columns**: `production_start`, `production_end`, `total_built`, `mro_availability`

### `aircraft_type_assets`

Image assets. Joined by `iata_code` or `icao_code`.

**Key columns**: `primary_livery_url`, `lopa_template_url`, `cockpit_reference_url`

### `aircraft_models` (Free tier)

Aircraft model encyclopedia. Keyed by `model_id`.

**Key columns**: `model_id`, `model_name`, `origin`, `role`, `iata_type_ref`

### `aircraft_model_history`, `aircraft_model_capacity`, `aircraft_model_specs`, `aircraft_model_production`, `aircraft_model_sources`

Extended model data. All Pro tier. Joined by `model_id`.

---

## 6. Regulatory & Standards Tables (V1 extension)

### `regulatory_authorities` (Free tier)

Civil aviation authorities. Used in country detail Regulatory tab.

**Key columns**: `country_code`, `name`, `abbreviation`, `jurisdiction`, `hq_location`, `website`, `official_register_link`

### `regulatory_records` (Pro tier)

General regulatory records. Joined by `country_code`, `airline_iata`, `airline_icao`.

**Key columns**: `type`, `country_code`, `name`, `regulator_name`, `airline_iata`, `airline_icao`, `aoc_number`, `status_bucket`, `fields_json`

### `regulatory_economic_licensing`, `regulatory_operational_certification`, `regulatory_licensing_categories`, `regulatory_environmental_security`, `regulatory_safety_oversight`, `regulatory_references`

Extended regulatory data. Various tiers. All joined by `country_code`.

### `iata_membership_requirements` (Free)

IATA membership rules and requirements.

### `iosa_registration_steps` (Free)

IOSA registration process steps.

### `gds_systems` (Free)

Global Distribution Systems (Amadeus, Sabre, Travelport).

---

## 7. Commercial Tables (V1 extension — all Pro)

### `commercial_fares`

Airfare data across routes.

**Key columns**: `fare_id`, `airline_code`, `origin_iata`, `destination_iata`, `base_fare`, `total_fare`, `currency_code`

### `commercial_fare_inventory`, `commercial_fare_rules`, `commercial_taxes_fees`, `commercial_yield_analysis`

Extended fare data. Joined by `fare_id`.

### `country_fare_policies`

Country-level fare regulations. Joined by `country_code` and `carrier_code`.

---

## 8. Reference Tables (V1 extension — all Free)

| Table | Contents |
|-------|----------|
| `ref_country_codes` | Country names to ISO codes mapping |
| `ref_service_types` | Aviation service type codes (J=Passenger, C=Cargo, etc.) |
| `ref_meal_service_codes` | Meal service codes |
| `ref_booking_classes` | Booking/RBD class codes |
| `ref_passenger_terminal_codes` | Terminal/process codes |
| `ref_reject_reasons` | Reject reason codes |
| `ref_phonetic_alphabet` | NATO phonetic alphabet |

---

## 9. Platform & Operations Tables

### `users`

User accounts. Used for authentication everywhere.

**Columns**: `id` (PK), `name`, `email` (UNIQUE), `password_hash`, `tier_id` (FK to `subscription_tiers`), `role` (user/admin), `status` (active/suspended/deleted), `created_at`, `updated_at`, `last_login_at`

### `subscription_tiers`

Pricing tiers. Used on pricing page and for access control.

**Columns**: `id` (PK), `code` (free/pro/enterprise), `name`, `monthly_usd`, `annual_usd`, `display_order`, `is_active`

### `tier_features`

Features per tier. Used for feature access checks.

**Columns**: `id` (PK), `tier_id` (FK), `feature_code`, `feature_label`

### `question_presets`

Preset intelligence questions for the dashboard.

**Columns**: `id` (PK), `code` (UNIQUE), `title`, `question_text`, `category`, `answer_key`, `required_tier_id` (FK)

### `insight_cards`

Rotating insight cards on the homepage.

**Columns**: `id` (PK), `title`, `metric_label`, `query_key`, `chart_type`, `required_tier_id`, `display_order`, `is_active`, `last_rotated_at`

### `data_reports`

User-submitted data problem reports.

**Columns**: `id` (PK), `entity_type`, `entity_id`, `report_type` (wrong/old/other), `description`, `status` (open/in_progress/resolved/dismissed), `reporter_email`

### `data_audit_log`

Audit trail for all data changes. Used in Admin → Data Audit.

**Columns**: `id` (PK), `table_name`, `record_id`, `action` (INSERT/UPDATE/DELETE), `old_values` (JSON), `new_values` (JSON), `user_id`, `license_id`

### `data_table_provenance`

Data source provenance per table.

**Columns**: `table_name` (PK), `collection_method`, `primary_source_url`, `primary_license_id`

### `data_licenses`

Data license definitions.

**Columns**: `id` (PK), `name` (UNIQUE), `url`, `description`, `allows_commercial_use`

### `pipeline_sources`, `pipeline_runs`, `staging_import_records`, `import_batches`, `export_logs`, `admin_tasks`, `email_providers`, `email_queue`, `entity_change_log`

Operations tables for the pipeline system, import/export, admin task management, email sending, and data change tracking.

---

## 10. Relationship Map

```
countries ──┬── airlines (via country_code)
            ├── airports (via iso_country)
            ├── aircraft_registrations (via country_code)
            ├── regulatory_authorities (via country_code)
            ├── country_air_transport_stats (via iso_alpha_2)
            └── country_time_series (via iso_alpha_2)

airlines ──┬── airline_digital_properties (via iata_code / icao_code)
           ├── airline_fleet_list (via operator_airline name)
           ├── airline_fleet_summary (via iata_code / icao_code)
           ├── airline_hubs (via iata_code / icao_code)
           ├── airline_operational_stats (via iata_code / icao_code)
           ├── airline_iata_membership (via iata_code / icao_code)
           ├── airline_iosa_registration (via iata_code / icao_code)
           └── frequent_flyer_programs (via airline_code / iata_code / icao_code)

airports ──┬── airport_frequencies (via airport_ident or iata_code / icao_code)
           ├── airport_runways (via iata_code / icao_code)
           ├── airport_terminals (via iata_code / icao_code)
           └── airport_hubs_and_airlines (via iata_code / icao_code)

aircraft_types ──┬── aircraft_type_cabin_payload (via iata_code / icao_code)
                 ├── aircraft_type_engine_data (via iata_code / icao_code)
                 ├── aircraft_type_economic_data (via iata_code / icao_code)
                 ├── aircraft_type_environmental_data (via iata_code / icao_code)
                 ├── aircraft_type_technical_specs (via iata_code / icao_code)
                 ├── aircraft_type_runway_requirements (via iata_code / icao_code)
                 ├── aircraft_type_operational_performance (via iata_code / icao_code)
                 ├── aircraft_type_manufacturer_support (via iata_code / icao_code)
                 ├── aircraft_type_profile_data (via aircraft_name ≈ model)
                 ├── aircraft_type_assets (via iata_code / icao_code)
                 └── aircraft_registrations (via icao_code / type_code)
```
