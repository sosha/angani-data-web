# Task: Complete AnganiData Project Functionality

## 🔴 Critical Fixes

- [x] Fix `DATA_ROOT` path configuration
    - [x] Make `DATA_ROOT` configurable (e.g. via a `config.php` or `.env` file) so the app works regardless of deployment location
    - [x] Update `api_datasets.php`, `api_airports.php`, and `api_search.php` to use the shared config
    - [x] Document the setup path requirement in `README.md`

## 🟠 Bugs & Broken Features

- [x] Fix `import.php` — legacy SQLite importer conflicts with CSV-native architecture
    - [x] Either remove `import.php` entirely or rewrite it to write directly to CSV files
    - [x] Remove or isolate `db.php` dependency from pages that don't need it (`tracking.php`)
- [x] Hide `_errors/` folder from the dataset browser tree
    - [x] Filter out folders starting with `_` in `scanDir_recursive()` in `api_datasets.php`
- [x] Fix `logger.php` function signature mismatch
    - [x] `import.php` calls `logAction($pdo, ...)` but `logger.php` signature is `logAction(string $action, ...)`

## 🟡 Missing Features

- [ ] Airport sub-datasets not accessible from Route Visualizer
    - [ ] `api_airports.php` only reads `airports.csv` — extend to expose `runways.csv`, `terminals.csv`, `frequencies.csv`, `services.csv` per airport
- [ ] No dedicated UI for new dataset categories
    - [ ] Global Aircraft datasets (specs, encyclopedia, lessors, production)
    - [ ] Global Reference datasets (IATA codes, phonetics, geography, messaging)
    - [ ] Global Currencies dataset
    - [ ] Global Commercial/Pricing datasets (fares, fare rules, yield analysis)
    - [ ] Per-country Commercial datasets (financial performance, fare inventory)
    - [ ] Per-country Infrastructure datasets (ground handling, ground transport)
    - [ ] Per-country Regulatory datasets (authority, certification, safety oversight)
- [ ] Airlines sub-datasets not surfaced in any dedicated view
    - [ ] `fleet_list.csv`, `fleet_summary.csv`, `brand_assets.csv`, `key_personnel.csv`, `hubs.csv` etc. only accessible via generic editor

## 🔵 Future Integrations

- [ ] Expand static datasets (Navaids, Frequencies)
- [ ] Global Synchronization of Meta Ads Dataset for Airports
- [ ] Global Synchronization of Meta Ads Dataset for Regulatory

## 🔵 Project Split & Deployment

- [ ] Split Project into Web and Data
    - [ ] Update paths in `import.php` and `db.php`
    - [ ] Update `.gitignore` and `README.md` for both repos
- [ ] Initialize and Push `angani-data-web` to GitHub
- [ ] Cleanup and Push `angani-data` (datasets only) to GitHub
