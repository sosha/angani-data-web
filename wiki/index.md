# Angani Data — Aviation Intelligence Atlas

Welcome to the complete documentation for the **Angani Data** aviation intelligence web application. This project is a comprehensive aviation data platform covering airlines, airports, aircraft types, regulatory records, navaids, NOTAMs, commercial fares, and reference data across 120+ database tables.

## Tech Stack

| Component | Technology |
|-----------|------------|
| Language | PHP 8.x (no framework, no Composer) |
| Database | MySQL 8.x with PDO |
| Frontend | Vanilla CSS (112 lines), Vanilla JS (minified ~1.8KB) |
| Charts | Chart.js |
| Visualization | Chart.js for time-series and bar charts |
| Email | Pluggable: SendPulse, Postmark, Brevo, Mailgun, SES, Zapier |

## Current Record Counts (Remote DB)

| Table | Records | Tier |
|-------|---------|------|
| airlines | 9,202 | Free |
| airports | 84,146 | Free |
| aircraft_registrations | 35,522 | Pro |
| aircraft_types | 345 | Free |
| aircraft_models | 742 | Free |
| aircraft_manufacturers | 522 | Free |
| countries | 253 | Free |
| airline_digital_properties | 6,796 | Pro |
| airline_fleet_summary | 1,090 | Pro |
| airline_hubs | 222 | Pro |
| airport_frequencies | 30,250 | Free |
| navaids | 10,953 | Free |
| navaid_technical/operational/connectivity/references | 11,010 each | Pro |
| regulatory_authorities | 233 | Free |
| regulatory_operational_certification | 565 | Pro |
| regulatory_economic_licensing | 163 | Pro |
| lessors | 35 | Pro |
| frequent_flyer_programs | 394 | Free |
| airport_digital_properties | 21,309 | Pro |
| aircraft_type_* (all 8 sub-tables) | 499-783 each | Pro |
| aircraft_model_capacity/history/production | 18-200 each | Pro |
| aircraft_model_specs | 400 | Pro |
| ref tables (timezones, codes, etc.) | 12-88 each | Free |
| gds_systems | 15 | Free |
| iata_membership_requirements | 13 | Free |
| iosa_registration_steps | 8 | Free |
| notam_sources | 8 | Free |
| notams | 12 | Pro |
| airline_destinations | 290 | — |
| regulatory_records | 160 | Pro |

## Documentation Sections

| Section | Content |
|---------|---------|
| [Modules Overview](modules-overview.md) | Every module group, what each module contains, data description, tier level |
| [Database Schema](database-schema.md) | Complete table-by-table documentation with all fields, types, and usage |
| [Data Sources](data-sources.md) | Where each dataset originates: scrapers, CSV imports, CAA records, third-party APIs |
| [Import Pipeline](import-pipeline.md) | How the Phase 4 import engine works: DatasetMap, CSV-to-table mapping, import scripts |
| [Architecture](architecture.md) | Code structure, routing, module system, access control, admin rendering |
| [Seed Status](seed-status.md) | What seed files exist, what has been run, what data is still pending |
| [User Guide](user-guide.md) | Application usage: navigation, search, filters, detail pages, account management |
| [Admin Guide](admin-guide.md) | Admin console: users, tiers, data import/export, QA, pipeline, reports, email, backup |

## Quick Links

- **Live site**: `https://data.angani.co.uk`
- **Git repository**: `https://github.com/sosha/angani-data-web`
- **Demo admin**: `admin@angani.co.uk` / `Angani@2026`
- **Access tiers**: Free (public), Pro (paid), Ultimate (enterprise)
