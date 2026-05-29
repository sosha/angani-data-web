<?php
class NavaidsScraper {
    public static function fetch(array $source, string &$rawContent): array {
        $url = $source['url'] ?? 'https://davidmegginson.github.io/ourairports-data/navaids.csv';
        $csv = @file_get_contents($url, false, stream_context_create([
            'http' => ['timeout' => 60, 'method' => 'GET', 'header' => "Accept: text/csv\r\n"],
        ]));
        if ($csv === false) {
            $err = error_get_last();
            throw new RuntimeException('Failed to fetch navaids CSV: ' . ($err['message'] ?? 'unknown error'));
        }
        $rawContent = $csv;

        $fh = fopen('php://temp', 'r+');
        fwrite($fh, $csv);
        rewind($fh);

        $header = fgetcsv($fh);
        if (!$header) { fclose($fh); throw new RuntimeException('navaids CSV has no header'); }
        $header = array_map('trim', $header);

        $colIdx = array_flip($header);

        $records = [];
        while (($row = fgetcsv($fh)) !== false) {
            $ident = strtoupper(trim($row[$colIdx['ident']] ?? ''));
            if ($ident === '') continue;

            $name = trim($row[$colIdx['name']] ?? '');
            if ($name === '') continue;

            $records[] = [
                'ident' => $ident,
                'name' => $name,
                'type' => trim($row[$colIdx['type']] ?? '') ?: null,
                'frequency_khz' => ($row[$colIdx['frequency_khz']] ?? '') !== '' ? (float)$row[$colIdx['frequency_khz']] : null,
                'latitude_deg' => ($row[$colIdx['latitude_deg']] ?? '') !== '' ? (float)$row[$colIdx['latitude_deg']] : null,
                'longitude_deg' => ($row[$colIdx['longitude_deg']] ?? '') !== '' ? (float)$row[$colIdx['longitude_deg']] : null,
                'elevation_ft' => ($row[$colIdx['elevation_ft']] ?? '') !== '' ? (int)$row[$colIdx['elevation_ft']] : null,
                'iso_country' => strtoupper(trim($row[$colIdx['iso_country']] ?? '')) ?: null,
            ];
        }

        fclose($fh);
        return $records;
    }
}
