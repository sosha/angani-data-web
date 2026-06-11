# Import Pipeline (Phase 4)

The Phase 4 import system is a PHP-based engine that ingests CSV data from global files and per-country ZIP archives into MySQL tables. It lives in `scripts/importers/`.

## Architecture

```
scripts/importers/
  phase4_import.php       # CLI entry point
  ImportEngine.php        # Core import engine (AnganiImportEngine class)
  DatasetMap.php           # Table-to-CSV mapping definitions
```

## Entry Point

```bash
php scripts/importers/phase4_import.php [options]
```

Options:
- `--group=all` -- Import everything (global + country)
- `--group=global` -- Import root `data/global/*.csv` files
- `--group=country` -- Import country ZIP (`data/countries/countries.zip`)
- `--group=aircraft|reference|commercial|iata-iosa|gds` -- Import subset of global files
- `--group=infrastructure` -- Import global frequencies/NOTAM sources + country infrastructure
- `--path=...` -- Override default data path
- `--mode=append|replace` -- Append or truncate+insert
- `--dry-run` -- Validate without writing
- `--limit=N` -- Stop after N rows
- `--country=XX` -- Import only a specific country from ZIP
- `--store-raw` -- Also write raw rows to `dataset_records`
- `--no-fallback-raw` -- Skip raw logging of unmapped CSVs

## Engine Flow (ImportEngine::run)

1. **startBatch()** -- Creates `import_batches` record with status=running
2. **runGroup()** -- Dispatches to global or country importer
3. **importGlobalDirectory()** -- Scans `data/global/*.csv`, matches filenames against `phase4_global_map()`
4. **importCountryZip()** -- Opens ZIP, iterates entries, matches relative paths against `phase4_country_map()`
5. **importCsvString()** -- For each CSV:
   - Parses (handles BOM, quoted fields)
   - Records `dataset_files` entry
   - For mapped files: builds payload, inserts/upserts to target table
   - For unmapped files: raw logs to `dataset_records`
   - Failed rows go to `staging_import_records` (needs_review)
6. **finishBatch()** -- Updates `import_batches` with status + counts

## Dataset Map (DatasetMap.php)

Two mapping functions:

### `phase4_global_map()`
Maps CSV filename --> target table with column mapping:
```php
'aircraft_types.csv' => [
    'table' => 'aircraft_types',
    'group' => 'aircraft',
    'map' => [
        'db_column' => 'CSV Header',  ...
    ],
    'unique' => ['iata_code','icao_code'],  // for upsert
]
```

18 CSV files mapped: aircraft_types, aircraft_data, models, history, model_capacity, model_specs, production, sources, aircraft_assets, cabin_payload, economic_data, engine_data, environmental_data, manufacturer_support, operational_performance, runway_requirements, technical_specs, lessors.

Additional maps for: reference codes (booking classes, phonetic, country codes, meal codes, reject reasons, service types, licensing), IATA/IOSA, GDS, frequencies, NOTAM sources, commercial (fares, inventory, rules, taxes, yield), airlines, digital properties, frequent flyer programs.

### `phase4_country_map()`
Maps relative path within ZIP --> target table. ~40 path patterns covering:
- `{COUNTRY}/airlines/*.csv` (10 files)
- `{COUNTRY}/airports/*.csv` (14 files)
- `{COUNTRY}/Commercial/*.csv` (1 file)
- `{COUNTRY}/Infrastructure/*.csv` (9 files)
- `{COUNTRY}/Regulatory/*.csv` (8 files)

## Payload Building

The engine in `buildPayload()`:
1. Normalizes CSV headers (lowercase, replace special chars with underscores)
2. Maps via `cfg['map']` exactly
3. Falls back to auto-matching (if CSV column name matches DB column name)
4. Injects `country_code`/`iso_country` from ZIP folder name
5. Auto-sets `sort_order` if configured
6. Cleans values by column type (numeric extraction, boolean conversion, uppercase codes)
7. Filters out null/empty values

## Upsert Logic

When `cfg['unique']` is present, uses `INSERT ... ON DUPLICATE KEY UPDATE`. Assumes the database has a UNIQUE constraint on those columns; without it, acts as insert-only.

## Pipeline System (scripts/pipeline/)

A separate, more structured pipeline system for scheduled data ingestion:

```
Fetcher.php        -- Fetch data from APIs/URLs
Validator.php      -- Validate fetched data
Publisher.php      -- Publish validated data to live tables
DiffEngine.php     -- Compare old/new data for change detection
CountryNameResolver.php -- Normalize country names
PipelineEngine.php -- Orchestrate the full pipeline run
```

Pipeline sources in `scripts/pipeline/sources/`: WorldBank, REST Countries, OurAirports, Navaids, CAA CSV, Airport Frequencies, OPTD.

## Admin Console Imports

Admin → Imports tab provides a web UI equivalent:
1. Select module from dropdown
2. Upload CSV file (headers matching DB columns)
3. Choose Append or Truncate+Insert
4. System validates and imports with batch tracking
5. Failed rows shown for review

## Data Flow Summary

```
CSV Files / ZIP --> ImportEngine --> dataset_files (metadata)
                               --> target_table (live data)
                               --> dataset_records (raw JSON, optional)
                               --> staging_import_records (failures)
                               --> import_batches (run log)
```
