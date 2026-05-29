<?php
class AircraftTypesScraper {
    public static function fetch(array $source, string &$rawContent): array {
        $url = $source['url'] ?? 'https://davidmegginson.github.io/ourairports-data/aircraft_types.csv';
        $csv = @file_get_contents($url, false, stream_context_create([
            'http' => ['timeout' => 60, 'method' => 'GET', 'header' => "Accept: text/csv\r\n"],
        ]));
        if ($csv === false) {
            $err = error_get_last();
            throw new RuntimeException('Failed to fetch aircraft_types CSV: ' . ($err['message'] ?? 'unknown error'));
        }
        $rawContent = $csv;

        $fh = fopen('php://temp', 'r+');
        fwrite($fh, $csv);
        rewind($fh);

        $header = fgetcsv($fh);
        if (!$header) { fclose($fh); throw new RuntimeException('aircraft_types CSV has no header'); }
        $header = array_map('trim', $header);

        $colIdx = array_flip($header);

        $records = [];
        while (($row = fgetcsv($fh)) !== false) {
            $icao = strtoupper(trim($row[$colIdx['icao_code']] ?? ''));
            if ($icao === '') continue;

            $manufacturer = trim($row[$colIdx['manufacturer']] ?? '');
            if ($manufacturer === '') continue;

            $records[] = [
                'icao_code' => $icao,
                'iata_code' => strtoupper(trim($row[$colIdx['iata_code']] ?? '')) ?: null,
                'manufacturer' => $manufacturer,
                'model' => trim($row[$colIdx['model']] ?? '') ?: null,
                'type' => trim($row[$colIdx['type']] ?? '') ?: null,
                'description' => trim($row[$colIdx['description']] ?? '') ?: null,
                'engine_type' => trim($row[$colIdx['engine_type']] ?? '') ?: null,
                'engine_count' => ($row[$colIdx['engine_count']] ?? '') !== '' ? (int)$row[$colIdx['engine_count']] : null,
                'wtc' => strtoupper(trim($row[$colIdx['wtc']] ?? '')) ?: null,
            ];
        }

        fclose($fh);
        return $records;
    }
}
