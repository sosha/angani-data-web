<?php
class OurAirportsScraper {
    public static function fetch(array $source, string &$rawContent): array {
        $url = $source['url'] ?? 'https://davidmegginson.github.io/ourairports-data/airports.csv';
        $csv = @file_get_contents($url, false, stream_context_create([
            'http' => ['timeout' => 60, 'method' => 'GET', 'header' => "Accept: text/csv\r\n"],
        ]));
        if ($csv === false) {
            $err = error_get_last();
            throw new RuntimeException('Failed to fetch OurAirports CSV: ' . ($err['message'] ?? 'unknown error'));
        }
        $rawContent = $csv;

        $fh = fopen('php://temp', 'r+');
        fwrite($fh, $csv);
        rewind($fh);

        $header = fgetcsv($fh);
        if (!$header) { fclose($fh); throw new RuntimeException('OurAirports CSV has no header'); }
        $header = array_map('trim', $header);

        $colIdx = array_flip($header);

        $records = [];
        while (($row = fgetcsv($fh)) !== false) {
            $ident = trim($row[$colIdx['ident']] ?? '');
            if ($ident === '') continue;

            $type = trim($row[$colIdx['type']] ?? '');
            if ($type === 'closed') continue;

            $sched = strtolower(trim($row[$colIdx['scheduled_service']] ?? '')) === 'yes' ? 1 : 0;

            $records[] = [
                'ident' => $ident,
                'type' => $type ?: null,
                'name' => trim($row[$colIdx['name']] ?? ''),
                'latitude_deg' => ($row[$colIdx['latitude_deg']] ?? '') !== '' ? (float)$row[$colIdx['latitude_deg']] : null,
                'longitude_deg' => ($row[$colIdx['longitude_deg']] ?? '') !== '' ? (float)$row[$colIdx['longitude_deg']] : null,
                'elevation_ft' => ($row[$colIdx['elevation_ft']] ?? '') !== '' ? (int)$row[$colIdx['elevation_ft']] : null,
                'continent' => trim($row[$colIdx['continent']] ?? '') ?: null,
                'iso_country' => strtoupper(trim($row[$colIdx['iso_country']] ?? '')),
                'municipality' => trim($row[$colIdx['municipality']] ?? '') ?: null,
                'scheduled_service' => $sched,
                'gps_code' => strtoupper(trim($row[$colIdx['gps_code']] ?? '')) ?: null,
                'iata_code' => strtoupper(trim($row[$colIdx['iata_code']] ?? '')) ?: null,
                'local_code' => strtoupper(trim($row[$colIdx['local_code']] ?? '')) ?: null,
                'home_link' => trim($row[$colIdx['home_link']] ?? '') ?: null,
                'wikipedia_link' => trim($row[$colIdx['wikipedia_link']] ?? '') ?: null,
                'keywords' => trim($row[$colIdx['keywords']] ?? '') ?: null,
            ];
        }

        fclose($fh);
        return $records;
    }
}
