# Angani Data Database

Import order:

1. `00_create_database.sql`
2. `01_schema.sql`
3. All files in `database/seeds/` in filename order, or run `php database/import_all_seeds.php`.

The seed set includes:

- Original country, airline, aircraft, airport, destination, regulatory and dataset records.
- Platform access seeds: Free, Pro, Enterprise tiers and demo users.
- Aircraft type intelligence: specs, payload, economics, engines, environment, production, history and sources.
- Lessors.
- Reference data.
- IATA/IOSA.
- GDS.
- Infrastructure/AIM data from the uploaded country package.
- Airports/frequencies/navaids/regulatory country data from `countries.zip` converted into normalised SQL seeds.

All seed files are split for easier hosting import. See `SEED_FILE_SIZE_REPORT.txt`.
