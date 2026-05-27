# Angani Data — 100% Readiness Task List

The implementation now includes the core tasks required for launch readiness:

## Completed in this package

- Separate Admin Console layout.
- Generic CRUD for every configured database module.
- CSV import for Admin.
- CSV export for Admin and Pro/Enterprise users.
- User account registration/login/logout.
- Admin user management.
- Three access tiers only: Free, Pro, Enterprise.
- Homepage rotating insight cards.
- Active airlines green glow pill.
- Public drill-down pages for records.
- Airline cards with logo/flag slot and clear View Airline button.
- Airport cards with clickable drill-down page.
- Aircraft Types database and aircraft type intelligence submodules.
- Lessors database.
- IATA/IOSA reference and airline status tables.
- GDS database.
- Infrastructure/AIM database: navaids, frequencies, NOTAM sources, NOTAM archive.
- Commercial database: fares, inventory, fare rules, taxes/fees, yield analysis, country fare policy.
- Reference database: country codes, booking classes, service types, meal codes, terminal codes, reject reasons, phonetic alphabet and licensing categories.
- Internal fields hidden from public/detail pages and relabelled as user-friendly fields.
- Data quality layer: import batches, staging records, export logs, source records and change logs.

## Remaining real-world launch tasks

These require operational decisions or external data validation, not more app scaffolding:

- Change production admin password.
- Configure HTTPS and secure headers.
- Add payment provider integration for Pro subscriptions.
- Add email verification/password reset if required.
- Verify licensing/terms for every scraped source.
- Decide export limits for Pro accounts.
- Add API endpoints if Enterprise customers require them.
- Add manual review workflow for conflicting country datasets.
- Add source citations for every high-value regulatory/commercial field.
