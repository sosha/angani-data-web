<?php
require_once __DIR__ . '/../CountryNameResolver.php';

class OurAirlinesScraper {
    public static function fetch(array $source, string &$rawContent): array {
        $url = $source['url'] ?? 'https://davidmegginson.github.io/ourairports-data/airlines.csv';
        $csv = @file_get_contents($url, false, stream_context_create([
            'http' => ['timeout' => 60, 'method' => 'GET', 'header' => "Accept: text/csv\r\n"],
        ]));
        if ($csv === false) {
            $err = error_get_last();
            throw new RuntimeException('Failed to fetch OurAirlines CSV: ' . ($err['message'] ?? 'unknown error'));
        }
        $rawContent = $csv;

        $fh = fopen('php://temp', 'r+');
        fwrite($fh, $csv);
        rewind($fh);

        $header = fgetcsv($fh);
        if (!$header) { fclose($fh); throw new RuntimeException('OurAirlines CSV has no header'); }
        $header = array_map('trim', $header);

        $colIdx = array_flip($header);

        $records = [];
        while (($row = fgetcsv($fh)) !== false) {
            $icao = strtoupper(trim($row[$colIdx['icao']] ?? ''));
            if ($icao === '') continue;

            $name = trim($row[$colIdx['name']] ?? '');
            if ($name === '') continue;

            $countryName = trim($row[$colIdx['country']] ?? '');
            $countryCode = $countryName ? CountryNameResolver::resolve($countryName) : null;

            $records[] = [
                'icao_code' => $icao,
                'iata_code' => strtoupper(trim($row[$colIdx['iata']] ?? '')) ?: null,
                'name' => $name,
                'alias' => trim($row[$colIdx['alias']] ?? '') ?: null,
                'callsign' => trim($row[$colIdx['callsign']] ?? '') ?: null,
                'country' => $countryName ?: null,
                'country_code' => $countryCode,
                'active' => strtolower(trim($row[$colIdx['active']] ?? '')) === 'y' ? 'Y' : 'N',
            ];
        }

        fclose($fh);
        return $records;
    }
}
