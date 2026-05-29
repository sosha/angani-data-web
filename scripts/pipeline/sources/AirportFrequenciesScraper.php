<?php
class AirportFrequenciesScraper {
    public static function fetch(array $source, string &$rawContent): array {
        $url = $source['url'] ?? 'https://davidmegginson.github.io/ourairports-data/airport-frequencies.csv';
        $csv = @file_get_contents($url, false, stream_context_create([
            'http' => ['timeout' => 60, 'method' => 'GET', 'header' => "Accept: text/csv\r\n"],
        ]));
        if ($csv === false) {
            $err = error_get_last();
            throw new RuntimeException('Failed to fetch airport-frequencies CSV: ' . ($err['message'] ?? 'unknown error'));
        }
        $rawContent = $csv;

        $fh = fopen('php://temp', 'r+');
        fwrite($fh, $csv);
        rewind($fh);

        $header = fgetcsv($fh);
        if (!$header) { fclose($fh); throw new RuntimeException('airport-frequencies CSV has no header'); }
        $header = array_map('trim', $header);

        $colIdx = array_flip($header);

        $records = [];
        while (($row = fgetcsv($fh)) !== false) {
            $airportIdent = trim($row[$colIdx['airport_ident']] ?? '');
            if ($airportIdent === '') continue;

            $freq = trim($row[$colIdx['frequency_mhz']] ?? '');
            if ($freq === '' || $freq === '0') continue;

            $records[] = [
                'airport_ident' => $airportIdent,
                'type' => trim($row[$colIdx['type']] ?? '') ?: null,
                'description' => trim($row[$colIdx['description']] ?? '') ?: null,
                'frequency_mhz' => (float)$freq,
            ];
        }

        fclose($fh);
        return $records;
    }
}
