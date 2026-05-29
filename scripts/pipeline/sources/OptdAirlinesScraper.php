<?php
class OptdAirlinesScraper {
    public static function fetch(): array {
        $csv = @file_get_contents('https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_airline_best_known_so_far.csv');
        if ($csv === false) throw new RuntimeException('Failed to fetch OPTD airline data');

        $records = [];
        $lines = explode("\n", trim($csv));
        $header = str_getcsv(array_shift($lines), '^');
        $idx = array_flip($header);

        foreach ($lines as $line) {
            $line = trim($line);
            if ($line === '') continue;
            $fields = str_getcsv($line, '^');
            if (count($fields) < count($header)) continue;

            $icao = strtoupper(trim($fields[$idx['3char_code']] ?? ''));
            $name = trim($fields[$idx['name']] ?? '');
            if ($icao === '' || $name === '' || $icao === 'YYY') continue;

            $iata = strtoupper(trim($fields[$idx['2char_code']] ?? ''));
            $name2 = trim($fields[$idx['name2']] ?? '');
            $validIata = ($iata !== '' && $iata !== '0' && $iata !== 'N/A');

            $records[] = [
                'icao_code' => $icao,
                'iata_code' => $validIata ? $iata : null,
                'name' => $name,
                'alias' => $name2 !== '' ? $name2 : null,
                'callsign' => null,
                'country' => null,
                'country_code' => null,
                'active' => null,
            ];
        }

        return $records;
    }
}
