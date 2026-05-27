# Deployment — Angani Data PHP/MySQL

## Requirements

- PHP 8.1+
- MySQL 8 or MariaDB 10.6+
- PDO MySQL extension
- Nginx or Apache

## Database setup

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
php database/import_all_seeds.php
```

Every file in `database/seeds/` is below 1MB so the data can also be imported manually through phpMyAdmin/cPanel if needed.

## App config

Copy/edit:

```bash
cp includes/config.example.php includes/config.php
nano includes/config.php
```

Set database host, database name, username and password.

## Demo login

```text
admin@angani.co.uk / Angani@2026
```

Change this immediately in production.

## Nginx hardening

Block private folders:

```nginx
location ^~ /database/ { deny all; }
location ^~ /scripts/ { deny all; }
location ~ /includes/ { deny all; }
```

Serve the app root as normal PHP:

```nginx
location / {
    try_files $uri $uri/ /index.php?$query_string;
}
location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php8.3-fpm.sock;
}
```

## Apache hardening

Create `.htaccess` rules or vhost rules to block:

```apache
RedirectMatch 403 ^/database/.*
RedirectMatch 403 ^/scripts/.*
RedirectMatch 403 ^/includes/.*
```

## Production checklist

- [ ] Change demo passwords.
- [ ] Add HTTPS redirect.
- [ ] Block private folders.
- [ ] Add database backups.
- [ ] Add password reset.
- [ ] Add email verification.
- [ ] Add payment integration before selling paid tiers.
- [ ] Add cron jobs for import/scraper workers.
- [ ] Review data-source licences before commercial redistribution.
