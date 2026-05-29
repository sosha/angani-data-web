<?php
require_once __DIR__ . '/sources/RestCountriesScraper.php';
require_once __DIR__ . '/sources/RestCountriesFactsScraper.php';
require_once __DIR__ . '/sources/CaaCsvScraper.php';
require_once __DIR__ . '/sources/WorldBankScraper.php';
require_once __DIR__ . '/sources/WorldBankDynamicFactsScraper.php';
require_once __DIR__ . '/sources/OurAirportsScraper.php';
require_once __DIR__ . '/sources/AirportFrequenciesScraper.php';
require_once __DIR__ . '/sources/NavaidsScraper.php';
require_once __DIR__ . '/sources/OptdAirlinesScraper.php';
require_once __DIR__ . '/sources/OptdAircraftTypesScraper.php';

class Fetcher {
    public static function fetch(int $sourceId, array $source, string &$rawContent): array {
        $module = $source['module_key'];
        $type = $source['source_type'];

        if ($type === 'api' && $module === 'countries') {
            return RestCountriesScraper::fetch($source, $rawContent);
        }
        if ($type === 'api' && $module === 'country_facts') {
            return RestCountriesFactsScraper::fetch($source, $rawContent);
        }
        if ($type === 'csv_upload' && $module === 'caas') {
            return CaaCsvScraper::fetch($source, $rawContent);
        }
        if ($type === 'api' && $module === 'country_transport_stats') {
            return WorldBankScraper::fetch($source, $rawContent);
        }
        if ($type === 'api' && $module === 'country_dynamic_facts') {
            return WorldBankDynamicFactsScraper::fetch($source, $rawContent);
        }
        if ($type === 'url_csv' && $module === 'airports') {
            return OurAirportsScraper::fetch($source, $rawContent);
        }
        if ($type === 'url_csv' && $module === 'airlines') {
            return OptdAirlinesScraper::fetch();
        }
        if ($type === 'url_csv' && $module === 'airport_frequencies') {
            return AirportFrequenciesScraper::fetch($source, $rawContent);
        }
        if ($type === 'url_csv' && $module === 'navaids') {
            return NavaidsScraper::fetch($source, $rawContent);
        }
        if ($type === 'url_csv' && $module === 'aircraft_types') {
            return OptdAircraftTypesScraper::fetch();
        }

        throw new RuntimeException("No scraper configured for source type '$type' / module '$module'.");
    }
}
