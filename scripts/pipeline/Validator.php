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
}

class ValidationException extends Exception {}
