# Admin Guide — Managing the Angani Data System

This guide explains how to use the Admin Console. You need an admin account to access these features.

**Demo admin account**: `admin@angani.co.uk` / `Angani@2026`

**Admin URL**: Go to `?page=admin` or `admin/` after logging in.

---

## 1. Accessing the Admin Console

1. Log in with an admin account
2. Click your name/avatar in the top-right, or go directly to `?page=admin`
3. You'll see the Admin Command Center with:
   - **KPI Grid** — System statistics (users, modules populated, total records, pending reports)
   - **Action Cards** — Quick links to common tasks
   - **Module Grid** — All datasets with record counts

---

## 2. Admin Tabs Explained

### 2.1 Overview (Command Center)

Shows system-wide statistics and quick actions. Use this to get a snapshot of system health.

### 2.2 Users

Manage user accounts:

- **View users**: Table showing all users (name, email, tier, role, status, last login)
- **Search users**: Filter by name, email, or tier
- **Add user**: Click "Add User" and fill in name, email, password, tier, role, status
- **Edit user**: Click "Edit" on any user row to change their name, tier, role, or status
- **Inline editing**: Click the tier/role/status cells to edit directly

**Fields**: name, email, password_hash, tier_id (Free/Pro/Enterprise), role (user/admin), status (active/suspended/deleted)

### 2.3 Plans (Subscription Tiers)

Manage the three pricing tiers:

- **Edit tier**: Change name, monthly/annual price, display order, active status
- **Benefits/Features**: For each tier, add or remove features:
  - Feature code (e.g., `csv_exports`, `api_access`, `premium_datasets`)
  - Feature label (what the user sees, e.g., "CSV exports")

### 2.4 Questions (Preset Questions)

Manage the preset intelligence questions shown on user dashboards:

- **Add question**: Click "Add Question"
- **Fields**: code (unique key), title, question text, category, answer_key (which query to run), required_tier_id (which tier can access it)
- **Edit/delete**: Click the action buttons on each question row
- **Active/inactive**: Toggle whether a question appears

**Available answer keys**: `route_competitors`, `oldest_aircraft`, `highest_airports`, `fleet_by_country`, `regulatory_by_country`, `hub_airlines`, `short_runway_aircraft`, `saf_compatible_aircraft`, `sources_to_review`

### 2.5 Insights (Homepage Cards)

Manage the rotating insight cards on the public homepage:

- **Fields**: title, metric_label, query_key (which insight query), chart_type, required_tier_id, display_order, is_active
- **Available query keys**: `oldest_aircraft`, `highest_airports`, `smallest_airlines_capacity`, `routes_with_competition`, `dataset_coverage`, `regulatory_depth`, `short_runway_aircraft`, `navaid_coverage`

### 2.6 Imports

Import data from CSV files:

**Steps:**
1. Select the target module from the dropdown (e.g., "Airlines", "Airports")
2. Upload a CSV file (first row must be column headers matching database column names)
3. Choose import mode:
   - **Append** — Add records to existing data (skips duplicates)
   - **Truncate & Insert** — Clear the table first, then insert all records
4. Click "Import CSV" to start

**After import:**
- Success/failure summary is shown
- Failed rows go to staging for review
- Recent imports are listed below with status

**Also shows:**
- Import batch history (batch name, module, status, timestamp)
- Link to run CLI PHP importers

### 2.7 Quality (Data Quality Dashboard)

Monitor data quality across the system:

- **Staging records** — Pending review from pipeline imports. Accept or reject individual records.
- **Import batches** — History of all imports
- **Export logs** — History of all CSV/ZIP exports
- **Empty modules** — Tables with zero records that need data
- **Data completeness** — For each of 14 primary tables, shows:
  - Total records
  - Fill rate percentage for each column
  - Helps identify which columns need more data

### 2.8 Tasks (Implementation Checklist)

Project management for the admin team. Shows tasks grouped by category (Database, Backend, Frontend, Pipeline, Admin, etc.) with status (pending/in_progress/done/blocked) and priority.

- Click status or priority to edit inline
- Add new tasks as needed

### 2.9 Pipeline

Manage the data pipeline system (for automated data ingestion):

- **Sources**: Add/edit data sources (API, CSV upload, URL CSV)
  - Fields: source_name, source_type (api/scraper/csv_upload/url_csv), module_key, url, cron schedule
- **Pending Reviews**: Staging records awaiting approval from pipeline runs
- **Run History**: All pipeline runs with status, record counts (fetched/valid/inserted/updated/deleted)

**Pipeline flow:**
1. Source added → 2. Run triggered → 3. Data fetched → 4. Validated → 5. Staged → 6. Approved/Rejected → 7. Published to live tables

### 2.10 Data Audit

Track every change made to data:

- **Audit Log**: Shows all INSERT, UPDATE, DELETE, TRUNCATE, IMPORT actions
  - Filter by table name
  - Shows old and new values (as JSON)
  - Shows which user made the change
  - Shows data license attribution
- **Provenance**: Per-table data source tracking
  - Set collection method, primary source URL, and license for each table
- **Licenses**: Manage data licenses (name, URL, description, commercial use flag)

### 2.11 Reports

Generate computed statistics:

- **Country Air Transport Stats**: Click "Generate Country Stats" to compute airport/airline counts per country (writes to `country_air_transport_stats`)
- **Country Time Series**: Click "Populate Country Time Series" to fetch GDP, population, and traffic data from World Bank API (writes to `country_time_series`)

These run CLI PHP scripts (`scripts/reports/`) and may take a few minutes.

### 2.12 Data Reports (User Feedback)

View and manage user-submitted "Report data problem" forms:

- Shows all reports with: entity type, entity ID, report type (wrong/old/other), description, status
- **Status workflow**: open → in_progress → resolved / dismissed
- Update status and optionally notify the reporter via email

### 2.13 Email

Configure email providers for sending notifications:

- **Supported providers**: Sendpulse, Postmark, Brevo (Sendinblue), Mailgun, Amazon SES, Zapier webhook, PHP mail() fallback
- **Fields per provider**: Name, provider type, API key, is_active, is_default
- **Test sending**: Click "Send test email" to verify configuration works
- Email is used for: report status notifications, account-related emails (future)

### 2.14 Backup

Create and manage system backups:

- **Create backup**: Generates a numbered ZIP containing:
  1. MySQL dump of the entire database
  2. All project files (PHP, CSS, JS, assets)
  - Max 100MB per ZIP file
- **Download backup**: Click to download any available backup
- **Delete backups**: Remove old backup files

Backups are stored in the `backups/` directory on the server.

### 2.15 Mirror

Manage the secondary/mirror server:

- **Mirror server**: `134.209.114.217` (DigitalOcean droplet)
- **Sync method**: SSH + rsync + MySQL dump/restore
- **Status**: Shows last sync time and status
- **Manual sync**: Click "Sync now" to trigger immediate mirror
- **Cron**: Set up cron on the main server to sync every 5 minutes

### 2.16 Records (CRUD)

Direct record management for any module:

1. Select a module from the dropdown
2. Search/filter records
3. Browse paginated table
4. Click "Edit" to modify a record
5. Click "Preview" to view on the public site
6. Click "Add New" to create a record

**Editing a record:**
- Shows all editable fields in a form
- Text fields, textareas, and number fields auto-detect
- Save creates an audit log entry with old/new values
- "Danger Zone" section allows permanent deletion (with confirmation)

---

## 3. Common Admin Tasks

### Adding a New Dataset Record

1. Go to Admin → Records
2. Select the module (e.g., "Airlines")
3. Click "Add New"
4. Fill in the fields
5. Click "Save"
6. The record appears on the public site immediately

### Editing a Dataset Record

1. Go to Admin → Records
2. Find the record by searching
3. Click "Edit"
4. Change any field
5. Click "Save"
6. The change is logged in Data Audit

### Deleting a Dataset Record

1. Go to Admin → Records
2. Find the record
3. Click "Edit"
4. Scroll to the "Danger Zone"
5. Click "Delete this record permanently"
6. Confirm the deletion

### Importing Data from CSV

1. Go to Admin → Imports
2. Select the target module
3. Upload CSV (headers must match DB column names)
4. Choose Append or Truncate+Insert
5. Click "Import CSV"
6. Review the results summary

### Adding a Preset Question

1. Go to Admin → Questions
2. Click "Add Question"
3. Fill in: code (unique), title, question text, category, answer_key, required_tier
4. Click "Save"
5. The question appears on all user dashboards immediately

### Running Country Reports

1. Go to Admin → Reports
2. Click "Generate Country Stats"
3. Wait for the script to complete (may take 1-2 minutes)
4. Country detail pages now show updated stats
5. Optionally click "Populate Country Time Series" for economic data

### Setting Up Email

1. Go to Admin → Email
2. Click "Add Provider"
3. Choose provider type (e.g., "Brevo")
4. Enter the API key
5. Set as active and default
6. Click "Save"
7. Click "Send test email" to verify

---

## 4. User Roles

| Role | Permissions |
|------|------------|
| **user** | Access based on their tier (Free/Pro/Enterprise). No admin access. |
| **admin** | Full access to everything: all modules, all tiers, admin console, CRUD operations, import/export, pipeline management, user management, system configuration. |

---

## 5. Troubleshooting

| Problem | Likely Cause | Solution |
|---------|-------------|----------|
| Cannot import CSV | Column headers don't match DB | Check the CSV header row matches the module's field names exactly |
| Users can't log in | Account suspended or deleted | Go to Admin → Users, find the user, set status to "active" |
| Insight cards not showing | Cards need to be activated | Go to Admin → Insights, ensure cards have "is_active" checked |
| Preset questions empty | No questions added or all inactive | Go to Admin → Questions, add at least one active question |
| Country stats showing "Not yet computed" | Reports not run | Go to Admin → Reports, generate country stats |
| Email not sending | Provider not configured or API key invalid | Go to Admin → Email, verify provider settings, send test |
| Page looks wrong | Browser cache | Hard refresh (Ctrl+F5) |
| Data not appearing after import | Import may have failed | Check Admin → Imports → Recent import history for errors |
