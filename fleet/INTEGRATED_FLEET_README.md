# Integrated Fleet Database

This directory contains integrated aircraft fleet data combining multiple sources.

## Files

| File | Description |
|------|-------------|
| `integrated_fleet.csv` | Main integrated fleet database (54,858 entries) |
| `registration_country_lookup.json` | Lookup table for registration → country |
| `registration_prefixes.json` | Mapping of registration prefixes to countries |
| `wikimedia_aircraft/` | Wikimedia Commons aircraft data (16,020 registrations) |
| `ultimate_fleet_list*.csv` | Original fleet data files |

## Data Sources

1. **Original Fleet Data** (`fleet.csv`) - Aircraft with ICAO codes, types, and registration info
2. **Wikimedia Commons** - Aircraft registrations scraped from Category:Aircraft_by_country

## Integrated Fleet Schema

| Field | Description |
|-------|-------------|
| ICAO Code | ICAO airline/aircraft operator code |
| Aircraft Type | Full aircraft type description |
| Registration | Aircraft registration/tail number |
| ADSHEX | ADS-B hex address (if available) |
| Type Code | IATA aircraft type code |
| Construction Number | Manufacturer serial number |
| Age | Aircraft age in years |
| RegistrationCountry | Country of registration (new field) |
| Source | Data source (original or "Wikimedia Commons") |

## Statistics

- **Total Entries**: 54,858
- **With Country Info**: 23,630 (from original data + Wikimedia match)
- **Country Inferred**: 18,180 (from registration prefix mapping)
- **New from Wikimedia**: 13,048 (registrations not in original data)

## Registration Prefix Mapping

The `registration_prefixes.json` file contains a mapping of registration prefixes (first 2-3 characters) to countries. This allows country inference for aircraft registrations that don't have explicit country data.

Example prefixes:
- `N-` → United States
- `G-` → United Kingdom
- `F-` → France
- `D-` → Germany
- `JA-` → Japan
- `B-` → China
- `VH-` → Australia