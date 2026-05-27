# Angani Data Deployment Runbook

## 1. Upload files

Upload the complete project folder to your server web root.

Example:

```bash
/var/www/html/angani-data
```

For XAMPP:

```text
C:\xampp\htdocs\angani-data
```

## 2. Configure database

Edit:

```text
includes/config.php
```

Example:

```php
return [
    'host' => '127.0.0.1',
    'port' => '3306',
    'database' => 'angani_data',
    'username' => 'root',
    'password' => '',
    'charset' => 'utf8mb4',
];
```

## 3. Create database and tables

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
```

## 4. Import seed data

Preferred:

```bash
php database/import_all_seeds.php
```

This imports every file in `database/seeds/` in order.

## 5. Run QA

```bash
php scripts/qa_phase5_check.php
php scripts/qa_phase5_check.php --db
```

## 6. Run source importers when needed

```bash
php scripts/importers/phase4_import.php --group=all
```

Country-specific example:

```bash
php scripts/importers/phase4_import.php --group=country --country=KE
```

Replace mode:

```bash
php scripts/importers/phase4_import.php --group=reference --mode=replace
```

Dry run:

```bash
php scripts/importers/phase4_import.php --group=aircraft --dry-run --limit=1000
```

## 7. Log in

```text
Admin: admin@angani.co.uk / Angani@2026
Pro:   pro@angani.co.uk / Angani@2026
Free:  free@angani.co.uk / Angani@2026
```

Change the admin password immediately.

## 8. Admin workflow

Go to:

```text
?page=admin
```

Use:

- Records & CRUD
- Imports / Exports
- Users
- Plans
- Preset Questions
- Homepage Insights
- Data Quality

## 9. Troubleshooting

### Blank page / database error

Check:

- `includes/config.php`
- MySQL credentials
- PDO MySQL extension
- database import completed

### Country ZIP import fails

Install PHP zip extension or make sure `unzip` is available:

```bash
php -m | grep zip
command -v unzip
```

### Large seed imports fail in phpMyAdmin

Use CLI:

```bash
php database/import_all_seeds.php
```

The individual seed files are already split below 1MB.
