<?php
require_once __DIR__ . '/sources/RestCountriesScraper.php';
require_once __DIR__ . '/sources/RestCountriesFactsScraper.php';
require_once __DIR__ . '/sources/CaaCsvScraper.php';
require_once __DIR__ . '/sources/WorldBankScraper.php';
require_once __DIR__ . '/sources/WorldBankDynamicFactsScraper.php';

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

        throw new RuntimeException("No scraper configured for source type '$type' / module '$module'.");
    }
}
