# Angani Data Repo Repair Report

This package addresses the six requested stabilisation items on the uploaded repository.

## 1. Fixed `index.php` merge conflict and routing

- Replaced the broken merge-conflicted `index.php` with a clean routed public entry point.
- Removed the duplicated/contradictory old page flow that caused `unexpected token "elseif"`.
- Consolidated public routing around:
  - `home`
  - `search`
  - `catalogue`
  - `module`
  - `detail`
  - `pricing`
  - `login`
  - `register`
  - `dashboard`
  - `answer`
  - `account`
  - `contact`
- Added pre-output redirects for logged-in-only pages so PHP does not warn about headers already sent.
- Public `?page=admin` now redirects to the separate `/admin/` entry point.

## 2. Standardised DB layer

- Standardised runtime DB access to PDO in `includes/db.php`.
- Existing `lastInsertId()` usage is now valid because the application DB handle is PDO.
- `rows()`, `row()`, `scalar()` and `exec_sql()` now use PDO prepared statements consistently.
- `database/import_all_seeds.php` and the Phase 4 importers also use PDO, so runtime and tooling use the same DB style.
- `config.example.php` now supports environment variables.

## 3. Corrected seed/import packaging

- Restored the missing split seed files referenced by `database/02_seed_data.sql`.
- Current package includes 80 seed SQL files, all below 1MB.
- `database/02_seed_data.sql` now matches files present in `database/seeds/`.
- `database/import_all_seeds.php` imports split seed files in order.
- Source CSVs are present under `data/global/` and the country ZIP is present under `data/countries/countries.zip`.

## 4. Separated Admin from public frontend

- Added a dedicated admin entry point: `admin/index.php`.
- Public navigation now links admin users to `/admin/`.
- The admin entry point has its own header, asset paths and access gate.
- Admin screens remain operationally focused: records, imports/exports, data quality, users, plans, preset questions, homepage insights and readiness tasks.
- Public drill-down/detail links generated inside Admin now point back to the public app correctly.

## 5. Restored Phase 4/5 importer and QA files

Restored/added:

- `scripts/importers/phase4_import.php`
- `scripts/importers/ImportEngine.php`
- `scripts/importers/DatasetMap.php`
- group shell helpers for global, country, aircraft, reference, commercial, IATA/IOSA, GDS and infrastructure imports
- `scripts/qa_phase5_check.php`
- `PHASE4_IMPORTERS_IMPLEMENTATION.md`
- `PHASE5_QA_AND_DEPLOYMENT_REPORT.md`
- `DEPLOYMENT_RUNBOOK.md`
- `/qa/` latest check logs

Importer groups available:

```bash
php scripts/importers/phase4_import.php --group=global
php scripts/importers/phase4_import.php --group=country --country=KE
php scripts/importers/phase4_import.php --group=aircraft
php scripts/importers/phase4_import.php --group=reference
php scripts/importers/phase4_import.php --group=commercial
php scripts/importers/phase4_import.php --group=iata-iosa
php scripts/importers/phase4_import.php --group=gds
php scripts/importers/phase4_import.php --group=infrastructure
```

## 6. Polished UI and drill-downs

- Public homepage now uses a serious aviation-intelligence style.
- Active airlines pill has a subtle green glow.
- Airline cards include country flag, logo/initial fallback, codes, status, fleet/alliance metrics and a clear button.
- Airport and aircraft-type cards are clickable and have explicit “View” buttons.
- Detail pages hide raw internal fields from public users.
- Related drill-down sections are wired for airlines, airports, aircraft types and countries.
- Pro access gates are enforced through module configuration.

## QA performed in this sandbox

Static checks completed successfully:

- PHP syntax checks across all PHP files: passed.
- Static schema/module check: 16/16 passed.
- Seed file presence and size check: passed.
- Seed INSERT columns against schema: passed.
- Public page smoke checks: passed for home, search, catalogue, pricing, login, register, module, detail, dashboard, answer, account, contact.
- Admin entry smoke check: passed.

Latest logs:

- `qa/php_lint_latest.txt`
- `qa/static_qa_latest.txt`
- `qa/page_smoke_latest.txt`

## Known environment limitation

The sandbox used for this repair does not have `pdo_mysql`, so live DB import execution could not be run here. The code is PDO-based and the deployment server must have the PHP MySQL PDO extension enabled.

On Ubuntu/Debian:

```bash
sudo apt install php-mysql
sudo systemctl restart apache2   # Apache
# or
sudo systemctl restart php8.3-fpm nginx
```

Then run:

```bash
php scripts/qa_phase5_check.php --db
php scripts/importers/phase4_import.php --group=global --dry-run --limit=10
```

