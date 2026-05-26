#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./database/import_all_seeds.sh angani_data angani_data_user
#   ./database/import_all_seeds.sh angani_data root
# You will be prompted for the MySQL password.

DB_NAME="${1:-angani_data}"
DB_USER="${2:-root}"
DB_HOST="${3:-127.0.0.1}"

APP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEEDS_DIR="$APP_ROOT/database/seeds"

echo "Importing Angani Data seeds into database: $DB_NAME"
for file in "$SEEDS_DIR"/*.sql; do
  echo "→ $(basename "$file")"
  mysql --host="$DB_HOST" --user="$DB_USER" --password "$DB_NAME" < "$file"
done
echo "Done."
