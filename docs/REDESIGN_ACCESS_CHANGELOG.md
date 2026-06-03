# Angani Data redesign and access-control update

## Public frontend
- Added a consistent dataset hero and searchable expandable-card interface for Countries, Airlines, Airports, Aircraft, and Aircraft Types.
- Country detail pages now surface the `description` field prominently in the hero and use structured aviation/geography/statistics sections.
- Cards now tease structured data and then show either **Log in to View More**, **Upgrade to View More**, or **View More** depending on the visitor/user tier.
- Pagination now preserves filters, shows ranges, supports numbered pages, and disables previous/next correctly.
- Added inline hints/nudges so users understand that they can search, filter, expand cards, and open deeper records.
- Applied a UI consistency pass for dark/light contrast, tables, cards, tabs, locked fields, and detail pages.

## Access model
- Renamed Enterprise to **Ultimate** while preserving backward compatibility for older `enterprise` tier codes.
- Added `access_rules` table and a lazy schema seeder in PHP.
- New rule scopes: `module`, `detail`, `section`, `field`, `report`, and `feature`.
- Visitors can browse key public modules and expand preview cards but cannot open full detail pages without logging in.
- Free users can open standard detail pages.
- Pro users can access premium sections such as aircraft economics and airline commercial/people sections unless admin changes the rules.
- Ultimate is intended for everything in Pro plus custom services, bulk/API access, private dashboards, and client-specific datasets.

## Admin portal
- Added **Admin → Tier Visibility** to control what each tier can see without editing PHP.
- Cleaned admin navigation labels and added a command-center shortcut for visibility rules.
- Updated user/plan language to Free / Pro / Ultimate.

## Database
- Optional SQL migration/seed: `database/99_access_rules.sql`.
- The app also auto-creates/seeds `access_rules` at runtime when database access is available.
