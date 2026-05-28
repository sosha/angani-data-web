<?php
require_once __DIR__ . '/../CountryNameResolver.php';

class CaaCsvScraper {
    public static function fetch(array $source, string &$rawContent): array {
        $csvPath = __DIR__ . '/../../../data/countries/caas.csv';
        if (!file_exists($csvPath)) throw new RuntimeException("CAAs CSV not found at $csvPath");

        $csvContent = file_get_contents($csvPath);
        if ($csvContent === false) throw new RuntimeException("Could not read $csvPath");
        $rawContent = $csvContent;

        $fh = fopen($csvPath, 'r');
        if (!$fh) throw new RuntimeException("Could not open $csvPath");

        $header = fgetcsv($fh);
        if (!$header) { fclose($fh); throw new RuntimeException('CAAs CSV has no header'); }

        $header = array_map('trim', $header);
        $nameIdx = array_search('Country', $header);
        $caaNameIdx = array_search('CAA Name', $header);
        $websiteIdx = array_search('CAA Website', $header);
        $notesIdx = array_search('Verification Notes', $header);

        if ($nameIdx === false || $caaNameIdx === false) {
            fclose($fh);
            throw new RuntimeException('CAAs CSV missing required columns: Country, CAA Name');
        }

        $records = [];
        while (($row = fgetcsv($fh)) !== false) {
            $countryName = trim($row[$nameIdx] ?? '');
            if ($countryName === '') continue;

            $countryCode = CountryNameResolver::resolve($countryName);
            if (!$countryCode) continue;

            $caaName = trim($row[$caaNameIdx] ?? '');
            if ($caaName === '') continue;

            $website = ($websiteIdx !== false) ? trim($row[$websiteIdx] ?? '') : '';
            $notes = ($notesIdx !== false) ? trim($row[$notesIdx] ?? '') : '';

            $abbreviation = self::extractAbbreviation($caaName);

            $records[] = [
                'country_code' => $countryCode,
                'name' => $caaName,
                'abbreviation' => $abbreviation,
                'website' => $website !== '-' ? $website : null,
                'data_availability_notes' => $notes ?: null,
            ];
        }

        fclose($fh);
        return $records;
    }

    private static function extractAbbreviation(string $name): ?string {
        if (preg_match('/\(([A-ZÄÖÜÅÂÊÎÔÛÉÈ]{2,8})\)/', $name, $m)) {
            return $m[1];
        }
        if (preg_match('/^([A-ZÄÖÜÅÂÊÎÔÛÉÈ]{2,8})\b/', $name, $m)) {
            return $m[1];
        }
        return null;
    }
}
