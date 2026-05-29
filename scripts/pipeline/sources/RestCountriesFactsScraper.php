<?php
class RestCountriesFactsScraper {
    public static function fetch(array $source, string &$rawContent): array {
        $url = $source['url'] ?? 'https://restcountries.com/v3.1/all?fields=cca2,area,capital,languages,currencies,timezones';
        $json = @file_get_contents($url, false, stream_context_create([
            'http' => ['timeout' => 30, 'method' => 'GET', 'header' => "Accept: application/json\r\n"],
        ]));
        if ($json === false) {
            $err = error_get_last();
            throw new RuntimeException('Failed to fetch REST Countries API: ' . ($err['message'] ?? 'unknown error'));
        }

        $rawContent = $json;
        $data = json_decode($json, true);
        if (!is_array($data)) throw new RuntimeException('Invalid JSON from REST Countries API.');

        $records = [];
        foreach ($data as $country) {
            $cca2 = strtoupper($country['cca2'] ?? '');
            if (!$cca2) continue;

            if (isset($country['area'])) {
                $records[] = [
                    'country_code' => $cca2,
                    'fact_key' => 'area',
                    'fact_value' => (string)$country['area'],
                    'source' => 'REST Countries API',
                ];
            }

            $capital = $country['capital'] ?? null;
            if (!empty($capital) && is_array($capital)) {
                $records[] = [
                    'country_code' => $cca2,
                    'fact_key' => 'capital',
                    'fact_value' => implode(', ', $capital),
                    'source' => 'REST Countries API',
                ];
            }

            $languages = $country['languages'] ?? null;
            if (!empty($languages) && is_array($languages)) {
                $records[] = [
                    'country_code' => $cca2,
                    'fact_key' => 'languages',
                    'fact_value' => implode(', ', array_values($languages)),
                    'source' => 'REST Countries API',
                ];
            }

            $currencies = $country['currencies'] ?? null;
            if (!empty($currencies) && is_array($currencies)) {
                $names = [];
                foreach ($currencies as $code => $info) {
                    $names[] = $info['name'] ?? $code;
                }
                $records[] = [
                    'country_code' => $cca2,
                    'fact_key' => 'currencies',
                    'fact_value' => implode(', ', $names),
                    'source' => 'REST Countries API',
                ];
            }

            $timezones = $country['timezones'] ?? null;
            if (!empty($timezones) && is_array($timezones)) {
                $records[] = [
                    'country_code' => $cca2,
                    'fact_key' => 'timezones',
                    'fact_value' => implode(', ', $timezones),
                    'source' => 'REST Countries API',
                ];
            }
        }

        return $records;
    }
}
