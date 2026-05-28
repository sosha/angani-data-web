# Scripts

- `import_uploaded_datasets.php` — loads the split SQL seed files that include the uploaded global and country datasets.
- `import_csv_to_mysql.php` — legacy utility retained from the earlier build.

For normal deployment, use:

```bash
php database/import_all_seeds.php
```
