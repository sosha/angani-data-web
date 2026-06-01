# Deployment Guide — Installing & Operating the System

This guide explains how to set up the Angani Data application on a server from scratch. It covers everything a system administrator needs to know.

---

## 1. System Requirements

| Component | Requirement |
|-----------|-------------|
| **Web server** | Apache 2.4+ or Nginx |
| **PHP** | 8.0 or higher |
| **MySQL** | 8.0 or higher (or MariaDB 10.5+) |
| **PHP extensions** | PDO, PDO_MySQL, JSON, mbstring, curl, zip, xml |
| **OS** | Ubuntu 20.04+ / Debian 11+ (recommended) |
| **Disk space** | Minimum 500 MB for application, 1 GB+ recommended for data |
| **Memory** | Minimum 512 MB RAM, 1 GB+ recommended |

---

## 2. Installation (Step by Step)

### Step 1: Clone the Repository

```bash
cd /var/www
git clone https://github.com/sosha/angani-data-web.git angani-data
cd angani-data
```

### Step 2: Install Dependencies

This project has **no Composer dependencies** (no framework). Just ensure PHP and MySQL are installed:

```bash
# Ubuntu/Debian
apt update
apt install apache2 mysql-server php8.1 php8.1-mysql php8.1-curl php8.1-mbstring php8.1-xml php8.1-zip
```

### Step 3: Create Database

```bash
mysql -u root -p < database/00_create_database.sql
```

This creates the `angani_data` database with utf8mb4 charset.

### Step 4: Import Base Schema

```bash
mysql -u root -p angani_data < database/01_schema.sql
```

This creates ALL tables (V1 schema): countries, airlines, airports, aircraft_types, aircraft_registrations, users, subscription_tiers, and all extended tables.

### Step 5: Apply V2 Migrations (in order)

```bash
mysql -u root -p angani_data < database/02_v2_migration.sql
mysql -u root -p angani_data < database/03_v2_airports.sql
mysql -u root -p angani_data < database/04_v2_airlines.sql
mysql -u root -p angani_data < database/05_v2_airport_frequencies.sql
mysql -u root -p angani_data < database/06_v2_navaids.sql
mysql -u root -p angani_data < database/07_v2_aircraft_types.sql
mysql -u root -p angani_data < database/08_fix_duplicates.sql
mysql -u root -p angani_data < database/09_data_audit.sql
mysql -u root -p angani_data < database/10_airline_logos.sql
mysql -u root -p angani_data < database/11_country_enhancements.sql
```

**Migration order is critical** — each file depends on the previous one. The V2 migrations:
- Rename old tables to `legacy_*` (e.g., `countries` → `legacy_countries`)
- Create new V2 tables with updated schemas (e.g., `countries` with `iso_alpha_2` as PK)
- Add pipeline, audit, and provenance tables
- Add computed statistics tables

### Step 6: Import Seed Data

```bash
# Option A: PHP script (recommended)
php database/import_all_seeds.php

# Option B: MySQL CLI
mysql -u root -p angani_data < database/02_seed_data.sql
```

Option A is recommended because it reads `config.php` and handles errors gracefully.

### Step 7: Run V2 Data Migration

```bash
php scripts/migrate_all_v2_tables.php
```

This migrates data from the `legacy_*` tables to the new V2 tables.

### Step 8: Configure Database Credentials

Create `includes/config.php` with your database details:

```php
<?php
return [
    'host' => '127.0.0.1',
    'port' => '3306',
    'database' => 'angani_data',
    'username' => 'your_db_user',
    'password' => 'your_db_password',
    'charset' => 'utf8mb4',
];
```

Alternatively, set environment variables (the config reads these first):
```
ANGANI_DB_HOST
ANGANI_DB_NAME
ANGANI_DB_USER
ANGANI_DB_PASS
ANGANI_DB_PORT
```

### Step 9: Configure Web Server

#### Apache Configuration

Create a virtual host file `/etc/apache2/sites-available/angani-data.conf`:

```apache
<VirtualHost *:80>
    ServerName data.angani.co.uk
    DocumentRoot /var/www/angani-data

    <Directory /var/www/angani-data>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/angani-data-error.log
    CustomLog ${APACHE_LOG_DIR}/angani-data-access.log combined
</VirtualHost>
```

Enable the site and mod_rewrite:

```bash
a2ensite angani-data
a2enmod rewrite
systemctl restart apache2
```

#### Nginx Configuration

```nginx
server {
    listen 80;
    server_name data.angani.co.uk;
    root /var/www/angani-data;

    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

### Step 10: Set File Permissions

```bash
chown -R www-data:www-data /var/www/angani-data
chmod -R 755 /var/www/angani-data
chmod 644 /var/www/angani-data/includes/config.php  # Sensitive file
```

### Step 11: Verify Installation

1. Visit `http://your-server/` in a browser
2. You should see the Angani Data home page with stats and module grid
3. Log in with the demo admin account: `admin@angani.co.uk` / `Angani@2026`

---

## 3. Database Configuration (includes/db.php)

The database layer is in `includes/db.php`:

```php
function db(): PDO {
    static $pdo = null;  // Singleton connection
    // Reads from includes/config.php (or config.example.php as fallback)
    // Connects via PDO with:
    //   - ERRMODE_EXCEPTION (errors throw exceptions)
    //   - FETCH_ASSOC (rows returned as associative arrays)
    //   - Emulate prepares OFF (real prepared statements)
}
```

Helper functions:
- `rows($sql, $params)` — Multiple rows
- `row($sql, $params)` — Single row
- `scalar($sql, $params)` — Single value
- `exec_sql($sql, $params)` — INSERT/UPDATE/DELETE
- `table_exists($table)` — Check table existence

---

## 4. File Permissions & Security

| Path | Permissions | Notes |
|------|------------|-------|
| `/var/www/angani-data/` | 755 | Directory |
| `*.php` | 644 | PHP files |
| `includes/config.php` | 600 or 640 | Contains database password |
| `css/`, `js/`, `assets/` | 755 | Public assets |
| `database/` | 755 | SQL files (not web-accessible) |
| `scripts/` | 755 | CLI scripts (not web-accessible) |
| `admin/` | 755 | Admin panel (protected by login) |
| `backups/` | 755 | Backup storage (not web-accessible) |

**Security notes:**
- `includes/config.php` MUST NOT be web-accessible (Apache blocks `.php` in includes/ if configured correctly, but better to place it outside web root)
- All database queries use prepared statements — no SQL injection risk
- All HTML output is escaped with `e()` function — prevents XSS
- CSRF tokens protect all form submissions
- Passwords are hashed with `password_hash()` / `password_verify()`

---

## 5. User Accounts & Roles

The system is pre-seeded with:
- `admin@angani.co.uk` / `Angani@2026` — Admin account

**Account types:**
- **user**: Normal user, access controlled by their subscription tier
- **admin**: Full system access

**Creating an admin account:**
1. Register normally at `?page=register`
2. Promote to admin via MySQL: `UPDATE users SET role='admin' WHERE email='user@example.com';`
3. Or use Admin → Users in the web interface

---

## 6. Backup & Restore

### Creating Backups

**Via web (Admin → Backup):** Click "Create backup" to generate a ZIP file containing:
1. Full MySQL dump
2. All project files (PHP, CSS, JS, assets)

**Via CLI:** `php scripts/backup_engine.php`

Backups are stored in `backups/` directory.

### Restoring from Backup

Use the guided installer:

1. Place the backup ZIP file in the project root
2. Visit `install.php` in a browser
3. Step 1: Detects available backup files
4. Step 2: Extracts and restores files
5. Step 3: Enter MySQL credentials to restore database

Or restore manually:
```bash
unzip backups/angani_backup_001.zip -d /var/www/angani-data/
mysql -u root -p angani_data < database_dump.sql
```

---

## 7. Mirror Server Setup

A mirror server at `134.209.114.217` (DigitalOcean) can be configured for redundancy.

### Setup on Primary Server

1. Set up SSH key-based access to the mirror
2. Configure mirror in Admin → Mirror
3. The mirror sync performs:
   - `rsync` of all project files
   - MySQL dump on primary → scp → MySQL import on mirror
   - Logs results

### Sync Frequency

- Manual: Click "Sync now" in Admin → Mirror
- Automated: Set up cron on the primary server (every 5 minutes recommended):
  ```
  */5 * * * * /usr/bin/php /var/www/angani-data/scripts/mirror_sync.php
  ```

### Failover

If the primary server fails:
1. Update DNS to point to the mirror server IP
2. The mirror server has identical code and data (up to last sync)
3. Any data changes made after the last sync will be lost

---

## 8. Caching & Performance

### Browser Cache

CSS and JS files are cached aggressively by browsers. When deploying changes:
- Add a query parameter to the CSS URL in `index.php`: `<link href="css/styles.css?v=X">`
- Increment `X` with each deployment to force browsers to reload

### Database Performance

- All tables use appropriate indexes (PKs, FKs, UNIQUE constraints)
- Fulltext indexes exist on key search columns in V1 tables
- V2 migration files add UNIQUE keys to prevent duplicates
- No query cache is configured (MySQL 8.x removed query cache)
- For slow queries, use `EXPLAIN SELECT ...` to check index usage

### PHP Performance

- `db()` uses a singleton PDO connection (reused within a request)
- `current_user()` caches the user record per request
- `table_columns()` caches column names per request
- No OpCache configuration needed for PHP 8.x (enabled by default)
- Consider using PHP-FPM for better concurrent request handling

---

## 9. Running Reports

After installation, run these to populate computed data:

```bash
# Generate country air transport statistics
php scripts/reports/generate_country_stats.php

# Fetch economic and traffic time series from World Bank
php scripts/populate_country_time_series.php
```

These can also be run from Admin → Reports → "Generate Country Stats" / "Populate Country Time Series".

---

## 10. Troubleshooting Deployment

| Problem | Cause | Solution |
|---------|-------|----------|
| Blank page on load | PHP error or missing file | Check Apache error log: `tail -f /var/log/apache2/angani-data-error.log` |
| "Database connection failed" | Wrong credentials in config.php | Check `includes/config.php` values match your MySQL setup |
| "Table not found" error | Schema not imported | Run all SQL files in order (steps 4-6 of installation) |
| 403 Forbidden on admin | File permissions | `chmod 755 admin/` and all subdirectories |
| CSS not loading | Wrong path or cache | Check `<link>` href in page source; hard refresh browser |
| Login doesn't work | Session issues | Check PHP sessions are working: `session_save_path()` must be writable |
| "No such file or directory" for config.php | Config not created | Copy `config.example.php` to `config.php` and fill in credentials |
| 500 Internal Server Error | PHP syntax error or missing extension | Run `php -l index.php` to check syntax; ensure PDO MySQL extension is installed |
| Slow page loads | Missing indexes or large datasets | Run `EXPLAIN` on slow queries; add indexes to frequently-queried columns |
| Search returns no results | Fulltext indexes not working | Rebuild fulltext indexes: `REPAIR TABLE tablename QUICK;` |

---

## 11. Maintenance Tasks

| Frequency | Task | How |
|-----------|------|-----|
| Daily | Check error logs | `tail -f /var/log/apache2/angani-data-error.log` |
| Daily | Mirror sync (if enabled) | Cron job runs automatically |
| Weekly | Run country reports | Admin → Reports or CLI scripts |
| Monthly | Database backup | Admin → Backup or CLI |
| Monthly | Review data reports | Admin → Data Reports |
| As needed | Import new data | Admin → Imports |
| As needed | Deploy updates | `git pull` from the repo |

---

## 12. Updating the Application

```bash
cd /var/www/angani-data
git pull origin main
# If new database migration files exist:
mysql -u root -p angani_data < database/NEW_MIGRATION_FILE.sql
# Clear any cached files:
php -r "opcache_reset();"  # If using OpCache
# Verify:
php -l index.php
php -l includes/functions.php
```

**After every update:**
1. Hard refresh your browser (Ctrl+F5)
2. Test critical pages (home, a module listing, a detail page)
3. Check that the cache-busting query parameter on CSS was incremented if CSS changed
