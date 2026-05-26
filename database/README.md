# Angani Data — PHP/MySQL Web App

This package converts the Angani Data static app into a PHP/MySQL application with the same premium Angani look and main functionality.

## Included
- `index.php` — PHP app with routes for Overview, Airlines, Airline Profile, Airports, Aircraft, Regulatory, Datasets and Contact.
- `includes/config.php` — database credentials.
- `database/00_create_database.sql` — creates `angani_data`.
- `database/01_schema.sql` — creates tables and indexes.
- `database/02_seed_data.sql` — small loader file that imports the split seed files.
- `database/seeds/` — table-specific seed files, each below 1MB.
- `database/import_all_seeds.sh` — command-line MySQL importer for all split seed files.
- `database/import_all_seeds.php` — PHP CLI importer that reads `includes/config.php`.
- `assets/`, `css/`, `js/` — frontend assets and styling.

## Imported counts
- Countries: 252
- Airlines: 5,490
- Aircraft registrations: 35,522
- Aircraft types: 248
- Airports: 40
- Airline destinations: 290
- Regulatory records: 160
- Dataset files: 22,591
- Raw CSV records: 51,034

## Why the seed files are split
The original seed was too large for many servers, cPanel, phpMyAdmin and browser uploads. The data has now been split into database/table-specific SQL files in `database/seeds/`. No seed file is above 1MB.

## XAMPP / local deployment
1. Copy this folder to `C:\xampp\htdocs\angani-data`.
2. Start Apache and MySQL.
3. Open a terminal in the app root and run:

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
php database/import_all_seeds.php
```

Alternative MySQL-only import from the app root:

```bash
mysql -u root -p angani_data < database/02_seed_data.sql
```

4. Edit `includes/config.php` if your MySQL username/password differs from the default.
5. Open `http://localhost/angani-data/`.

## phpMyAdmin deployment
1. Create a database called `angani_data`.
2. Import `database/01_schema.sql` first.
3. Import the files in `database/seeds/` in filename order. The import order is also listed in `database/IMPORT_ORDER.md`.
4. Update `includes/config.php` with the DB credentials.

## cPanel / Linux deployment
1. Upload the app folder to `public_html/angani-data`, `/var/www/angani-data`, or your chosen location.
2. Create a MySQL database and user.
3. Import the schema:

```bash
mysql -u DB_USER -p DB_NAME < database/01_schema.sql
```

4. Import the split seed files:

```bash
./database/import_all_seeds.sh DB_NAME DB_USER 127.0.0.1
```

Or use PHP CLI after updating `includes/config.php`:

```bash
php database/import_all_seeds.php
```

## Notes
- The Airlines page defaults to `Active` and includes `Defunct` / `All statuses` filters.
- Airline profile pages show aircraft and destinations where codes/names match.
- The Datasets page keeps unpopulated CSV templates visible as `Coming soon`.
- Raw source CSV rows are preserved in `dataset_records.row_json` for future pages.
- Copyright/contact: Angani Solutions, www.angani.co.uk, Silas Savali, info@angani.co.uk, +254 721 555 779.
