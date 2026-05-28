# Angani Data Phase 4 Importers

Run from the project root after database setup:

```bash
php scripts/importers/phase4_import.php --group=all
```

Available groups:

- `global`
- `country`
- `aircraft`
- `reference`
- `commercial`
- `iata-iosa`
- `gds`
- `infrastructure`
- `all`

Examples:

```bash
php scripts/importers/phase4_import.php --group=country --country=KE
php scripts/importers/phase4_import.php --group=aircraft --mode=replace
php scripts/importers/phase4_import.php --group=reference --dry-run
php scripts/importers/phase4_import.php --group=infrastructure --store-raw=1
```

Mappings live in `DatasetMap.php`. Failed rows are staged into `staging_import_records` and batches are logged in `import_batches`.
