# V2 Data Pipeline Architecture

## Overview

The V2 pipeline ingests, validates, diffs, reviews, and publishes data from external sources
into fresh domain tables. Phase 1 covers the Countries domain (countries, caas, country_facts,
country_dynamic_facts, country_transport_stats).

Pipeline tables (pipeline_sources, pipeline_runs, staging_records, archived_records,
admin_action_log) are fresh — no reuse of V1 staging infrastructure.

## Data Flow

```
Source (API/CSV)
  │
  ▼
Fetcher → source-specific scraper → raw records
  │
  ▼
Validator → per-module schema + domain validation
  │
  ▼
DiffEngine → compare with current live table by PK hash
  │
  ▼
Stage records (insert / update / delete) → staging_records (status=pending)
  │
  ▼  (admin review & approve)
Publisher → INSERT/UPDATE/DELETE live table + archive deletes
```

## Pipeline Tables

### pipeline_sources
- `id` INT UNSIGNED AUTO_INCREMENT PK
- `source_name` VARCHAR(190) — human-readable name
- `source_type` ENUM('api','scraper','csv_upload','url_csv')
- `module_key` VARCHAR(80) — maps to domain table (countries, caas, etc.)
- `is_active` TINYINT(1)
- `url` — source endpoint URL
- `csv_file_path` — local CSV path for csv_upload type
- `last_run_at` / `last_run_status`
- `created_at` / `updated_at`

### pipeline_runs
- `id` BIGINT UNSIGNED AUTO_INCREMENT PK
- `pipeline_source_id` FK → pipeline_sources
- `module_key` VARCHAR(80)
- `status` ENUM('running','completed','failed','pending_review','approved','rejected')
- `run_type` ENUM('scheduled','manual')
- `records_fetched`, `records_valid`, `records_insert`, `records_update`, `records_delete`,
  `records_approved`, `records_rejected`
- `raw_content` LONGTEXT — full API response for debugging
- `error_message` TEXT
- `started_at` / `finished_at`
- `approved_by` / `approved_at`

### staging_records
- `id` BIGINT UNSIGNED AUTO_INCREMENT PK
- `pipeline_run_id` FK → pipeline_runs
- `module_key` VARCHAR(80)
- `action` ENUM('insert','update','delete')
- `row_hash` CHAR(64) — SHA256 of row_data for diff
- `row_data` JSON — full record to be published
- `diff_json` JSON — changes from current live row
- `status` ENUM('pending','approved','rejected','skipped')
- `reviewed_by` / `reviewed_at`

### archived_records
- Records deleted from live tables are copied here with full JSON snapshot
- `source_table`, `record_id`, `record_data` JSON, `deleted_by`, `deleted_at`

### admin_action_log
- Audit log for all admin publish/approve/reject actions

## Seeded Sources (IDs)

| ID | Source Name | Module Key | Type | URL |
|----|------------|-----------|------|-----|
| 1 | REST Countries API | countries | api | `.../v3.1/all?fields=cca2,cca3,name,region,subregion` |
| 2 | CAAs Verified CSV | caas | csv_upload | `data/countries/caas.csv` (local) |
| 3 | World Bank Transport API | country_transport_stats | api | `.../indicator/IS.AIR.DPRT;IS.AIR.PSGR;IS.AIR.FRGT` |
| 4 | REST Countries Facts | country_facts | api | `.../v3.1/all?fields=cca2,area,capital,languages,currencies,timezones` |
| 5 | World Bank Dynamic Facts | country_dynamic_facts | api | `.../indicator/SP.POP.TOTL;NY.GDP.MKTP.CD` |

## V2 Domain Tables

### countries
- `iso_alpha_2` VARCHAR(6) PK — e.g. `US`, `GB`, `GB-ENG`
- `iso_alpha_3` VARCHAR(3) — e.g. `USA`
- `name_common` VARCHAR(190) — "United States"
- `name_official` VARCHAR(255)
- `continent` VARCHAR(40) — "Americas"
- `un_region` VARCHAR(120) — "Northern America"

### caas
- `id` INT UNSIGNED AUTO_INCREMENT PK
- `country_code` VARCHAR(6) FK → countries
- `name`, `abbreviation`, `website`, `data_availability_notes`

### country_facts (key-value store)
- `country_code` VARCHAR(6) PK, FK → countries
- `fact_key` VARCHAR(80) PK — `area`, `capital`, `languages`, `currencies`, `timezones`
- `fact_value` TEXT
- `source` VARCHAR(190)

### country_dynamic_facts
- `country_code` VARCHAR(6) PK, FK → countries
- `metric_key` VARCHAR(80) PK — `population`, `gdp_usd`
- `year` INT PK
- `value` DECIMAL(20,2), `unit` VARCHAR(40), `source`

### country_transport_stats
- `country_code` VARCHAR(6) PK, FK → countries
- `statistic_year` INT PK
- `quarter` TINYINT PK DEFAULT 0
- `mode` ENUM('air','rail','road','sea') PK
- `metric` VARCHAR(80) PK — `aircraft_departures`, `passengers_carried`, `freight_tonnes`
- `value` DECIMAL(20,2), `unit`, `source`

## Scrapers

### RestCountriesScraper
- **File**: `scripts/pipeline/sources/RestCountriesScraper.php`
- **Source**: REST Countries v3.1 API
- **Fetches**: cca2, cca3, name (common + official), region, subregion
- **Output**: Countries records (250 rows)

### RestCountriesFactsScraper
- **File**: `scripts/pipeline/sources/RestCountriesFactsScraper.php`
- **Source**: REST Countries v3.1 API (same endpoint, different fields)
- **Fetches**: cca2, area, capital, languages, currencies, timezones
- **Output**: Key-value facts (~1242 rows: 250 countries × ~5 facts)

### CaaCsvScraper
- **File**: `scripts/pipeline/sources/CaaCsvScraper.php`
- **Source**: `data/countries/caas.csv` (254 verified entries)
- **Parses**: Country, CAA Name, Abbreviation (extracted from parentheses), Website
- **Output**: CAA records (253 rows)

### WorldBankScraper
- **File**: `scripts/pipeline/sources/WorldBankScraper.php`
- **Source**: World Bank API — air transport indicators
- **Indicators**: IS.AIR.DPRT, IS.AIR.PSGR, IS.AIR.FRGT
- **Filters**: 2-letter country codes validated against `countries.iso_alpha_2`
- **Output**: Transport stats (~2779 rows, 165 countries, 2015-2024)

### WorldBankDynamicFactsScraper
- **File**: `scripts/pipeline/sources/WorldBankDynamicFactsScraper.php`
- **Source**: World Bank API — population + GDP
- **Indicators**: SP.POP.TOTL, NY.GDP.MKTP.CD
- **Output**: Dynamic facts (~4231 rows, 212-216 countries, 2015-2024)

## Pipeline Engine

### Classes (in `scripts/pipeline/`)

- **PipelineEngine.php** — orchestrator: creates run → fetch → validate → diff → stage
  - `run(int $sourceId)` — full pipeline execution
  - `approveRun(int $runId)` — marks staging approved, then publishes
  - `rejectRun(int $runId)` — flags run as rejected
  - `approveStagingRecords(array $recordIds)` — individual record approval

- **Fetcher.php** — routes (source_type, module_key) → specific scraper class

- **Validator.php** — validates record structure against module schema

- **DiffEngine.php** — compares fetched records with live table by PK hash
  - Generates `insert` / `update` / `delete` actions
  - Multi-column PKs supported (e.g. country_facts, transport_stats)

- **Publisher.php** — writes approved staging to live tables
  - INSERT new records, UPDATE changed records, DELETE + archive removed records
  - Logs all actions to admin_action_log

- **CountryNameResolver.php** — resolves country names to ISO2 codes (used by CaaCsvScraper)

## Admin Web UI

Located under Admin → Data Pipeline tab (`?page=admin&tab=pipeline`).

### Sub-tabs
- **Sources** — list all configured sources, display last run status, "Run source" button
- **Pending Reviews** — runs with `pending_review` status, "Approve all" / "Reject all"
- **Run History** — all pipeline_runs with status, record counts, timestamps

### POST Actions
- `pipeline_run_source` — starts a pipeline run for a given source_id
- `pipeline_approve_run` — approves all pending staging in a run_id
- `pipeline_reject_run` — rejects a run

## UI Integration (V2 Country Data Display)

### Changes from V1

| Component | V1 (legacy_countries) | V2 (countries) |
|-----------|----------------------|----------------|
| Config table | `legacy_countries` | `countries` |
| PK column | `code` | `iso_alpha_2` |
| Name column | `name` | `name_common` |
| Country dropdown | `SELECT code,name FROM legacy_countries` | `SELECT iso_alpha_2,name_common FROM countries` |
| Detail URL | `detail_url($key, $code)` | `detail_url($key, $iso_alpha_2)` |
| Insight queries | `LEFT JOIN legacy_countries ON code` | `LEFT JOIN countries ON iso_alpha_2` |
| Admin CRUD PK | `WHERE id=?` | `module_pk()` helper — `iso_alpha_2` for countries |

### Helper Functions
- `module_pk(string $key): string` — returns PK column name for a module
- `country_name(?string $code): string` — looks up from V2 `countries` table

## Key Design Decisions

1. **No prefix on V2 tables**: Old `countries` renamed to `legacy_countries`
2. **ISO alpha-2 as PK**: `VARCHAR(6)` for sub-national codes like `GB-ENG`
3. **CAAs CSV is authoritative**: Wins on conflict over other sources
4. **Fetcher passes raw content by reference**: `string &$rawContent` stored in `pipeline_runs.raw_content`
5. **Approval flow**: staging starts `pending` → admin marks `approved` → Publisher writes to live table
6. **Delete = hard delete + archive**: `DELETE FROM live` + `INSERT INTO archived_records`

## Running the Pipeline

### Via CLI
```php
require_once 'includes/db.php';
require_once 'includes/functions.php';
require_once 'scripts/pipeline/PipelineEngine.php';

$engine = new PipelineEngine(1); // admin user ID 1
$result = $engine->run(1);       // source ID 1 (REST Countries)
$engine->approveRun($result['run_id']);
```

### Via Web
1. Log in as admin
2. Admin → Data Pipeline → Sources → "Run" on desired source
3. Wait for status to change to `pending_review`
4. Go to Admin → Data Pipeline → Pending Reviews → "Approve all"

## Migration SQL

`database/02_v2_migration.sql` contains all DDL:
- Rename countries → legacy_countries
- Create pipeline infrastructure tables
- Create V2 domain tables
- Seed GB-ENG etc.
- Seed pipeline sources
