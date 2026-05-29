<?php
require_once __DIR__ . '/../../includes/db.php';

class Validator {
    public static function validate(string $moduleKey, array $records): array {
        $valid = [];
        $errors = [];

        $method = 'validate' . str_replace(' ', '', ucwords(str_replace('_', ' ', $moduleKey)));
        if (method_exists(self::class, $method)) {
            foreach ($records as $i => $rec) {
                try {
                    $valid[] = self::$method($rec, $i);
                } catch (ValidationException $e) {
                    $errors[] = ['index' => $i, 'record' => $rec, 'error' => $e->getMessage()];
                }
            }
        } else {
            foreach ($records as $i => $rec) {
                $valid[] = $rec;
            }
        }

        return [$valid, $errors];
    }

    private static function validateCountries(array $rec, int $i): array {
        if (empty($rec['iso_alpha_2']) || strlen($rec['iso_alpha_2']) !== 2) {
            throw new ValidationException("Row $i: missing or invalid iso_alpha_2");
        }
        if (empty($rec['name_common'])) {
            throw new ValidationException("Row $i: missing name_common");
        }
        $rec['iso_alpha_2'] = strtoupper($rec['iso_alpha_2']);
        return $rec;
    }

    private static function validateCaas(array $rec, int $i): array {
        if (empty($rec['country_code'])) {
            throw new ValidationException("Row $i: missing country_code");
        }
        if (empty($rec['name'])) {
            throw new ValidationException("Row $i: missing CAA name");
        }
        return $rec;
    }

    private static function validateCountryTransportStats(array $rec, int $i): array {
        if (empty($rec['country_code'])) throw new ValidationException("Row $i: missing country_code");
        if (empty($rec['statistic_year'])) throw new ValidationException("Row $i: missing statistic_year");
        if (empty($rec['mode'])) throw new ValidationException("Row $i: missing mode");
        if (empty($rec['metric'])) throw new ValidationException("Row $i: missing metric");
        return $rec;
    }

    private static function validateAirports(array $rec, int $i): array {
        if (empty($rec['ident'])) throw new ValidationException("Row $i: missing ident");
        if (empty($rec['name'])) throw new ValidationException("Row $i: missing airport name");
        if (!empty($rec['iso_country']) && strlen($rec['iso_country']) !== 2) {
            throw new ValidationException("Row $i: invalid iso_country '{$rec['iso_country']}'");
        }
        return $rec;
    }

    private static function validateAirlines(array $rec, int $i): array {
        if (empty($rec['icao_code'])) throw new ValidationException("Row $i: missing icao_code");
        if (empty($rec['name'])) throw new ValidationException("Row $i: missing airline name");
        return $rec;
    }

    private static function validateAirportFrequencies(array $rec, int $i): array {
        if (empty($rec['airport_ident'])) throw new ValidationException("Row $i: missing airport_ident");
        if (empty($rec['frequency_mhz']) && $rec['frequency_mhz'] !== 0 && $rec['frequency_mhz'] !== '0') {
            throw new ValidationException("Row $i: missing frequency_mhz");
        }
        return $rec;
    }

    private static function validateNavaids(array $rec, int $i): array {
        if (empty($rec['ident'])) throw new ValidationException("Row $i: missing ident");
        if (empty($rec['name'])) throw new ValidationException("Row $i: missing navaid name");
        return $rec;
    }

    private static function validateAircraftTypes(array $rec, int $i): array {
        if (empty($rec['icao_code'])) throw new ValidationException("Row $i: missing icao_code");
        if (empty($rec['manufacturer'])) throw new ValidationException("Row $i: missing manufacturer");
        return $rec;
    }
}

class ValidationException extends Exception {}
