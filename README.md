# AnganiData Web — CSV-Native Aviation Data Portal

A PHP-based web portal for managing the **AnganiData** global aviation dataset repository. This portal provides full CRUD (Create, Read, Update, Delete) capabilities across all CSV datasets — no SQL database required.

## 🏗️ Architecture

**Database = CSV Files.** This portal reads and writes directly to the CSV files in the sibling `angani-data/datasets/` directory. There is no MySQL, PostgreSQL, or SQLite layer. All operations use PHP's native `fgetcsv()`/`fputcsv()` functions with file locking for safe concurrent access.

## 📂 File Structure

```
angani-data-web/
├── index.php              # Dashboard — live stats, README viewer, quick actions
├── header.php             # Shared navigation component
├── style.css              # Global design system (dark theme, glassmorphism)
│
├── datasets.php           # 📂 Dataset Explorer — tree browser with folder/file navigation
├── editor.php             # ✏️ Inline CSV Editor — paginated table with cell editing
├── batch_import.php       # 📥 Batch Import — paste or upload rows into any CSV
├── manage.php             # ⚙️ File Management — create, upload, delete CSV files
│
├── api_datasets.php       # 🔌 JSON API — all CSV CRUD operations
├── api_airports.php       # Airport lookup API
├── api_meta_ads.php       # Meta Ads API
│
├── routes.php             # ✈️ Route Explorer
├── meta_ads.php           # 🌐 Digital Properties tracker
├── viewer.php             # Directory viewer
├── tracking.php           # Flight tracking
│
├── logs/                  # 📋 Audit trail (CSV-native)
│   └── audit.csv          # Timestamped log of all file operations
├── backups/               # 🗂️ Centralized file backups
└── README.md              # This file
```

## 🔌 API Reference (`api_datasets.php`)

All endpoints return JSON. The API operates directly on CSV files within `../angani-data/datasets/`.

| Action | Method | Description |
|:---|:---|:---|
| `?action=tree` | GET | Returns the full directory tree as nested JSON |
| `?action=read&file=PATH&page=N&per_page=N&search=TERM` | GET | Read CSV with pagination and search |
| `?action=update` | POST | Update specific rows by line index |
| `?action=add` | POST | Append new rows to a CSV |
| `?action=delete` | POST | Delete rows by line index |
| `?action=export&file=PATH` | GET | Download a CSV file |
| `?action=upload` | POST | Upload a CSV file to a target directory |
| `?action=create` | POST | Create a new empty CSV with custom headers |
| `?action=delete_file` | POST | Delete an entire CSV file (backup created first) |
| `?action=audit&limit=N` | GET | Read the audit log |
| `?action=folders` | GET | Flat list of all folder paths |

## 🛠️ Setup

1. Place this directory alongside `angani-data/` on your web server:
   ```
   /var/www/html/
   ├── angani-data/         # The dataset repository
   └── angani-data-web/     # This web portal
   ```

2. Ensure the web server (Apache/Nginx) has read/write access to `../angani-data/datasets/`.

3. No database configuration needed. No `.env` files. No migrations.

4. Navigate to `http://localhost/angani-data-web/` to start.

## 🆕 What's New

- **CSV-Native Architecture**: Removed all MySQL/SQLite dependencies. The CSV file IS the database.
- **Batch Import**: Paste rows from spreadsheets directly into any dataset.
- **File Management**: Create, upload, and delete CSV files through the web UI.
- **Audit Trail**: Every file operation is logged to `logs/audit.csv`.
- **Centralized Backups**: All backups are timestamped and stored in `backups/`.

## License

This project is licensed under the MIT License.

© 2026 AnganiOS Project.
