<?php
class OptdAircraftTypesScraper {
    public static function fetch(): array {
        $csv = @file_get_contents('https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_aircraft.csv');
        if ($csv === false) throw new RuntimeException('Failed to fetch OPTD aircraft data');

        $records = [];
        $lines = explode("\n", trim($csv));
        $header = str_getcsv(array_shift($lines), '^');
        $idx = array_flip($header);

        foreach ($lines as $line) {
            $line = trim($line);
            if ($line === '') continue;
            $fields = str_getcsv($line, '^');
            if (count($fields) < count($header)) continue;

            $icao = strtoupper(trim($fields[$idx['icao_code']] ?? ''));
            $manufacturer = trim($fields[$idx['manufacturer']] ?? '');
            $model = trim($fields[$idx['model']] ?? '');
            if ($icao === '' || ($manufacturer === '' && $model === '')) continue;

            $iata = strtoupper(trim($fields[$idx['iata_code']] ?? ''));
            $nbEngines = isset($idx['nb_engines']) ? trim($fields[$idx['nb_engines']] ?? '') : '';
            $aircraftType = isset($idx['aircraft_type']) ? strtoupper(trim($fields[$idx['aircraft_type']] ?? '')) : '';
            $iataCategory = isset($idx['iata_category']) ? trim($fields[$idx['iata_category']] ?? '') : '';

            $description = null;
            if ($iataCategory !== '' && preg_match('/^(\d+)([JPTHE])$/i', $iataCategory, $m)) {
                $descMap = ['J' => 'J', 'P' => 'P', 'T' => 'T', 'H' => 'H', 'E' => 'E'];
                $dt = $descMap[strtoupper($m[2])] ?? '?';
                $description = 'L' . $m[1] . $dt;
            }

            $engineMap = ['J' => 'Jet', 'P' => 'Piston', 'T' => 'Turboprop/Turboshaft', 'H' => 'Helicopter', 'S' => 'Surface', 'E' => 'Electric'];
            $engineType = $engineMap[$aircraftType] ?? null;

            $records[] = [
                'icao_code' => $icao,
                'iata_code' => ($iata !== '' && $iata !== '0') ? $iata : null,
                'manufacturer' => $manufacturer,
                'model' => $model !== '' ? $model : null,
                'type' => null,
                'description' => $description,
                'engine_type' => $engineType,
                'engine_count' => ($nbEngines !== '' && ctype_digit($nbEngines)) ? (int)$nbEngines : null,
                'wtc' => null,
            ];
        }

        return $records;
    }
}
