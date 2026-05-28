<?php
class WorldBankScraper {
    private static array $indicatorMap = [
        'IS.AIR.DPRT' => ['metric' => 'aircraft_departures', 'unit' => 'departures'],
        'IS.AIR.PSGR' => ['metric' => 'passengers_carried', 'unit' => 'passengers'],
        'IS.AIR.FRGT' => ['metric' => 'freight_tonnes', 'unit' => 'tonnes'],
    ];

    public static function fetch(array $source, string &$rawContent): array {
        $baseUrl = 'https://api.worldbank.org/v2/country/all/indicator/';
        $indicators = ['IS.AIR.DPRT', 'IS.AIR.PSGR', 'IS.AIR.FRGT'];
        $records = [];
        $rawParts = [];

        foreach ($indicators as $indicator) {
            $url = $baseUrl . $indicator . '?format=json&per_page=5000&date=2015:2024';
            $json = @file_get_contents($url, false, stream_context_create([
                'http' => ['timeout' => 30, 'method' => 'GET', 'header' => "Accept: application/json\r\n"],
            ]));
            if ($json === false) continue;

            $rawParts[] = $json;
            $data = json_decode($json, true);
            if (!is_array($data) || count($data) < 2) continue;

            $mapping = self::$indicatorMap[$indicator];
            $entries = $data[1];

            foreach ($entries as $entry) {
                if ($entry['value'] === null) continue;
                $countryId = $entry['country']['id'] ?? '';
                if (strlen($countryId) !== 3) continue;

                $iso2 = self::iso3ToIso2($countryId);
                if (!$iso2) continue;

                $year = (int)($entry['date'] ?? 0);
                if ($year < 2015 || $year > 2026) continue;

                $records[] = [
                    'country_code' => $iso2,
                    'statistic_year' => $year,
                    'quarter' => null,
                    'mode' => 'air',
                    'metric' => $mapping['metric'],
                    'value' => (float)$entry['value'],
                    'unit' => $mapping['unit'],
                    'source' => 'World Bank API',
                ];
            }
        }

        $rawContent = implode("\n--SEPARATOR--\n", $rawParts);
        return $records;
    }

    private static function iso3ToIso2(string $iso3): ?string {
        static $map = null;
        if ($map === null) {
            $map = [];
            try {
                $rows = rows('SELECT iso_alpha_2, iso_alpha_3 FROM countries WHERE iso_alpha_3 IS NOT NULL');
                foreach ($rows as $r) $map[$r['iso_alpha_3']] = $r['iso_alpha_2'];
            } catch (Throwable $e) {}
        }
        return $map[$iso3] ?? null;
    }
}
