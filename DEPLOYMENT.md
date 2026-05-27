# Deployment Guide

## Local XAMPP

1. Copy the project folder to `C:\xampp\htdocs\angani-data`.
2. Start Apache and MySQL.
3. Open a terminal inside the project folder.
4. Run:

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
php database/import_all_seeds.php
```

5. Visit `http://localhost/angani-data/`.

## cPanel / shared hosting

1. Upload the project folder to your hosting account.
2. Create a MySQL database and user.
3. Edit `includes/config.php` with your cPanel database name, user and password.
4. Import `database/01_schema.sql` first.
5. Import all files in `database/seeds/` in filename order. Use `database/IMPORT_ORDER.md`.
6. Log in as Admin and change the default password.

## Linux server

```bash
mysql -u DB_USER -p DB_NAME < database/01_schema.sql
php database/import_all_seeds.php
```

The importer reads `includes/config.php`.

## After deployment

- Change the default admin password.
- Review Admin → Plans.
- Review Admin → Homepage Insights.
- Review Admin → Imports / Exports.
- Add/verify source URLs for high-value commercial/regulatory records.
