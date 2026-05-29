<?php
require_once __DIR__ . '/../../includes/db.php';

class DiffEngine {
    private static array $tableMap = [
        'countries' => ['table' => 'countries', 'pk' => 'iso_alpha_2'],
        'caas' => ['table' => 'caas', 'pk' => 'id'],
        'country_facts' => ['table' => 'country_facts', 'pk' => ['country_code', 'fact_key']],
        'country_dynamic_facts' => ['table' => 'country_dynamic_facts', 'pk' => ['country_code', 'metric_key', 'year']],
        'country_transport_stats' => ['table' => 'country_transport_stats', 'pk' => ['country_code', 'statistic_year', 'quarter', 'mode', 'metric']],
        'airports' => ['table' => 'airports', 'pk' => 'ident'],
        'airlines' => ['table' => 'airlines', 'pk' => 'icao_code'],
        'airport_frequencies' => ['table' => 'airport_frequencies', 'pk' => 'id'],
        'navaids' => ['table' => 'navaids', 'pk' => 'id'],
        'aircraft_types' => ['table' => 'aircraft_types', 'pk' => 'icao_code'],
    ];

    public static function diff(string $moduleKey, array $validRecords): array {
        $map = self::$tableMap[$moduleKey] ?? null;
        if (!$map) return array_map(fn($r) => ['action' => 'insert', 'row_data' => $r, 'diff_json' => null], $validRecords);

        $table = $map['table'];
        $liveRows = self::loadLiveRows($table, $map['pk']);

        $results = [];
        foreach ($validRecords as $rec) {
            $hash = hash('sha256', json_encode($rec));
            $key = self::recordKey($rec, $map['pk']);
            $existingHash = $liveRows[$key] ?? null;

            if ($existingHash === null) {
                $results[] = ['action' => 'insert', 'row_data' => $rec, 'row_hash' => $hash, 'diff_json' => null];
            } elseif ($existingHash !== $hash) {
                $results[] = ['action' => 'update', 'row_data' => $rec, 'row_hash' => $hash, 'diff_json' => null];
            }
        }

        return $results;
    }

    private static function loadLiveRows(string $table, $pkCols): array {
        try {
            $cols = is_array($pkCols) ? implode(',', $pkCols) : $pkCols;
            $rows = rows("SELECT $cols FROM `$table`");
            $result = [];
            foreach ($rows as $r) {
                $key = self::recordKey($r, $pkCols);
                $hash = hash('sha256', json_encode($r));
                $result[$key] = $hash;
            }
            return $result;
        } catch (Throwable $e) {
            return [];
        }
    }

    private static function recordKey(array $rec, $pkCols): string {
        if (is_array($pkCols)) {
            $parts = [];
            foreach ($pkCols as $c) $parts[] = $rec[$c] ?? '';
            return implode('|', $parts);
        }
        return (string)($rec[$pkCols] ?? '');
    }
}
