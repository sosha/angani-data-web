<?php
require_once __DIR__ . '/../../includes/db.php';

class Publisher {
    private static array $tableMap = [
        'countries' => 'countries',
        'caas' => 'caas',
        'country_facts' => 'country_facts',
        'country_dynamic_facts' => 'country_dynamic_facts',
        'country_transport_stats' => 'country_transport_stats',
        'airports' => 'airports',
        'airlines' => 'airlines',
        'airport_frequencies' => 'airport_frequencies',
        'navaids' => 'navaids',
        'aircraft_types' => 'aircraft_types',
    ];

    private static array $pkMap = [
        'countries' => 'iso_alpha_2',
        'caas' => 'id',
        'country_facts' => ['country_code', 'fact_key'],
        'country_dynamic_facts' => ['country_code', 'metric_key', 'year'],
        'country_transport_stats' => ['country_code', 'statistic_year', 'quarter', 'mode', 'metric'],
        'airports' => 'ident',
        'airlines' => 'icao_code',
        'airport_frequencies' => 'id',
        'navaids' => 'id',
        'aircraft_types' => 'icao_code',
    ];

    public static function publish(int $runId, int $adminUserId): array {
        $staging = rows(
            'SELECT * FROM staging_records WHERE pipeline_run_id=? AND status="approved"',
            [$runId]
        );

        $inserted = 0; $updated = 0; $deleted = 0;

        foreach ($staging as $row) {
            $module = $row['module_key'];
            $table = self::$tableMap[$module] ?? null;
            if (!$table) continue;

            $data = json_decode($row['row_data'], true);
            if (!$data) continue;

            try {
                if ($row['action'] === 'insert') {
                    self::insertRecord($table, $data);
                    $inserted++;
                } elseif ($row['action'] === 'update') {
                    self::updateRecord($table, $data, $module);
                    $updated++;
                } elseif ($row['action'] === 'delete') {
                    self::deleteRecord($table, $data, $module, $runId, $adminUserId);
                    $deleted++;
                }
                exec_sql(
                    'UPDATE staging_records SET status="approved", reviewed_by=?, reviewed_at=NOW() WHERE id=?',
                    [$adminUserId, $row['id']]
                );
            } catch (Throwable $e) {
                exec_sql('UPDATE staging_records SET status="rejected" WHERE id=?', [$row['id']]);
            }
        }

        exec_sql(
            'UPDATE pipeline_runs SET records_approved=?, status="approved", approved_by=?, approved_at=NOW() WHERE id=?',
            [$inserted + $updated + $deleted, $adminUserId, $runId]
        );

        self::logAction($adminUserId, 'publish', 'pipeline_run', $runId, [
            'inserted' => $inserted, 'updated' => $updated, 'deleted' => $deleted
        ]);

        return ['inserted' => $inserted, 'updated' => $updated, 'deleted' => $deleted];
    }

    private static function insertRecord(string $table, array $data): void {
        $cols = array_keys($data);
        $placeholders = implode(',', array_fill(0, count($cols), '?'));
        $escaped = array_map(fn($c) => "`$c`", $cols);
        exec_sql(
            "INSERT INTO `$table` (" . implode(',', $escaped) . ") VALUES ($placeholders)",
            array_values($data)
        );
    }

    private static function updateRecord(string $table, array $data, string $module): void {
        $pkCol = self::$pkMap[$module] ?? null;
        if (!$pkCol) return;

        if (is_array($pkCol)) {
            $whereParts = [];
            $params = [];
            foreach ($data as $col => $val) {
                if (in_array($col, $pkCol)) continue;
                $whereParts[] = "`$col`=?";
                $params[] = $val;
            }
            foreach ($pkCol as $pc) {
                $whereParts[] = "`$pc`=?";
                $params[] = $data[$pc] ?? '';
            }
            if (count($whereParts) <= count($pkCol)) return;
            $setClause = implode(',', array_slice($whereParts, 0, count($whereParts) - count($pkCol)));
            $whereClause = implode(' AND ', array_slice($whereParts, -count($pkCol)));
            exec_sql("UPDATE `$table` SET $setClause WHERE $whereClause", $params);
        } else {
            $pkValue = $data[$pkCol] ?? '';
            if (!$pkValue) return;
            $sets = []; $params = [];
            foreach ($data as $col => $val) {
                if ($col === $pkCol) continue;
                $sets[] = "`$col`=?";
                $params[] = $val;
            }
            $params[] = $pkValue;
            exec_sql("UPDATE `$table` SET " . implode(',', $sets) . " WHERE `$pkCol`=?", $params);
        }
    }

    private static function deleteRecord(string $table, array $data, string $module, int $runId, int $adminUserId): void {
        $pkCol = self::$pkMap[$module] ?? 'iso_alpha_2';
        $pkValue = is_array($pkCol) ? ($data[$pkCol[0]] ?? '') : ($data[$pkCol] ?? '');
        if (!$pkValue) return;

        $existing = row("SELECT * FROM `$table` WHERE `$pkCol`=?", [$pkValue]);
        if ($existing) {
            exec_sql(
                'INSERT INTO archived_records (source_table, record_id, record_data, pipeline_run_id, deleted_by) VALUES (?,?,?,?,?)',
                [$table, $pkValue, json_encode($existing), $runId, $adminUserId]
            );
            exec_sql("DELETE FROM `$table` WHERE `$pkCol`=?", [$pkValue]);
        }
    }

    private static function logAction(int $userId, string $action, string $targetType, int $targetId, array $details): void {
        try {
            exec_sql(
                'INSERT INTO admin_action_log (admin_user_id, action_type, target_type, target_id, details_json) VALUES (?,?,?,?,?)',
                [$userId, $action, $targetType, $targetId, json_encode($details)]
            );
        } catch (Throwable $e) {}
    }
}
