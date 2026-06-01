# Developer Guide — Code Architecture & How to Modify

This guide explains how the application is built, how every piece of code works, and how to make changes. It assumes you know PHP, MySQL, HTML, CSS, and JavaScript.

---

## 1. Project Structure

```
angani-data-web/
├── index.php                 # Main application router (all public pages)
├── install.php               # 3-step guided restore from backup
├── admin/
│   ├── index.php              # Admin console entry point
│   └── pages/
│       └── bulk_operations.php # Admin bulk utilities
├── includes/
│   ├── config.php             # Database credentials (git-ignored)
│   ├── config.example.php     # Example config template
│   ├── db.php                 # PDO database connection + helper functions
│   ├── functions.php          # ALL application functions (920+ lines, 80+ functions)
│   ├── modules.php            # Module definitions (128 lines)
│   └── admin_render.php       # Admin console rendering (567 lines)
├── css/
│   └── styles.css             # All CSS (112 lines, single file)
├── js/
│   └── app.js                 # All JavaScript (minified, ~1.8KB)
├── scripts/                   # CLI scripts (importers, pipeline, reports, migrations)
│   ├── importers/             # Phase 4 import engine
│   ├── pipeline/              # Pipeline processing engine
│   └── reports/               # Report generators
├── database/                  # SQL schema files, migrations, seeds
├── assets/                    # Static assets (images, icons)
└── wiki/                      # Project documentation (this folder)
```

**Key architectural decisions:**
- **No framework** — Vanilla PHP with no Composer dependencies
- **Single file application logic** — `includes/functions.php` contains ALL functions
- **Single file routing** — `index.php` handles ALL public page routing with `if/elseif` blocks
- **MySQL PDO** — All database access via `includes/db.php` helpers
- **No ORM** — Raw SQL queries throughout
- **Minimal JS** — ~1.8KB of minified vanilla JS; most interactivity is server-rendered

---

## 2. How the Router Works (index.php)

### Request Flow

```
Browser → ?page=airlines&q=search
  │
  ├── 1. index.php line 1-3: include db.php, functions.php
  ├── 2. handle_post_actions() — process any POST
  ├── 3. getv('page', 'home') — determine page
  │
  ├── 4. module_key_from_page($page) — check if it's a module page
  │     e.g., "airlines" → module "airlines"
  │     If yes, $_GET['module'] = module key, $page = 'module'
  │
  ├── 5. Check login requirements (dashboard/answer/account → must be logged in)
  │
  └── 6. Render based on $page:
        ├── 'home'     → hero + stats + insight cards + module grid
        ├── 'search'   → global_search($q) + render_global_search_results()
        ├── 'catalogue' → module groups with counts
        ├── 'module'   → query_module_records() + render_xcard_page() or render_table()
        ├── 'detail'   → row() + tab system + render_related_sections()
        ├── 'pricing'  → tier_cards() + tier_features()
        ├── 'login'    → login form
        ├── 'register' → register form
        ├── 'account'  → profile edit (login required)
        ├── 'dashboard' → preset questions + insight cards (login required)
        ├── 'answer'   → run_preset_query() + chart (login required)
        ├── 'admin'    → render_admin_page() (admin only)
        └── 'contact'  → static contact page
```

### How to Add a New Page

1. Add the page name to the `$valid` array in `index.php` (line ~14)
2. Add an `elseif($page==='yourpage')` block in the router
3. Optionally add a nav link in the header section
4. Add any form handling in `handle_post_actions()` if the page has POST forms

---

## 3. Module System (includes/modules.php)

The module system defines every dataset in the application. Each module has:

```php
'module_key' => [
    'label'    => 'Human Readable Name',     // Displayed in UI
    'table'    => 'actual_table_name',        // MySQL table
    'icon'     => '✈',                        // Emoji or icon class
    'tier'     => 'free'|'pro'|'enterprise',  // Access tier
    'title'    => 'field_name',               // Used as card title
    'subtitle' => 'field_name',               // Used as card subtitle
    'search'   => ['field1','field2',...],    // Fields searched by query
    'list'     => ['field1','field2',...],    // Fields shown in listing table
    'detail'   => ['field1','field2',...],    // Fields on detail page
    'fields'   => ['field1','field2',...],    // All editable fields (admin)
    'card'     => 'airline'|null,             // Card type for xcard renderer
]
```

### How to Add a New Module

1. Add a new entry in the `modules()` array in `includes/modules.php`
2. Add its table to the database (create migration SQL)
3. If it has a related module, add `render_related_sections()` handler in `functions.php`
4. If it needs custom detail page tabs, add `$dtabs` and `$tabSections` entries in `index.php`
5. If it should appear in global search, it's automatically included (the `global_search()` function loops ALL modules)
6. If it needs a card type, add a `case` in `render_record_card()` in `functions.php`

### How to Change Module Fields

- **Add a searchable field**: Add column name to the `search` array in the module config
- **Add a list column**: Add to the `list` array
- **Add a detail field**: Add to the `detail` array
- Remove from any array to hide it from that context
- Changes take effect immediately — no build step

---

## 4. Function Reference (includes/functions.php)

This file contains ALL application logic. Here are the most important functions:

### Core Helpers

| Function | Line | Purpose |
|----------|------|---------|
| `e($v)` | 6 | HTML-encode a string |
| `getv($key, $default)` | 7 | Read GET parameter |
| `postv($key, $default)` | 8 | Read POST parameter |
| `nfmt($v)` | 10 | Format number with commas |
| `labelize($s)` | 12 | Convert `snake_case` to `Title Case` |

### Authentication

| Function | Line | Purpose |
|----------|------|---------|
| `current_user()` | 27 | Get logged-in user (cached) |
| `is_logged_in()` | 35 | Check if user is authenticated |
| `is_admin()` | 36 | Check if user is admin |
| `has_tier($code)` | 44 | Check tier access |
| `module_allowed($cfg)` | 51 | Check if user can access a module |
| `login_user($email, $password)` | 80 | Authenticate and set session |
| `register_user($name, $email, $password)` | 87 | Create new account |
| `logout_user()` | 97 | Destroy session |

### Database

| Function | Line | Purpose |
|----------|------|---------|
| `query_module_records($cfg, $limit, $offset)` | 167 | Query a module with search/filter/sort/paginate |
| `global_search($term, $perModule)` | 673 | Search all modules |

### Rendering

| Function | Line | Purpose |
|----------|------|---------|
| `render_xcard_page($key, $cfg, $records, $total, $filterOpts)` | 288 | Render expandable card grid with JS search/filter |
| `render_record_card($key, $cfg, $r)` | 229 | Render a single card (handles 5 card types) |
| `render_table($rows, $columns, $moduleKey)` | 315 | Render HTML data table |
| `render_detail_fields($cfg, $r, $admin)` | 329 | Render detail field grid |
| `render_related_sections($key, $r)` | 334 | Render all related data sections per module |
| `render_search_bar($key, $cfg)` | 204 | Render filter toolbar |
| `render_global_search_results($results)` | 705 | Render search result cards |
| `render_report_modal($entityType, $entityId)` | 817 | Render "Report data problem" modal |
| `paginate($total, $per)` | 22 | Render Previous/Next pagination |

### Data

| Function | Line | Purpose |
|----------|------|---------|
| `display_value($v)` | 107 | Format a value for display (null→—, URL→link, truncate) |
| `public_field_label($f)` | 106 | Convert field name to human label |
| `status_chip($status)` | 117 | Render colored status chip |
| `detail_url($key, $id)` | 161 | Build detail page URL |
| `iso2_continent($iso2)` | 162 | Map ISO country code to continent |

### Admin

| Function | Line | Purpose |
|----------|------|---------|
| `admin_save_record()` | 510 | Create/update any module record |
| `admin_delete_record()` | 524 | Delete any module record |
| `admin_import_csv()` | 584 | Import CSV data |
| `export_module_csv($key)` | 626 | Export module as CSV |
| `export_database_zip()` | 637 | Export all modules as ZIP |

### Tabs System

The detail page tab system works in three layers:

1. **Tab definitions** (`$dtabs` in `index.php` line 119-131): Defines which tabs exist for which module
2. **Section mapping** (`$tabSections` in `index.php` line 225-229): Maps tab keys to related section titles
3. **Section rendering** (`render_related_sections()` in `functions.php` line 334): Generates HTML for each section

**How a tab gets its content:**
1. The tab key (e.g., `cabin`) is checked against `$tabSections` for a matching section title
2. The section HTML is generated by `render_related_sections()` and split by `<section class="related">` tags
3. Sections whose `<h3>` contains the matching title are shown in that tab
4. In the `overview` tab, all unmatched sections appear
5. Special tabs like registry, stats, timeseries have explicit handlers in `index.php`

**To add a new tab to a detail page:**
1. Add `$dtabs['tabkey']='Display Name';` for the module in `index.php`
2. Add `'module_key'=>['tabkey'=>'Exact section title']` to `$tabSections` in `index.php`
3. Add `$html.=related_table('Exact section title', 'SELECT...', [...])` to `render_related_sections()` in `functions.php`
4. OR add an explicit `if($key==='module' && $tabParam==='tabkey')` handler in `index.php` for custom rendering

---

## 5. Database Layer (includes/db.php)

```php
// Singleton PDO connection
db(): PDO

// Query helpers (all use prepared statements)
rows($sql, $params)      → array of associative arrays
row($sql, $params)       → single associative array or null
scalar($sql, $params)    → single value
exec_sql($sql, $params)  → boolean success
table_exists($table)     → boolean
```

**Security**: ALL queries use prepared statements via `$params` arrays. Never concatenate user input into SQL.

### How a Typical Module Query Works

`query_module_records()` (line 167):
1. Reads `$_GET['q']` for search term
2. Builds WHERE: `(search_col1 LIKE ? OR search_col2 LIKE ? ...)` with `%term%` params
3. Optionally adds `country_code=?` filter from `$_GET['country']`
4. Optionally adds status filter from `$_GET['status']`:
   - For `active` column: Y→active, N→defunct
   - For `status_bucket` or `status`: direct match
5. Reads `$_GET['sort']` or defaults to `last_modified DESC` / `updated_at DESC`
6. Returns `[$data, $total]` where total runs COUNT(*) and data runs SELECT with LIMIT/OFFSET

---

## 6. Frontend: CSS & JavaScript

### CSS (css/styles.css — 112 lines)

A single stylesheet with CSS custom properties for theming:

```css
--ink:#071521;        /* Dark backgrounds */
--paper:#f6f1e7;      /* Light backgrounds / text on dark */
--gold:#c6a35c;       /* Accent color */
--sky:#5d879d;        /* Secondary accent */
--green:#41695a;      /* Success / active states */
--red:#8e4a3d;        /* Danger / defunct states */
```

**Key classes:**
- `.xcard` / `.xcard.expanded` — Expandable cards
- `.xcard-filter` / `.xcard-filter.active` — Filter pill buttons
- `.detail-tabs` / `.tab` / `.tab.active` — Detail page tab bar
- `.btn` / `.btn.primary` / `.btn.ghost` / `.btn.ink` — Buttons
- `.chip` / `.chip.gold` / `.chip.danger` — Status badges
- `.panel` — Generic content panel
- `.xgrid` — Card grid layout (auto-fill, min 320px)

**Dark theme override** (line 14): When applied, sets dark body background and overrides card colors for the dark variant.

### JavaScript (js/app.js — 1 line minified, ~1.8KB)

All JavaScript is in one minified file. It handles:
- Mobile menu toggle (hamburger menu)
- Footer year auto-update
- Back-to-top button (appears after 500px scroll)
- Auto-submit forms (on change)
- Record card staggered animation
- Search overlay toggle

**XCard filtering is NOT in JS** — the search/filter for xcard pages is rendered inline by PHP in `render_xcard_page()` as a `script` tag in the HTML output. This inline JS handles:
- Expand/collapse on card click
- Search by typing (filters by `data-xs` attribute)
- Filter buttons (filters by `data-xf` attribute)
- Dynamic count updates

**To modify JS behavior:** Edit the inline script in `render_xcard_page()` (functions.php line ~303), or unminify and edit `js/app.js`.

---

## 7. Authentication & Access Control

### Flow
1. `login_user()` verifies password hash from `users` table
2. Sets `$_SESSION['user_id']`
3. `current_user()` queries `users LEFT JOIN subscription_tiers` with static cache
4. `has_tier('pro')` compares user's tier display_order vs target tier

### Access Checks
- **Module level**: `module_allowed($cfg)` checks if module's tier requirement is met
- **Page level**: Login-protected pages (dashboard, answer, account) redirect to login
- **Feature level**: `feature_allowed($feature)` checks tier_features table
- **Preset questions**: `preset_allowed($preset)` checks question's required_tier_id

---

## 8. How to Modify Common Things

### Change a Page Title or Description
Edit the HTML in the relevant `if($page==='...')` block in `index.php`.

### Add a Field to a Module
1. Add column to the MySQL table (write a migration SQL file)
2. Add field name to the module's `search`, `list`, `detail`, and/or `fields` arrays in `modules.php`

### Change the Search Behavior
Edit `query_module_records()` in `functions.php`. The search fields come from module config's `search` array.

### Change Filter Options
For xcard pages, edit the `$filterOpts` array passed to `render_xcard_page()`. This is built in the `module` page section of `index.php`.

### Change Card Layout
Edit `render_record_card()` in `functions.php`. Each card type (airline, airport, aircraft_type, country, aircraft) has its own `case` block.

### Change Detail Page Tabs
- Edit `$dtabs` array in `index.php` (line ~119-131)
- Edit `$tabSections` in `index.php` (line ~225-229)
- Edit `render_related_sections()` in `functions.php` (line ~334)
- Or add explicit `if($key==='module' && $tabParam==='tabkey')` blocks in `index.php`

### Change the Database
- Add migration SQL files in `database/` (numbered sequentially)
- Update `render_related_sections()` if the new table is related to an existing module
- Add a new module entry in `modules.php` if it's a new standalone dataset

### Change Styling
Edit `css/styles.css`. All styles are in one file. CSS custom properties at the top control the theme.

### Change JavaScript
Edit the inline script in `render_xcard_page()` for card page behavior, or unminify and edit `js/app.js` for global behavior.

---

## 9. Importing Data

### CSV Import (Admin Console)
1. Go to Admin → Imports
2. Select the target module
3. Upload CSV (first row must be column headers matching DB columns)
4. Choose Append or Truncate+Insert
5. System validates and imports with batch tracking

### PHP Import Scripts
Located in `scripts/`. These are CLI scripts for bulk imports:
- `php scripts/importers/phase4_import.php --group=all` — Import all dataset groups
- `php scripts/ingest_*.php` — Specialised importers for specific data sources
- `php scripts/migrate_all_v2_tables.php` — V2 schema migration

### SQL Seeds
Located in `database/seeds/`. Loaded via:
- `php database/import_all_seeds.php` — PHP seed importer
- `mysql < database/02_seed_data.sql` — MySQL CLI seed loader

---

## 10. Exporting Data

- **CSV**: Add `?page=export&module=xxx` to download any module as CSV
- **Full ZIP**: Add `?page=export_all` to download all modules as ZIP with manifest
- **Admin Console**: Admin → Imports → Export CSV button
- **Admin Bulk**: `admin/pages/bulk_operations.php` — Export any table (max 50k rows)

---

## 11. Testing

### No automated test framework exists
There is no PHPUnit, no test suite, and no CI/CD pipeline. Testing is manual.

### How to test changes:

**Before deploying:**
1. Check PHP syntax: `php -l index.php && php -l includes/functions.php`
2. Make sure there are no `var_dump()` or `error_log()` calls left in
3. Verify the change works locally or on staging

**After deploying:**
1. Load the affected page(s) in a browser
2. Do a hard refresh (Ctrl+F5) to bypass cache
3. Check browser console (F12) for JavaScript errors
4. Test with different filter/search combinations
5. Test edge cases: empty results, very long values, special characters
6. Test on both desktop and mobile viewports
7. Test with both admin and non-admin accounts (if access control is affected)

**To add basic testing:**
- Create a `tests/` directory with PHP scripts that include `db.php` and run queries/functions
- Test that `table_columns()` returns expected columns for each table
- Test that `query_module_records()` returns expected structure
- Test that `iso2_continent()` maps correctly for known countries

---

## 12. Coding Conventions

- **PHP**: No frameworks, no Composer, no autoloading. All functions in `includes/functions.php`. Use `include`/`require` manually. Functions use snake_case.
- **SQL**: All queries use prepared statements with `?` placeholders. Never concatenate variables into SQL.
- **HTML**: Output with `<?=e($var)?>` to escape. Class names use kebab-case (`.xcard-filter`, `.detail-tabs`).
- **CSS**: Single file, CSS custom properties for theming, mobile-first responsive via media queries.
- **JS**: Minimal. Vanilla JS only. Event listeners, not jQuery. Inline scripts for page-specific behavior.
- **No database migrations framework** — manual SQL files in `database/` with numbered prefixes.
