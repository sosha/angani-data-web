# Angani Data — Phase 5 QA, Readiness & Deployment Report

This package consolidates Phases 1–5 into one ready-to-run PHP/MySQL aviation data platform.

## Phase 5 objective

Phase 5 was the final readiness pass covering:

- all pages load
- all configured databases are editable
- imports work through Admin and CLI importers
- exports work through Admin and gated user exports
- cards are clickable
- drill-down pages exist
- tiers are enforced
- admin/user separation is clear
- internal fields are hidden from normal users
- sample data is seeded
- broken/missing datasets are handled gracefully

## What was added/fixed in Phase 5

### 1. Final QA checker

Added:

```bash
php scripts/qa_phase5_check.php
php scripts/qa_phase5_check.php --db
```

The normal mode runs static package checks without needing a database. The `--db` mode should be run after deployment/import to confirm live MySQL counts.

### 2. Importer resilience

The country ZIP importer now supports two ZIP-reading methods:

1. PHP `ZipArchive` extension, preferred.
2. System `unzip` fallback, useful on servers where `php-zip` is not installed but the `unzip` command exists.

This makes the country importer more deployable across shared hosting, VPS and local XAMPP environments.

### 3. Public/internal field cleanup

The QA pass found internal-looking identifiers showing in public listings. The module configuration was cleaned so public-facing list views no longer expose raw source IDs, source URLs or import/debug fields. Data Quality modules remain available for Admin/operations use.

### 4. Pricing page resilience

The pricing page now has a fallback 3-tier model so it can render gracefully even before the database has been imported.

### 5. Phase 5 QA assets

Added QA output files in:

```text
qa/php_lint_phase5.txt
qa/static_qa_phase5.txt
qa/page_smoke_phase5.txt
```

---

# Consolidated implementation summary

## Phase 1 — Architecture and core database foundation

Completed:

- Global aviation data architecture.
- Normalised PHP/MySQL database model.
- Core aviation modules:
  - Countries
  - Airlines
  - Airports
  - Aircraft Registry
  - Aircraft Types
  - Lessors
  - Routes & Schedules
  - Regulatory
  - Infrastructure/AIM
  - Commercial
  - Reference Data
  - IATA/IOSA
  - GDS
- Source/data quality model:
  - import batches
  - staging records
  - dataset files
  - dataset records
  - source records
  - change log

## Phase 2 — Admin console

Completed:

- Separate Admin Console layout.
- Admin dashboard and action-focused navigation.
- Generic CRUD for every configured database module.
- Add/edit/delete/preview flows.
- User management.
- Plan management.
- Preset question management.
- Homepage insight management.
- Import/export centre.
- Data Quality review console.

## Phase 3 — Public/user app

Completed:

- Public homepage.
- Global search.
- Database catalogue.
- Database listing pages.
- Clickable airline, airport and aircraft-type cards.
- Drill-down detail pages.
- Logged-in user dashboard/member cockpit.
- Preset intelligence questions.
- Rotating charts and titbits.
- Login/register/account pages.
- Pro access gates.
- Three tiers only:
  - Free
  - Pro
  - Enterprise / Contact us

## Phase 4 — Importers

Completed:

Importers exist for:

- global datasets
- country ZIP datasets
- aircraft type datasets
- reference datasets
- commercial datasets
- IATA/IOSA datasets
- GDS datasets
- infrastructure/AIM datasets

Main command:

```bash
php scripts/importers/phase4_import.php --group=all
```

Examples:

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

Supported flags:

```bash
--mode=append
--mode=replace
--dry-run
--limit=1000
--store-raw=1
--path=/custom/path.csv-or-zip
```

## Phase 5 — QA and launch readiness

Completed:

- PHP syntax validation.
- Static module/schema consistency validation.
- Seed/schema consistency validation.
- Seed file size validation.
- Importer map/source-file validation.
- Page smoke test.
- Internal field exposure check.
- 3-tier access configuration check.
- ZIP package integrity validation.

---

# QA results

## PHP syntax/lint

Result: **PASS**

All PHP files passed `php -l`.

See:

```text
qa/php_lint_phase5.txt
```

## Static Phase 5 QA

Result: **PASS — 16/16 checks**

Checks included:

- schema file exists
- 119 schema tables detected
- all configured module tables exist
- all configured module fields exist
- modules use only Free / Pro / Enterprise tiers
- public listings hide internal fields
- 80 seed files detected
- no seed file exceeds 1MB
- 748 seed INSERT blocks match schema columns
- 39 global CSV source files found
- country ZIP source found
- country ZIP importer has a usable ZIP reader
- 8 importer groups configured
- 39 mapped global source files found
- 45 country importer mappings configured
- PHP file set detected

See:

```text
qa/static_qa_phase5.txt
```

## Page smoke test

Result: **PASS**

The following URLs returned HTTP 200 in the package smoke test:

- `/`
- `?page=home`
- `?page=search`
- `?page=catalogue`
- `?page=pricing`
- `?page=login`
- `?page=register`
- `?page=admin`
- `?page=reference`
- `?page=airlines`
- `?page=airports`
- `?page=aircraft_types`
- `?page=infrastructure`
- `?page=commercial`
- `?page=gds`
- `?page=iata-iosa`
- `?page=module&module=lessors`
- `?page=module&module=aircraft`
- `?page=module&module=ref_booking_classes`

See:

```text
qa/page_smoke_phase5.txt
```

## Database-dependent QA note

The sandbox used for package assembly does not have the `pdo_mysql` PHP driver or a MySQL/MariaDB server available, so browser smoke testing was performed against graceful no-database rendering and static consistency checks.

After deployment on your server/XAMPP/VPS, run:

```bash
php scripts/qa_phase5_check.php --db
```

That command confirms the live MySQL connection and key table counts after importing the schema and seed data.

---

# Deployment instructions

## Requirements

Recommended:

- PHP 8.1+
- MySQL 8+ or MariaDB 10.5+
- PDO MySQL extension enabled
- `mbstring`
- `json`
- `fileinfo`
- `zip` PHP extension preferred, or system `unzip` command available
- Apache/Nginx/XAMPP/cPanel-compatible hosting

## Install steps

1. Upload/extract the project folder to your web root:

```text
/var/www/angani-data
```

or XAMPP:

```text
C:\xampp\htdocs\angani-data
```

2. Edit database credentials:

```text
includes/config.php
```

3. Create database and schema:

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
```

4. Import seed data:

```bash
php database/import_all_seeds.php
```

Alternative, if you prefer direct SQL:

```bash
mysql -u root -p angani_data < database/02_seed_data.sql
```

5. Run QA:

```bash
php scripts/qa_phase5_check.php
php scripts/qa_phase5_check.php --db
```

6. Open the app:

```text
http://your-domain.com/
```

7. Log in:

```text
Admin: admin@angani.co.uk / Angani@2026
Pro:   pro@angani.co.uk / Angani@2026
Free:  free@angani.co.uk / Angani@2026
```

8. Immediately change the admin password after first login.

---

# Production hardening checklist

Before exposing publicly:

- Change demo passwords.
- Move database credentials out of web-accessible paths if your host allows it.
- Force HTTPS.
- Set secure cookie/session settings.
- Disable PHP error display in production.
- Confirm export limits for Pro users.
- Add payment integration for Pro subscriptions.
- Add password reset/email verification if required.
- Review licensing/terms for scraped datasets.
- Add privacy policy, terms and aviation data disclaimer.
- Verify country/regulatory/commercial data before selling it as professional intelligence.

---

# Data product caveat

Operational datasets such as frequencies, NOTAMs, schedules and commercial fares are presented as reference/intelligence datasets, not live operational data. Add a visible disclaimer before production use:

> Angani Data is for research, planning and commercial intelligence. Always verify operational aviation information with official AIS/AIM, CAA, airport, airline and manufacturer sources before flight operations.
