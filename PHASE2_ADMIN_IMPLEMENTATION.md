# Phase 2 Admin Implementation

This phase turns the Angani Data backend into a proper data-management console rather than a public-page clone.

## Completed in Phase 2

- Dedicated Admin Command Center with operational KPIs.
- Separate admin sidebar/navigation for backend actions.
- CRUD console for every configured module.
- Admin-only record actions: Add, Edit, Preview, Delete.
- Filtered CSV export from record lists.
- Full database ZIP export as CSV files with a manifest.
- CSV import with Append or Clear-and-Import modes.
- Import batch logging.
- Failed-row staging queue for review.
- Data Quality dashboard: staging rows, import batches, export logs, empty modules.
- User management: create users, edit tier, role and account status.
- Plans management: edit Free / Pro / Enterprise plan text, pricing and limits.
- Tier benefits management.
- Preset question management for the user dashboard.
- Homepage rotating insight-card management with query presets.
- Admin readiness checklist retained inside the console.

## Important notes

- Public users still see clean aviation database pages.
- Internal fields such as IDs, raw import data, source internals and import batch metadata remain hidden from public detail views.
- Admin views expose operational details and actions.
- Whole-database ZIP export requires PHP `ZipArchive` to be enabled. Module CSV exports work separately.
- Browser exports are capped at 5,000 rows per configured module for safety. Use CLI/database tools for very large archival exports.

## Main admin URL

```text
/index.php?page=admin
```

## Demo admin login

```text
admin@angani.co.uk
Angani@2026
```
