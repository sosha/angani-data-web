# Seed Status

This document tracks which seed SQL files exist, which have been run against the remote DB, and what data is still pending.

## Run via PHP import_all_seeds.php

The PHP script `database/import_all_seeds.php` reads `config.php` and processes numbered SQL files in `database/seeds/`.

## Seed Files Summary

### Run and Populated

| # | Seed File(s) | Target Table | Expected | Actual | Notes |
|---|-------------|-------------|----------|--------|-------|
| 01 | `01_countries.sql` | `countries` | 253 | 253 | Fully populated |
| 02 | `02_airlines_001-002.sql` | `airlines` | 9,200+ | 9,202 | Also updated via CSV sync |
| 03 | `03_aircraft_registrations_001-006.sql` | `aircraft_registrations` | 35,522 | 35,522 | 6 files |
| 04 | `04_aircraft_types.sql` | `aircraft_types` | 345 | 345 | Full |
| 05 | `05_airports.sql` | `airports` | 84,146 | 84,146 | Full |
| 06 | `06_airline_destinations.sql` | `airline_destinations` | 290 | 290 | Full |
| 07 | `07_regulatory_records.sql` | `regulatory_records` | 160 | 160 | Status column widened to TEXT |
| 10 | `10_platform_access_questions_insights.sql` | `question_presets`, `insight_cards` | ~20 | Populated | Platform defaults |
| 11 | `11_aviation_schema_starter_seed.sql` | Various reference | ~200 | Populated | Reference data |
| 12 | `12_uploaded_global_002-003.sql` | `aircraft_model_specs` | 400 | 400 | Extract from global CSVs |
| 12 | `12_uploaded_global_001.sql` | Various | Varies | Populated | Mixed data |

### Not Yet Run

| # | Seed File(s) | Target Table | Size | Reason |
|---|-------------|-------------|------|--------|
| 08 | `08_dataset_files_001-006.sql` | `dataset_files` | ~6 files, ~900KB each | Import pipeline metadata -- needs Phase 4 import to be run |
| 09 | `09_dataset_records_001-022.sql` | `dataset_records` | ~22 files, ~900KB each | Raw JSON row storage -- needs Phase 4 import with --store-raw |
| 13 | `13_country_zip_001-034.sql` | Various country tables | 34 files | Extracted from country ZIP -- needs Phase 4 import to be run |

### Empty Tables Despite Seed Files Existing

These tables have seed files or import scripts but currently have 0 records in the DB:

- `airline_fleet_list` -- needs country ZIP fleet_list.csv import
- `airline_it_infrastructure` -- needs country ZIP import
- `airline_key_personnel` -- needs country ZIP import
- `airline_operational_stats` -- needs country ZIP import
- `airport_runways` -- needs country ZIP import
- `airport_terminals` -- needs country ZIP import
- `airport_services` -- needs country ZIP import
- `airport_hubs_and_airlines` -- needs country ZIP import
- `airport_financial_performance` -- needs country ZIP import
- `airport_ground_handling` -- needs country ZIP import
- `airport_ground_transport` -- needs country ZIP import
- `airport_it_infrastructure` -- needs country ZIP import
- `airport_key_personnel` -- needs country ZIP import
- `airport_operational_stats` -- needs country ZIP import
- `commercial_fares` -- needs global CSV import
- `commercial_fare_inventory` -- needs global CSV import
- `commercial_fare_rules` -- needs global CSV import
- `commercial_taxes_fees` -- needs global CSV import
- `commercial_yield_analysis` -- needs global CSV import
- `country_fare_policies` -- needs country ZIP import
- `airline_route_services` -- needs country ZIP import
- `aircraft_type_profile_data` -- needs global CSV import
- `aircraft_type_assets` -- needs global CSV import
- `aircraft_type_cabin_payload` -- needs global CSV import
- `aircraft_type_engine_data` -- needs global CSV import
- `aircraft_type_economic_data` -- needs global CSV import
- `aircraft_type_environmental_data` -- needs global CSV import
- `aircraft_type_manufacturer_support` -- needs global CSV import
- `aircraft_type_operational_performance` -- needs global CSV import
- `aircraft_type_runway_requirements` -- needs global CSV import
- `aircraft_type_technical_specs` -- needs global CSV import
- `aircraft_model_sources` -- needs global CSV import
- `regulatory_environmental_security` -- needs country ZIP import
- `regulatory_references` -- needs country ZIP import
- `regulatory_safety_oversight` -- needs country ZIP import
- `regulatory_licensing_categories` -- needs global or country ZIP import
- `airline_iata_membership` -- needs country ZIP import
- `airline_iosa_registration` -- needs country ZIP import
- `notam_classification` -- needs country NOTAMs import
- `notam_content` -- needs country NOTAMs import
- `notam_schedule` -- needs country NOTAMs import
- `notam_connectivity` -- needs country NOTAMs import
- `notam_references` -- needs country NOTAMs import
- `dataset_files` -- needs Phase 4 import
- `dataset_records` -- needs Phase 4 import with --store-raw

## Tables with Partial Data

| Table | Records | Notes |
|-------|---------|-------|
| `airport_digital_properties` | 21,309 | Populated via country ZIP |
| `aircraft_models` | 742 | Fully seeded |
| `aircraft_model_capacity` | 200 | Fully seeded |
| `aircraft_model_history` | 18 | Fully seeded |
| `aircraft_model_production` | 20 | Fully seeded |
| `airline_digital_properties` | 6,796 | Populated |
| `airline_fleet_summary` | 1,090 | Populated |
| `airline_hubs` | 222 | Populated |
| `frequent_flyer_programs` | 394 | Populated |
| `lessors` | 35 | Populated |
| `regulatory_authorities` | 233 | Populated |
| `regulatory_economic_licensing` | 163 | Populated |
| `regulatory_operational_certification` | 565 | Populated |
| `navaid_technical` | 11,010 | Populated |
| `navaid_operational` | 11,010 | Populated |
| `navaid_connectivity` | 11,010 | Populated |
| `navaid_references` | 11,010 | Populated |
| `notams` | 12 | Minimal data |

## How to Run Pending Seeds

```bash
# Run all seeds
php database/import_all_seeds.php

# Run Phase 4 import (for dataset_files, dataset_records, and country data)
php scripts/importers/phase4_import.php --group=all --store-raw

# Or run specific Phase 4 groups
php scripts/importers/phase4_import.php --group=country
php scripts/importers/phase4_import.php --group=commercial
php scripts/importers/phase4_import.php --group=aircraft
```
