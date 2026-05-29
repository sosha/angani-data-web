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
                if (!self::isValidCountryIso2($countryId)) continue;

                $year = (int)($entry['date'] ?? 0);
                if ($year < 2015 || $year > 2026) continue;

                $records[] = [
                    'country_code' => $countryId,
                    'statistic_year' => $year,
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

    private static function isValidCountryIso2(string $code): bool {
        if (strlen($code) !== 2) return false;
        static $valid = null;
        if ($valid === null) {
            $valid = [];
            try {
                $rows = rows('SELECT iso_alpha_2 FROM countries');
                foreach ($rows as $r) $valid[$r['iso_alpha_2']] = true;
            } catch (Throwable $e) {}
        }
        return isset($valid[$code]);
    }
}
