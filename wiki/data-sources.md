# Data Sources

This document describes where each dataset originates.

## Core Data Sources

### OurAirports (`airports`, `airport_frequencies`)
- **Source**: OurAirports data dumps (`https://davidmegginson.github.io/ourairports-data/`)
- **Import**: `scripts/pipeline/sources/OurAirportsScraper.php`, `scripts/ingest_ultimate_airports.php`
- **Refresh**: Quarterly via pipeline scraper
- **Coverage**: 84,146 airports, 30,250 frequencies worldwide

### Ourairports / OpenFlights (`airlines`)
- **Source**: OpenFlights airlines.dat + Kaggle airline datasets
- **Import**: `scripts/import_airlines_2027.php`, `scripts/import_airlines_enhanced.php`
- **CSV sync**: `airlines_master_corrected.csv` (9,200+ rows, upsert mode)
- **Status**: Continually updated via admin CSV imports

### Ourairports (`aircraft_types`)
- **Source**: OpenFlights aircraft types + custom data
- **Import**: `scripts/ingest_ultimate_aircraft_types.php`
- **Coverage**: 345 aircraft types (Boeing, Airbus, Embraer, etc.)

### Planespotters (`aircraft_registrations`)
- **Source**: Planespotters.net aircraft database
- **Import**: `scripts/ingest_aircraft_registrations_csv.php`
- **Seed**: `database/seeds/03_aircraft_registrations_001-006.sql` (35,522 records)
- **Coverage**: Individual aircraft by tail number with operator, age, MSN

## Country ZIP Data

The country ZIP file (`data/countries/countries.zip`) is the primary import for extended datasets. Each country has a folder structure:

```
{ISO_COUNTRY}/
  airlines/
    airlines.csv, corporate_identity.csv, digital_properties.csv
    brand_assets.csv, fleet_list.csv, fleet_summary.csv
    frequent_flyer_programs.csv, hubs.csv, it_infrastructure.csv
    key_personnel.csv, operational_stats.csv
  airports/
    airports.csv, digital_properties.csv, financial_performance.csv
    frequencies.csv, ground_handling.csv, ground_transport.csv
    hubs_and_airlines.csv, it_infrastructure.csv, key_personnel.csv
    operational_stats.csv, runways.csv, services.csv, terminals.csv
  Commercial/
    fare_policy.csv
  Infrastructure/
    navaids.csv, navaids_technical.csv, navaids_operational.csv
    navaids_connectivity.csv, navaids_references.csv
    NOTAMs/notams.csv, classification.csv, content.csv
    schedule.csv, connectivity.csv, references.csv
  Regulatory/
    authority.csv, certification.csv, economic_licensing.csv
    environmental_security.csv, licensing.csv
    operational_certification.csv, references.csv, safety_oversight.csv
```

- **Import**: `scripts/importers/phase4_import.php --group=country` using `ZipArchive`
- **Mapping**: `scripts/importers/DatasetMap.php` function `phase4_country_map()`

## Global CSV Datasets

Directory: `data/global/*.csv`

| CSV File | Table(s) | Source |
|----------|----------|--------|
| `airlines.csv` | `airlines` (upsert) | OpenFlights + manual curation |
| `aircraft_types.csv` | `aircraft_types` | ICAO/IATA type codes |
| `aircraft_data.csv` | `aircraft_type_profile_data` | Manufacturer specs |
| `lessors.csv` | `lessors` | Ultimate lessors list (35 lessors) |
| `digital_properties.csv` | `airline_digital_properties` | Web scraping |
| `frequent_flyer_programs.csv` | `frequent_flyer_programs` | Ultimate airline data |
| `fares.csv`, `fare_inventory.csv` | `commercial_fares`, `commercial_fare_inventory` | GDS/ATPCO snapshots |
| `models.csv`, `model_specs.csv` | `aircraft_models`, `aircraft_model_specs` | Manufacturer docs |
| `booking_class_hierarchy.csv` | `ref_booking_classes` | IATA standards |
| `country_codes.csv` | `ref_country_codes` | ISO 3166 |
| `phonetic_alphabet.csv` | `ref_phonetic_alphabet` | NATO standard |
| `frequencies.csv` | `airport_frequencies` | OurAirports |
| `notam_sources.csv` | `notam_sources` | ICAO NOF listing |

- **Import**: `scripts/importers/phase4_import.php --group=global | aircraft | reference | commercial | iata-iosa | gds | infrastructure`
- **Mapping**: `phase4_global_map()` in DatasetMap.php

## CAA / AOC Data

| Country | Script | Source |
|---------|--------|--------|
| UK | `scripts/ingest_gb_caa_aoc.php` | UK CAA register |
| Greece | `scripts/ingest_greek_caa_aoc.php` | Greek CAA |
| Italy | `scripts/ingest_italian_caa_aoc.php` | Italian ENAC |
| Latvia | `scripts/ingest_latvian_aoc.php` | Latvian CAA |
| Bahamas | Manual CSV + PDF import | Bahamas CAA register |

- **Process**: Parse CAA register pages, extract AOC holders, insert/update airlines with status_bucket, license_number
- **Status bucket**: `active` (has current AOC), `defunct` (no longer holds AOC)

## Wikipedia / Web Scraping

| Script | Data |
|--------|------|
| `scripts/ingest_wikipedia_airline_codes.php` | Airline IATA/ICAO codes from Wikipedia |
| `scripts/ingest_airlines_from_planespotters.php` | Airline fleet data |
| `scripts/download_airline_logos.php` | Airline logos from web sources |
| `scripts/download_manufacturer_logos.php` | Manufacturer logos |

## Pipeline Scrapers

All in `scripts/pipeline/sources/`:

| Scraper | Data | API |
|---------|------|-----|
| `WorldBankScraper.php` | GDP, population | World Bank API |
| `WorldBankDynamicFactsScraper.php` | Traffic data (pax, cargo) | World Bank API |
| `RestCountriesScraper.php` | Country info | REST Countries API |
| `RestCountriesFactsScraper.php` | Extended country facts | REST Countries API |
| `OurAirportsScraper.php` | Airports | OurAirports CSV download |
| `AirportFrequenciesScraper.php` | Frequencies | OurAirports CSV download |
| `OptdAirlinesScraper.php` | Airline schedules | OAG/OPTD |
| `OptdAircraftTypesScraper.php` | Aircraft types | OAG/OPTD |
| `NavaidsScraper.php` | Navaids | Various |
| `CaaCsvScraper.php` | CAA records | CAA CSV downloads |

## Seed SQL Files

Located in `database/seeds/`. These are INSERT statements generated from CSV dumps or manual preparation:

| Seed File | Table | Records | Source |
|-----------|-------|---------|--------|
| `01_countries.sql` | `countries` | 253 | REST Countries API |
| `02_airlines_001-002.sql` | `airlines` | 9,200+ | OpenFlights + manual |
| `03_aircraft_registrations_001-006.sql` | `aircraft_registrations` | 35,522 | Planespotters |
| `04_aircraft_types.sql` | `aircraft_types` | 345 | ICAO/IATA |
| `05_airports.sql` | `airports` | 84,146 | OurAirports |
| `06_airline_destinations.sql` | `airline_destinations` | 290 | Airline route data |
| `07_regulatory_records.sql` | `regulatory_records` | 160 | CAA/AOC registers |
| `08_dataset_files_001-006.sql` | `dataset_files` | 0 (pending) | Import pipeline metadata |
| `09_dataset_records_001-022.sql` | `dataset_records` | 0 (pending) | Raw CSV row storage |
| `10_platform_access_questions_insights.sql` | `question_presets`, `insight_cards` | Platform defaults | Manual |
| `11_aviation_schema_starter_seed.sql` | Various reference | Misc | Manual |
| `12_uploaded_global_001-003.sql` | `aircraft_model_specs` + others | 400 | Extracted from global CSV |
| `13_country_zip_001-034.sql` | Various country datasets | Pending | Country ZIP extraction |
