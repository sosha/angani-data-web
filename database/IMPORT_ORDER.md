# Angani Data Seed Import Order

Import in this order:

1. `database/00_create_database.sql`
2. `database/01_schema.sql`
3. All files in `database/seeds/` in filename order.

The CLI importer does step 3 automatically:

```bash
php database/import_all_seeds.php
```

The seed files are intentionally split below 1MB for cPanel/phpMyAdmin-friendly importing.

## Seed groups

- `01_countries.sql` — country master data
- `02_airlines_*.sql` — airline source records
- `03_aircraft_registrations_*.sql` — aircraft registration source records
- `04_aircraft_types.sql` — aircraft type source records
- `05_airports.sql` — airport source records
- `06_airline_destinations.sql` — legacy destination rows
- `07_regulatory_records.sql` — regulatory source rows
- `08_dataset_files_*.sql` — raw CSV catalogue
- `09_dataset_records_*.sql` — raw JSON row storage
- `10_platform_access_questions_insights.sql` — tiers, demo users, preset questions and homepage insights
- `11_aviation_schema_starter_seed.sql` — starter route/equipment/history data for the normalised schema
