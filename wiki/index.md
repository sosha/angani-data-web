# Angani Data — Project Wiki

Welcome to the complete documentation for the **Angani Data** aviation intelligence web application.

## About This System

Angani Data is a web-based platform that provides aviation data across multiple domains: airlines, airports, aircraft types, regulatory records, navaids, NOTAMs, commercial fares, and more. The system has three access tiers (Free, Pro, Ultimate) and is built with PHP (no framework), MySQL, vanilla CSS, and minimal JavaScript.

## Documentation Sections

| Section | Who It's For | What It Covers |
|---------|-------------|----------------|
| [User Guide](user-guide.md) | **Everyone** — how to use the website | Every page, navigation, search, filters, reading detail pages, understanding tabs, account registration, pricing tiers |
| [Database Reference](database-reference.md) | **Developers & analysts** | Every table in the database, what columns it has, what data it stores, how tables relate to each other, where each table is used in the application |
| [Developer Guide](developer-guide.md) | **Developers** modifying the code | Complete code architecture, every PHP function, module system, how pages are routed, how to add a new module, how to change existing behavior, testing approach, coding conventions |
| [Admin Guide](admin-guide.md) | **Administrators** managing the system | Admin console features: managing users, tiers, data import/export, preset questions, insight cards, pipeline management, data audit, reports, email configuration, backups, mirror server |
| [Deployment Guide](deployment-guide.md) | **Sysadmins** deploying the application | Server requirements, installation steps (full setup from scratch), database migration order, configuration, Apache/Nginx setup, security, backup strategy, mirror server setup |

## Quick Links

- **Live site**: `https://data.angani.co.uk`
- **Git repository**: `https://github.com/sosha/angani-data-web`
- **Tech stack**: PHP 8.x, MySQL 8.x, Apache/Nginx, vanilla CSS, vanilla JS (no frameworks)
- **Admin credentials** (demo): `admin@angani.co.uk` / `Angani@2026`
