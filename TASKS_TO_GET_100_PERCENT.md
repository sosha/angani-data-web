# Angani Data — Tasks to Get the App to 100%

This file converts the product direction into an implementation checklist. The updated project already includes the schema, seed data, login/register flow, tiers, preset questions, admin-managed homepage insights, route/equipment tables, source tracking and change-control tables.

## 1. Core product setup

- [x] Keep existing airline, airport, aircraft, aircraft type, regulatory and raw dataset tables working.
- [x] Add a normalised aviation data layer for organisations, people, AOCs, lessors, route markets, route services, schedules, aircraft ownership/history, source records and change logs.
- [x] Add public homepage data titbits to encourage signups.
- [x] Add preset questions after login.
- [x] Add access tiers and feature gating.
- [x] Add seed data for tiers, demo users, questions, insights and route examples.
- [ ] Replace all starter/sample demo records with verified source-backed records.
- [ ] Create a data dictionary page for every table and field.

## 2. User accounts and access tiers

- [x] Register, login, logout and account pages.
- [x] Password hashing with PHP `password_hash()`.
- [x] Admin user seed: `admin@angani.co.uk` / `Angani@2026`.
- [x] Demo analyst/pro users with the same demo password.
- [x] Tiers: Free, Explorer, Analyst, Pro, Team, Enterprise.
- [x] Feature gates for route intelligence, regulatory intelligence, aircraft history, source history, API access and exports.
- [ ] Add email verification.
- [ ] Add password reset.
- [ ] Add payment processor integration for tier upgrades.
- [ ] Add invoices, receipts and billing history.
- [ ] Add team invitations and organisation accounts.
- [ ] Add usage limits enforcement for search/export/API.

## 3. Preset questions users should be able to answer

Seeded presets already include:

1. Which airlines compete on the same route?
2. Which are the oldest aircraft in the database?
3. Which airports sit at the highest elevation?
4. Which active airlines have the smallest fleet size?
5. Which countries have the most aircraft records?
6. Where is the regulatory dataset deepest?
7. Which airlines use an airport as a hub, base or focus city?
8. What is the known operator history of aircraft in the database?
9. What changed recently and what needs review?

Add next:

- [ ] Which aircraft are leased and by which lessor?
- [ ] Which airlines operate a specific aircraft type in Africa?
- [ ] Which aircraft have changed operators in the last 24 months?
- [ ] Which airports have the most airline services?
- [ ] Which routes have only one operator and may be underserved?
- [ ] Which countries have the most AOC holders?
- [ ] Which regulators have stale contact or AOC data?
- [ ] Which airlines have unknown ownership or missing key staff?
- [ ] Which airports have no runway/infrastructure data yet?
- [ ] Which sources have conflicting values for the same field?

## 4. Admin section

- [x] Task board.
- [x] Tier overview.
- [x] User tier update form.
- [x] Homepage insight card create/update form.
- [x] Bulk operations file retained.
- [ ] Full CRUD for airlines, airports, aircraft, routes, regulators and lessors.
- [ ] Review queue for scraped changes.
- [ ] Conflict resolution screen.
- [ ] Data-quality dashboard.
- [ ] Manual source/evidence attachment UI.
- [ ] Audit trail by admin user.

## 5. Database and data model completion

- [x] Existing raw/source tables retained.
- [x] New tables added for access, questions, insights, organisations, people, AOCs, lessors, routes, schedules, route equipment, traffic statistics, aircraft history, source records and change logs.
- [ ] Add airport runways, terminals, stands, fire category and handling services.
- [ ] Add regulatory documents, bilateral air-service agreements and traffic rights.
- [ ] Add airline IT systems: PSS, DCS, GDS, booking engine, RMS and loyalty.
- [ ] Add MRO providers and aircraft maintenance events.
- [ ] Add accidents/incidents table.
- [ ] Add airport traffic statistics.
- [ ] Add country-pair and city-pair markets.
- [ ] Add airport catchment groups for multi-airport cities.

## 6. Data ingestion

- [x] Existing split SQL seeds remain below 1MB each.
- [x] New seed files added and kept below 1MB.
- [x] CLI importer imports seed files in filename order.
- [ ] Build CSV import validators per table.
- [ ] Add source-specific importers for Wikipedia, airline sites, airport sites and CAA sites.
- [ ] Add scraping run table and logs.
- [ ] Add cron/queue jobs.
- [ ] Add duplicate detection and merge tools.
- [ ] Add confidence scoring and human review status.

## 7. Frontend and product design

- [x] Replaced playful typography with a more technical aviation-grade IBM Plex typographic system.
- [x] Kept Angani-style navy, brass/gold, cream and aviation blue colours.
- [x] Added public insight cards and charts.
- [x] Added dashboard/question cards.
- [x] Added premium route intelligence and pricing pages.
- [ ] Create detailed profile pages for individual aircraft.
- [ ] Create detailed airport profile pages with route map and served airlines.
- [ ] Create route profile pages with competitors, equipment, schedules and traffic charts.
- [ ] Add downloadable charts and reports.
- [ ] Add Mapbox/Leaflet visualisation for airports and routes.

## 8. Commercial readiness

- [x] Pricing tiers defined in the database.
- [x] Benefits/access defined in the database.
- [ ] Add Stripe/Paddle/M-Pesa/payment provider.
- [ ] Add terms of use, privacy policy, dataset licence and acceptable-use policy.
- [ ] Add rate limiting for exports and API.
- [ ] Add company/team subscriptions.
- [ ] Add enterprise enquiry flow.
- [ ] Add sample downloadable PDF/CSV reports as lead magnets.

## 9. Deployment and operations

- [ ] Set secure production database credentials in `includes/config.php`.
- [ ] Disable public access to `/database`, `/scripts` and private admin files via Nginx/Apache rules.
- [ ] Add daily database backups.
- [ ] Add error logging and 500 error pages.
- [ ] Add HTTPS redirect.
- [ ] Add cache headers for assets.
- [ ] Add cron job for scraper/import jobs.
- [ ] Add monitoring for failed imports and stale records.
