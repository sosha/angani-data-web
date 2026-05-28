<?php
class RestCountriesScraper {
    public static function fetch(array $source, string &$rawContent): array {
        $url = $source['url'] ?? 'https://restcountries.com/v3.1/all?fields=cca2,cca3,name,region,subregion';
        $json = @file_get_contents($url, false, stream_context_create([
            'http' => ['timeout' => 30, 'method' => 'GET', 'header' => "Accept: application/json\r\n"],
        ]));
        if ($json === false) throw new RuntimeException('Failed to fetch REST Countries API.');

        $rawContent = $json;
        $data = json_decode($json, true);
        if (!is_array($data)) throw new RuntimeException('Invalid JSON from REST Countries API.');

        $records = [];
        foreach ($data as $country) {
            $cca2 = strtoupper($country['cca2'] ?? '');
            if (!$cca2) continue;

            $region = $country['region'] ?? null;
            if ($region === 'Antarctic') $region = 'Antarctica';

            $records[] = [
                'iso_alpha_2' => $cca2,
                'iso_alpha_3' => strtoupper($country['cca3'] ?? ''),
                'name_common' => $country['name']['common'] ?? '',
                'name_official' => $country['name']['official'] ?? '',
                'continent' => $region,
                'un_region' => $country['subregion'] ?? null,
            ];
        }

        return $records;
    }
}
