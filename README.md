# Angani Data — Aviation Intelligence Atlas

A PHP/MySQL aviation data product covering countries, airlines, airports, aircraft registry, aircraft types, lessors, infrastructure/AIM, regulatory standards, commercial fare intelligence, GDS, IATA/IOSA and aviation reference codes.

## What is included

- Public aviation data catalogue with searchable modules and drill-down pages.
- Separate Admin Console that does **not** look like the public frontend.
- Generic CRUD for every configured database module.
- CSV import/export for Admin.
- CSV export for logged-in Pro/Enterprise users.
- User accounts, role management and 3 access tiers: **Free**, **Pro**, **Enterprise**.
- Homepage rotating insight cards controlled by Admin.
- Public teaser charts for sign-up conversion.
- Drill-down pages for airlines, airports, aircraft types and countries.
- Data quality tables: imports, staging rows, export logs, source records and change log.
- Expanded aviation modules for:
  - Aircraft Types / Aircraft Intelligence
  - Lessors
  - IATA / IOSA
  - GDS
  - Reference Data / Aviation Standards & Codes
  - Infrastructure & AIM
  - Commercial Intelligence
  - Airport frequencies, runways, terminals, services and hub airlines
  - Airline digital properties, fleets, hubs, IT infrastructure and people

## Demo accounts

```text
Admin: admin@angani.co.uk / Angani@2026
Pro:   pro@angani.co.uk / Angani@2026
Free:  free@angani.co.uk / Angani@2026
```

## Installation

1. Copy this folder to your web server, for example:

```text
C:\xampp\htdocs\angani-data
```

2. Create/import the database:

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
php database/import_all_seeds.php
```

Alternative import:

```bash
mysql -u root -p angani_data < database/02_seed_data.sql
```

3. Update database credentials in:

```text
includes/config.php
```

4. Open:

```text
http://localhost/angani-data/
```

## Important seed note

The SQL seed files are split in `database/seeds/`. They include the current uploaded aviation datasets and are kept below approximately 1MB per file for easier cPanel/phpMyAdmin usage.

## Admin actions

After logging in as Admin:

- Go to **Admin → Records & CRUD**.
- Choose a database module from the sidebar.
- Use **Add record**, **Edit**, **Import CSV**, or **Export CSV**.
- Go to **Admin → Users** to manage accounts, roles, status and plans.
- Go to **Admin → Homepage Insights** to rotate public teaser cards.
- Go to **Admin → 100% Tasks** to review the readiness checklist.

## Access tiers

### Free

Public discovery, limited browsing, reference codes, selected teaser insights.

### Pro

Full standard modules, drill-downs, preset questions and filtered CSV exports.

### Enterprise

Contact us for API access, bulk exports, team seats, scheduled exports and private/custom datasets.

## Data design note

Country folders are treated as ingestion sources. The app stores data in one normalised global database, with `country_code` used for filtering instead of creating separate country-specific tables.

## Phase 2 Admin Console

The package includes the Phase 2 admin backend: Command Center, module CRUD, CSV import/export, whole-database ZIP export, user management, plan/benefit editing, preset question management, homepage insight management, data quality review and the 100% readiness checklist.

See `PHASE2_ADMIN_IMPLEMENTATION.md` for details.

## Phase 3 Public/User App

Phase 3 adds the public/user-facing app layer: homepage conversion flow, global search, database listings, drill-down pages, preset questions, charts/tidbits, login/register/account pages and Pro access gates.

See `PHASE3_PUBLIC_APP_IMPLEMENTATION.md` for details.


## Phase 4 Importers

This package includes the Phase 4 importer layer for bringing the uploaded source datasets into the normalized PHP/MySQL application.

Run all importers after schema setup and seed loading:

```bash
php scripts/importers/phase4_import.php --group=all
```

Import one country from the country ZIP:

```bash
php scripts/importers/phase4_import.php --group=country --country=KE
```

Import by dataset family:

```bash
php scripts/importers/phase4_import.php --group=aircraft
php scripts/importers/phase4_import.php --group=reference
php scripts/importers/phase4_import.php --group=commercial
php scripts/importers/phase4_import.php --group=iata-iosa
php scripts/importers/phase4_import.php --group=gds
php scripts/importers/phase4_import.php --group=infrastructure
```

Detailed importer documentation is in `PHASE4_IMPORTERS_IMPLEMENTATION.md`.

## Phase 5 final QA package

This ZIP includes the final Phase 5 readiness report and deployment runbook:

```text
PHASE5_QA_AND_DEPLOYMENT_REPORT.md
DEPLOYMENT_RUNBOOK.md
qa/php_lint_phase5.txt
qa/static_qa_phase5.txt
qa/page_smoke_phase5.txt
scripts/qa_phase5_check.php
```

Run final checks after deployment:

```bash
php scripts/qa_phase5_check.php
php scripts/qa_phase5_check.php --db
```

## Repair status

This repository has been repaired according to the six-step stabilisation request:

1. `index.php` merge conflict and routing fixed.
2. DB layer standardised on PDO.
3. Seed/import packaging corrected.
4. Admin separated into `/admin/`.
5. Phase 4 importers and Phase 5 QA files restored.
6. Public UI and drill-downs polished.

See `REPAIR_REPORT.md` for the exact change summary and QA results.
