<?php

class WorldBankDynamicFactsScraper {
    private static array $indicatorMap = [
        'SP.POP.TOTL' => ['metric_key' => 'population', 'unit' => 'people'],
        'NY.GDP.MKTP.CD' => ['metric_key' => 'gdp_usd', 'unit' => 'current USD'],
    ];

    public static function fetch(array $source, string &$rawContent): array {
        $indicators = ['SP.POP.TOTL', 'NY.GDP.MKTP.CD'];
        $records = [];
        $rawParts = [];

        foreach ($indicators as $indicator) {
            $url = 'https://api.worldbank.org/v2/country/all/indicator/' . $indicator . '?format=json&per_page=5000&date=2015:2024';
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
                if (strlen($countryId) !== 2) continue;
                if (!self::isValidCountryIso2($countryId)) continue;

                $year = (int)($entry['date'] ?? 0);
                if ($year < 2015 || $year > 2026) continue;

                $records[] = [
                    'country_code' => $countryId,
                    'metric_key' => $mapping['metric_key'],
                    'year' => $year,
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
