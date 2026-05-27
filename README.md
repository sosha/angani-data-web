# Angani Data — PHP/MySQL Aviation Intelligence App

This is the updated Angani Data web app. It keeps the existing aviation source datasets and adds the missing product layer: user accounts, access tiers, preset intelligence questions, route/equipment modelling, admin-managed homepage insights, and a more serious aviation-grade visual design.

## What changed

- New aviation-grade UI using Angani-style navy, brass/gold, cream and aviation blue.
- Replaced playful typography with IBM Plex Sans / IBM Plex Sans Condensed / IBM Plex Mono.
- Added login, register, logout and account management.
- Added subscription tiers and database-backed feature gates.
- Added public homepage graphs/titbits: oldest aircraft, highest airport, smallest airline by fleet size, route competition, dataset coverage and regulatory depth.
- Added preset questions users can answer after login.
- Added admin area for tasks, users, tiers and homepage insight cards.
- Added normalised aviation schema for organisations, key staff, AOCs, lessors, route markets, route services, schedules, route equipment, aircraft history, sources and change logs.
- Kept the original raw dataset tables for imports and backwards compatibility.

## Demo accounts

All seeded demo accounts use this password:

```text
Angani@2026
```

Accounts:

```text
admin@angani.co.uk   Enterprise/Admin
analyst@angani.co.uk Analyst
pro@angani.co.uk     Pro
```

## Installation

1. Create the database:

```bash
mysql -u root -p < database/00_create_database.sql
```

2. Import the schema:

```bash
mysql -u root -p angani_data < database/01_schema.sql
```

3. Update `includes/config.php` with your database credentials.

4. Import the seed files:

```bash
php database/import_all_seeds.php
```

5. Run locally:

```bash
php -S localhost:8000
```

Open:

```text
http://localhost:8000
```

## Important production notes

- Change all demo passwords before going live.
- Block web access to `/database`, `/scripts` and private admin utilities.
- Add HTTPS and force HTTP to HTTPS redirect.
- Add password reset and email verification before public launch.
- Add payment integration before allowing real paid tier upgrades.
- Review source licences before commercial redistribution of scraped data.

## Files to review

- `TASKS_TO_GET_100_PERCENT.md` — full build checklist.
- `database/01_schema.sql` — current and new schema.
- `database/seeds/10_platform_access_questions_insights.sql` — tiers, accounts, preset questions and homepage insights.
- `database/seeds/11_aviation_schema_starter_seed.sql` — starter route/equipment/aircraft-history examples.
- `index.php` — main router and pages.
- `includes/functions.php` — auth, feature access, insights and preset query logic.
