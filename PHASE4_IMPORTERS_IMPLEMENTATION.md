# Phase 4 — Importers Implementation

Phase 4 adds a reusable import layer for Angani Data. The goal is to stop handling each CSV manually and instead route aviation datasets into the correct normalized tables with staging, batch logs and review controls.

## What was added

### Import engine

```bash
scripts/importers/phase4_import.php
scripts/importers/ImportEngine.php
scripts/importers/DatasetMap.php
```

The import engine supports:

- global datasets in `data/global/`
- country datasets inside `data/countries/countries.zip`
- aircraft type/intelligence datasets
- reference datasets
- commercial datasets
- IATA / IOSA datasets
- GDS datasets
- infrastructure datasets
- append or replace imports
- country-specific imports
- dry runs
- optional raw-row logging into `dataset_records`
- import batch logging into `import_batches`
- failed-row staging into `staging_import_records`

## Commands

Import everything:

```bash
php scripts/importers/phase4_import.php --group=all
```

Import only global datasets:

```bash
php scripts/importers/phase4_import.php --group=global
```

Import only country ZIP data:

```bash
php scripts/importers/phase4_import.php --group=country
```

Import one country from the country ZIP:

```bash
php scripts/importers/phase4_import.php --group=country --country=KE
```

Import Aircraft Intelligence:

```bash
php scripts/importers/phase4_import.php --group=aircraft
```

Import Reference Data:

```bash
php scripts/importers/phase4_import.php --group=reference
```

Import Commercial Intelligence:

```bash
php scripts/importers/phase4_import.php --group=commercial
```

Import IATA / IOSA:

```bash
php scripts/importers/phase4_import.php --group=iata-iosa
```

Import GDS:

```bash
php scripts/importers/phase4_import.php --group=gds
```

Import Infrastructure / AIM:

```bash
php scripts/importers/phase4_import.php --group=infrastructure
```

## Useful options

Dry-run without writing to the database:

```bash
php scripts/importers/phase4_import.php --group=aircraft --dry-run
```

Replace target tables instead of appending:

```bash
php scripts/importers/phase4_import.php --group=reference --mode=replace
```

Limit rows for testing:

```bash
php scripts/importers/phase4_import.php --group=country --country=KE --limit=1000
```

Also store each raw CSV row in `dataset_records`:

```bash
php scripts/importers/phase4_import.php --group=country --store-raw=1
```

## Wrapper scripts

These are convenience wrappers:

```bash
scripts/importers/import_global.sh
scripts/importers/import_country.sh
scripts/importers/import_aircraft.sh
scripts/importers/import_reference.sh
scripts/importers/import_commercial.sh
scripts/importers/import_iata_iosa.sh
scripts/importers/import_gds.sh
scripts/importers/import_infrastructure.sh
```

Example:

```bash
bash scripts/importers/import_country.sh --country=KE
```

## Mapping files to database tables

The mapping is controlled from:

```bash
scripts/importers/DatasetMap.php
```

This file maps source CSV headers to database columns. When new datasets arrive, add a mapping entry there instead of writing a new importer.

## Fallback handling

If a file does not have a configured mapping:

- the file is still registered in `dataset_files`
- optionally, rows can be stored in `dataset_records`
- the importer does not crash merely because one file is unmapped

If a mapped row fails to import:

- the row is sent to `staging_import_records`
- the import batch records the failed count
- admin can review the row in Data Quality

## Schema additions in this phase

Phase 4 also adds missing country-source support tables:

- `airport_financial_performance`
- `airport_ground_handling`
- `airport_ground_transport`
- `airport_it_infrastructure`
- `airport_key_personnel`
- `regulatory_environmental_security`
- `regulatory_references`
- `regulatory_safety_oversight`
- `notam_classification`
- `notam_content`
- `notam_schedule`
- `notam_connectivity`
- `notam_references`

## Recommended import order

For a fresh database:

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
php database/import_all_seeds.php
php scripts/importers/phase4_import.php --group=all
```

Use `--mode=replace` only when you want to clear and rebuild a module from source files.

## Operational note

Large country ZIP imports should be run from the command line, not from a browser request. The Admin Console now shows the exact importer commands under Admin → Imports / Exports.
