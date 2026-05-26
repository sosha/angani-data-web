# Deployment Guide — Angani Data PHP/MySQL

This package is ready for deployment as a normal PHP/MySQL application.

## 1. Upload the project

Upload the full folder to your server, for example:

```text
/var/www/angani-data
```

or on cPanel:

```text
public_html/angani-data
```

## 2. Configure database credentials

Edit:

```text
includes/config.php
```

Example:

```php
<?php
return [
    'host' => '127.0.0.1',
    'port' => '3306',
    'database' => 'angani_data',
    'username' => 'angani_data_user',
    'password' => 'CHANGE_THIS_PASSWORD',
    'charset' => 'utf8mb4',
];
```

## 3. Create database and schema

```bash
mysql -u root -p < database/00_create_database.sql
mysql -u root -p angani_data < database/01_schema.sql
```

## 4. Import split seed files

Use either importer.

PHP importer:

```bash
php database/import_all_seeds.php
```

Shell importer:

```bash
./database/import_all_seeds.sh angani_data angani_data_user 127.0.0.1
```

For phpMyAdmin/cPanel, import the files in `database/seeds/` in filename order. Every seed file is below 1MB.

## 5. Nginx subdirectory deployment

To serve it under `/angani-data/` without disturbing an existing app, add this inside your existing Nginx `server {}` block. Replace the PHP-FPM socket if needed.

```nginx
location = /angani-data {
    return 301 /angani-data/;
}

location /angani-data/ {
    root /var/www;
    index index.php index.html;
    try_files $uri $uri/ /angani-data/index.php?$query_string;
}

location ~ ^/angani-data/(.+\.php)$ {
    root /var/www;
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php8.2-fpm.sock;
}
```

Then run:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

## 6. Apache/cPanel

The package includes `.htaccess` for standard Apache/cPanel hosting. Upload to a subfolder and visit the folder URL.
