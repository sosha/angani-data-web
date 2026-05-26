# Angani Data — PHP/MySQL Web App

This is the complete PHP/MySQL version of the Angani Data web app.

It includes the application, assets, schema, deployment guides, and the database seeds already split into small table/category-specific SQL files.

## What is included

```text
angani_data_php_mysql_complete_project/
  index.php
  favicon.ico
  assets/
  css/
  js/
  includes/
    config.php
    config.example.php
    db.php
    functions.php
  database/
    00_create_database.sql
    01_schema.sql
    02_seed_data.sql
    seeds/
      01_countries.sql
      02_airlines_001.sql
      02_airlines_002.sql
      03_aircraft_registrations_001.sql
      ...
      09_dataset_records_022.sql
    IMPORT_ORDER.md
    SEED_FILE_SIZE_REPORT.txt
    import_all_seeds.sh
    import_all_seeds.php
  DEPLOYMENT.md
```

## Seed file structure

The old single large seed file has been replaced with already-split SQL files inside:

```text
database/seeds/
```

No seed SQL file is larger than 1MB. The largest generated file is listed in:

```text
database/SEED_FILE_SIZE_REPORT.txt
```

## Imported dataset counts

- Countries: 252
- Airlines: 5,490
- Aircraft registrations: 35,522
- Aircraft types: 248
- Airports: 40
- Airline destinations: 290
- Regulatory records: 160
- Dataset files: 22,591
- Raw CSV records: 51,034

## Local XAMPP setup

Copy the folder to:

```text
C:\xampp\htdocs\angani-data
```

Then run:

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
php database/import_all_seeds.php
```

Then open:

```text
http://localhost/angani-data/
```

## Linux / VPS setup

Create the database:

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
```

Import all split seed files:

```bash
php database/import_all_seeds.php
```

Or use the shell importer:

```bash
./database/import_all_seeds.sh angani_data root 127.0.0.1
```

## phpMyAdmin / cPanel setup

1. Create the database.
2. Import `database/01_schema.sql`.
3. Import the SQL files in `database/seeds/` in filename order.
4. Update `includes/config.php` with your database credentials.

## App features

- Premium Angani-styled data portal.
- Main sections: Overview, Airlines, Airports, Aircraft, Regulatory, Datasets, Contact.
- Airline filtering by Active, Defunct, and All statuses.
- Active airlines selected by default.
- Search and filter controls.
- Airline detail pages with core data, aircraft, and destination records where linked data exists.
- Airports and regulatory datasets included.
- Coming-soon treatment for unpopulated datasets.
- Angani logo favicon and brand assets included.
