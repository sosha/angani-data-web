<?php
require_once __DIR__ . '/../CountryNameResolver.php';

class OpenFlightsAirlinesScraper {
    public static function fetch(): array {
        $csv = @file_get_contents('https://raw.githubusercontent.com/jpatokal/openflights/master/data/airlines.dat');
        if ($csv === false) throw new RuntimeException('Failed to fetch OpenFlights airlines.dat');

        $resolver = new CountryNameResolver();
        $records = [];
        $lines = explode("\n", trim($csv));
        foreach ($lines as $line) {
            $line = trim($line);
            if ($line === '') continue;
            $fields = str_getcsv($line);
            if (count($fields) < 8) continue;

            $icao = trim($fields[4] ?? '');
            $iata = trim($fields[3] ?? '');
            $name = trim($fields[1] ?? '');
            $alias = trim($fields[2] ?? '');
            $callsign = trim($fields[5] ?? '');
            $countryName = trim($fields[6] ?? '');
            $active = trim($fields[7] ?? '');

            if ($icao === '' || $icao === '-' || $icao === '\N' || $icao === '\\N') continue;
            if ($name === '' || $name === '-' || $name === '\N' || $name === '\\N') continue;
            if (str_starts_with($icao, 'UNK')) continue;

            $countryCode = $resolver->resolve($countryName);

            $records[] = [
                'icao_code' => $icao,
                'iata_code' => ($iata !== '' && $iata !== '-' && $iata !== '\N' && $iata !== '\\N') ? $iata : null,
                'name' => $name,
                'alias' => ($alias !== '' && $alias !== '-' && $alias !== '\N' && $alias !== '\\N') ? $alias : null,
                'callsign' => ($callsign !== '' && $callsign !== '-' && $callsign !== '\N' && $callsign !== '\\N') ? $callsign : null,
                'country' => $countryName,
                'country_code' => $countryCode,
                'active' => (strtoupper($active) === 'Y') ? 'Y' : 'N',
            ];
        }

        return $records;
    }
}
