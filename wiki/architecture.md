# Architecture

## Overview

Vanilla PHP 8.x application with no framework, no Composer, single-file routing, and a 80+ function `includes/functions.php`.

## File Layout

```
angani-data-web/
  index.php                  # Router: all public pages
  install.php                # 3-step guided restore from backup
  includes/
    config.php               # DB credentials (git-ignored)
    config.example.php       # Example config
    db.php                   # PDO singleton + helpers (rows, row, scalar, exec_sql)
    functions.php            # All app functions (~920 lines, 80+ functions)
    modules.php              # Module definitions + groups (80+ datasets)
    admin_render.php         # Admin console rendering (~567 lines)
  css/styles.css             # Single CSS file (112 lines, custom properties)
  js/app.js                  # Minified vanilla JS (~1.8KB)
  admin/
    index.php                # Admin entry point
    pages/bulk_operations.php
  scripts/                   # CLI scripts (importers, pipeline, reports, etc.)
  database/                  # SQL schema, migrations, seeds
  assets/                    # Logos, images, icons
  wiki/                      # Project documentation
```

## Request Flow

```
Browser --> ?page=airlines&q=search
  -> index.php: include db.php, functions.php
  -> handle_post_actions() (any POST forms)
  -> getv('page', 'home') determines page
  -> module_key_from_page($page) maps URL to module key
  -> login check for protected pages
  -> render based on $page:
       home, search, catalogue, module, detail, pricing,
       login, register, account, dashboard, answer, admin, contact
```

## Module System

Defined in `includes/modules.php`. Each module has: label, table, icon, tier (`free`/`pro`/`enterprise`), title field, subtitle field, searchable columns, list columns, detail columns, editable fields, card type.

8 groups: Core, Airline Intelligence, Airport & Infrastructure, Aircraft Intelligence, Regulatory & Standards, Commercial, Reference, Data Quality.

## Database Layer

- **Connections**: `db()` returns a singleton PDO with `ERRMODE_EXCEPTION`, `FETCH_ASSOC`, real prepared statements
- **Helpers**: `rows()`, `row()`, `scalar()`, `exec_sql()`, `table_exists()`
- **Security**: All queries use prepared statements with `?` placeholders

## Frontend

- **CSS**: Single `styles.css` with CSS custom properties for theming (`--ink`, `--paper`, `--gold`, `--sky`, `--green`, `--red`)
- **JS**: One minified file handling mobile menu, footer year, back-to-top, auto-submit, card animations, search overlay
- **XCard pages**: Inline PHP-generated JS for expand/collapse, search filtering, filter pills

## Authentication & Access Control

- `users` table with bcrypt password hashes
- Three tiers: Free / Pro / Ultimate (in `subscription_tiers`)
- Access checks: `has_tier('pro')`, `module_allowed()`, `feature_allowed()`, `preset_allowed()`
- Roles: `user` (tier-gated), `admin` (full access)

## Detail Page Tab System

Three layers:
1. `$dtabs` in index.php -- defines tabs per module
2. `$tabSections` in index.php -- maps tab keys to section titles
3. `render_related_sections()` in functions.php -- generates section HTML
4. Explicit tab handlers for special cases (registry, stats, timeseries)

## Admin Console

- All pages rendered by `render_admin_page()` in `admin_render.php`
- Tabs: Overview, Users, Plans, Questions, Insights, Imports, Quality, Tasks, Pipeline, Data Audit, Reports, Data Reports, Email, Backup, Mirror, Records
- CRUD operations via `admin_save_record()` / `admin_delete_record()`
- CSV import via `admin_import_csv()`
- All changes logged to `data_audit_log`

## Data Export

- CSV export: `export_module_csv()` (any module via `?page=export&module=xxx`)
- Full ZIP: `export_database_zip()` with manifest
- Admin bulk export: `admin/pages/bulk_operations.php`

## Key Design Decisions

- No PHP framework -- everything is vanilla
- No ORM -- raw SQL with prepared statements
- No Composer -- zero external PHP dependencies
- Single file for all app logic (`functions.php`)
- Minimal JS -- most interactivity is server-rendered
- All styles in one CSS file
- Manual SQL migrations in `database/` with sequential numbering
