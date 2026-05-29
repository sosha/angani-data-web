<?php
/**
 * Fetch Wikipedia List of Airline Codes and update airlines table with missing fields.
 * Usage: ANGANI_DB_PASS=rootpassword php scripts/ingest_wikipedia_airline_codes.php
 *
 * Updates: iata_code, icao_code, call_sign, country_code where currently NULL or empty.
 * Matches by ICAO first, then IATA, then name.
 */
require_once __DIR__.'/../includes/db.php';

echo "Wikipedia Airline Codes Ingester\n==============================\n\n";

$url = 'https://en.wikipedia.org/wiki/List_of_airline_codes';
echo "Fetching $url ...\n";
$html = @shell_exec("curl -sL --max-time 30 -A 'Mozilla/5.0' " . escapeshellarg($url));
if(!$html) die("Failed to fetch Wikipedia page\n");

// Try multiple approaches to parse tables
$rowCount = 0;
$updated = 0;

// Approach 1: Find all wikitable tables
preg_match_all('/<table[^>]*class="[^"]*wikitable[^"]*"[^>]*>/s', $html, $tableOpenMatches, PREG_OFFSET_CAPTURE);
$tables = [];
foreach($tableOpenMatches[0] as $match){
    $start = $match[1];
    $openLen = strlen($match[0]);
    // Find matching closing </table>
    $pos = $start + $openLen;
    $depth = 1;
    while($depth > 0 && $pos < strlen($html)){
        $nextOpen = strpos($html, '<table', $pos);
        $nextClose = strpos($html, '</table>', $pos);
        if($nextClose === false) break;
        if($nextOpen !== false && $nextOpen < $nextClose){
            $depth++;
            $pos = $nextOpen + 6;
        } else {
            $depth--;
            $pos = $nextClose + 8;
        }
    }
    $tableContent = substr($html, $start, $pos - $start);
    parse_wikitable($tableContent);
}

if($rowCount === 0){
    echo "No rows found via wikitable parsing. Trying legacy plain table parsing...\n";
    // Approach 2: fallback - look for IATA pattern directly
    preg_match_all('/<tr>\s*<td>(?:<[^>]*>)*([A-Z0-9]{1,3})?(?:<[^>]*>)*<\/td>\s*<td>(?:<[^>]*>)*([A-Z0-9]{1,4})?(?:<[^>]*>)*<\/td>\s*<td>(.*?)<\/td>\s*<td>(.*?)<\/td>\s*<td>(.*?)<\/td>/s', $html, $directMatches);
    foreach($directMatches[0] as $i => $m){
        $iata = trim(strip_tags($directMatches[1][$i]));
        $icao = trim(strip_tags($directMatches[2][$i]));
        $name = trim(strip_tags($directMatches[3][$i]));
        $callsign = trim(strip_tags($directMatches[4][$i]));
        $country = trim(strip_tags($directMatches[5][$i]));
        $name = html_entity_decode($name, ENT_QUOTES|ENT_HTML5);
        $callsign = html_entity_decode($callsign, ENT_QUOTES|ENT_HTML5);
        $country = html_entity_decode($country, ENT_QUOTES|ENT_HTML5);
        // Clean up references
        $name = preg_replace('/\[\d+\]/', '', $name);
        $callsign = preg_replace('/\[\d+\]/', '', $callsign);
        $country = preg_replace('/\[\d+\]/', '', $country);
        $name = trim($name);
        $callsign = trim($callsign);
        $country = trim($country);
        if(empty($name) || strlen($name) > 80) continue;
        process_row($iata, $icao, $name, $callsign, $country);
    }
}

echo "\nDone. Processed $rowCount rows, Updated $updated records.\n";

function parse_wikitable(string $tableHtml): void {
    preg_match_all('/<tr>(.*?)<\/tr>/s', $tableHtml, $rowMatches);
    foreach($rowMatches[1] as $rowHtml){
        preg_match_all('/<td[^>]*>(.*?)<\/td>/s', $rowHtml, $cellMatches);
        $cells = array_map(function($c){
            $c = strip_tags($c);
            $c = html_entity_decode($c, ENT_QUOTES|ENT_HTML5);
            $c = trim($c);
            $c = preg_replace('/\[\d+\]/', '', $c);
            $c = preg_replace('/\[citation needed\]/', '', $c);
            $c = preg_replace('/\s+/', ' ', $c);
            return trim($c);
        }, $cellMatches[1]);
        if(count($cells) < 5) continue;
        $iata = $cells[0];
        $icao = $cells[1];
        $name = $cells[2];
        $callsign = $cells[3];
        $country = $cells[4];
        if(empty($name) || strlen($name) > 80) continue;
        process_row($iata, $icao, $name, $callsign, $country);
    }
}

function process_row(string $iata, string $icao, string $name, string $callsign, string $country): void {
    global $rowCount, $updated;
    if($icao === 'n/a') $icao = '';
    if($iata === 'n/a') $iata = '';
    $skipKeywords = ['Amadeus','Sabre','Travelport','Travelsky','Infini','Sirena','Google/ITA',
                     'Galileo','Worldspan','Abacus','Hitit','Electronic Data','reservation system',
                     'Distribution System','Computer reservation','GDS and airline','IT provider',
                     'Train services'];
    foreach($skipKeywords as $kw){ if(stripos($name, $kw) !== false) return; }

    $rowCount++;
    $countryCode = country_to_iso($country);
    $found = false;

    if(!empty($icao)){
        $existing = row("SELECT icao_code,iata_code,callsign,country_code FROM airlines WHERE icao_code=?", [$icao]);
        if($existing){ $found = true; apply_updates($existing, $iata, $icao, $callsign, $countryCode, 'icao_code', $icao); }
    }
    if(!$found && !empty($iata)){
        $existing = row("SELECT icao_code,iata_code,callsign,country_code FROM airlines WHERE iata_code=?", [$iata]);
        if($existing){ $found = true; apply_updates($existing, $iata, $icao, $callsign, $countryCode, 'iata_code', $iata); }
    }
    if(!$found){
        $existing = row("SELECT icao_code,iata_code,callsign,country_code FROM airlines WHERE name=? LIMIT 1", [$name]);
        if($existing){ $found = true; apply_updates($existing, $iata, $icao, $callsign, $countryCode, 'icao_code', $existing['icao_code']); }
    }
    if(!$found){
        $existing = row("SELECT icao_code,iata_code,callsign,country_code FROM airlines WHERE name LIKE ? LIMIT 1", ['%'.$name.'%']);
        if($existing){ apply_updates($existing, $iata, $icao, $callsign, $countryCode, 'icao_code', $existing['icao_code']); }
    }

    if($rowCount % 300 === 0) echo "  Processed $rowCount rows...\n";
}

function apply_updates(array $existing, string $iata, string $icao, string $callsign, ?string $countryCode, string $whereCol, $whereVal): void {
    global $updated;
    $sets = []; $params = [];
    $changed = false;

    if(!empty($iata) && (empty($existing['iata_code']) || $existing['iata_code'] === 'n/a')){
        $sets[] = "iata_code=?";
        $params[] = $iata;
        $changed = true;
    }
    if(!empty($icao) && (empty($existing['icao_code']) || $existing['icao_code'] === 'n/a')){
        $sets[] = "icao_code=?";
        $params[] = $icao;
        $changed = true;
    }
    if(!empty($callsign) && (empty($existing['callsign']) || $existing['callsign'] === 'n/a')){
        $sets[] = "callsign=?";
        $params[] = $callsign;
        $changed = true;
    }
    if(!empty($countryCode) && (empty($existing['country_code']) || $existing['country_code'] === 'n/a')){
        $sets[] = "country_code=?";
        $params[] = $countryCode;
        $changed = true;
    }

    if($changed){
        $params[] = $whereVal;
        exec_sql("UPDATE airlines SET ".implode(',',$sets)." WHERE $whereCol=?", $params);
        $updated++;
        echo "  UPDATED: ".($existing['icao_code']??'?')." (".($existing['iata_code']??'?')."/".($existing['icao_code']??'?').") => iata=$iata icao=$icao callsign=$callsign cc=$countryCode\n";
    }
}

function country_to_iso(string $name): ?string {
    static $cache = [];
    if(isset($cache[$name])) return $cache[$name];
    if(empty($name) || $name === 'n/a' || $name === 'Global' || $name === 'APAC') return $cache[$name]=null;

    // Direct lookup in countries table
    try {
        $r = row("SELECT iso_alpha_2 FROM countries WHERE LOWER(name_common)=? OR LOWER(name_official)=? LIMIT 1", [strtolower($name), strtolower($name)]);
        if($r) return $cache[$name]=$r['iso_alpha_2'];
    } catch(Throwable $e){}

    // Try stripping common suffixes
    $clean = preg_replace('/\s*\([^)]*\)/', '', $name);
    $clean = trim(str_replace(['Republic of','Kingdom of','People\'s','Democratic','Federal','Islamic','State of','Union of'], '', $clean));
    if($clean !== $name){
        try {
            $r2 = row("SELECT iso_alpha_2 FROM countries WHERE LOWER(name_common)=? OR LOWER(name_official)=? LIMIT 1", [strtolower($clean), strtolower($clean)]);
            if($r2) return $cache[$name]=$r2['iso_alpha_2'];
        } catch(Throwable $e2){}
    }

    // Hard-coded overrides for common Wikipedia names
    $map = [
        'United States' => 'US', 'USA' => 'US',
        'United Kingdom' => 'GB', 'UK' => 'GB',
        'Russia' => 'RU', 'Russian Federation' => 'RU',
        'UAE' => 'AE', 'United Arab Emirates' => 'AE',
        'Ivory Coast' => 'CI', 'Cote dIvoire' => 'CI',
        'DRC' => 'CD', 'Democratic Republic of the Congo' => 'CD',
        'Republic of the Congo' => 'CG', 'Congo' => 'CG',
        'Netherlands Antilles' => 'AN',
        'Sao Tome and Principe' => 'ST',
        'South Korea' => 'KR', 'North Korea' => 'KP',
        'Vietnam' => 'VN', 'Taiwan' => 'TW',
        'Syria' => 'SY', 'Syrian Arab Republic' => 'SY',
        'Iran' => 'IR', 'Venezuela' => 'VE',
        'Macedonia' => 'MK', 'North Macedonia' => 'MK',
        'Swaziland' => 'SZ', 'Eswatini' => 'SZ',
        'Turkey' => 'TR', 'Turkiye' => 'TR',
        'Myanmar' => 'MM', 'Burma' => 'MM',
        'Laos' => 'LA', 'Brunei' => 'BN',
        'East Timor' => 'TL', 'Timor-Leste' => 'TL',
        'Czech Republic' => 'CZ', 'Czechia' => 'CZ',
        'Cape Verde' => 'CV', 'Cabo Verde' => 'CV',
        'Cote d\'Ivoire' => 'CI',
        'Saint Kitts and Nevis' => 'KN', 'St Kitts and Nevis' => 'KN',
        'St Lucia' => 'LC', 'Saint Lucia' => 'LC',
        'St Vincent and the Grenadines' => 'VC',
        'Gambia' => 'GM', 'The Gambia' => 'GM',
        'Bahamas' => 'BS', 'The Bahamas' => 'BS',
        'Philippines' => 'PH', 'Netherlands' => 'NL',
        'Ivory Coast' => 'CI', 'Republic of Ireland' => 'IE',
        'Macao' => 'MO', 'Macau' => 'MO',
        'Palestine' => 'PS',
        'French Polynesia' => 'PF', 'New Caledonia' => 'NC',
        'Reunion' => 'RE', 'Guadeloupe' => 'GP', 'Martinique' => 'MQ',
        'French Guiana' => 'GF', 'Mayotte' => 'YT',
        'Guam' => 'GU', 'American Samoa' => 'AS',
        'Northern Mariana Islands' => 'MP', 'Puerto Rico' => 'PR',
        'Virgin Islands' => 'VI', 'US Virgin Islands' => 'VI',
        'British Virgin Islands' => 'VG', 'Bermuda' => 'BM',
        'Cayman Islands' => 'KY', 'Turks and Caicos Islands' => 'TC',
        'Anguilla' => 'AI', 'Montserrat' => 'MS',
        'Gibraltar' => 'GI', 'Faroe Islands' => 'FO',
        'Greenland' => 'GL', 'Aland Islands' => 'AX',
        'Svalbard' => 'SJ', 'Jan Mayen' => 'SJ',
        'Cook Islands' => 'CK', 'Niue' => 'NU',
        'Tokelau' => 'TK', 'Wallis and Futuna' => 'WF',
        'Saint Pierre and Miquelon' => 'PM',
        'Saint Helena' => 'SH', 'Christmas Island' => 'CX',
        'Cocos Islands' => 'CC', 'Norfolk Island' => 'NF',
        'Pitcairn Islands' => 'PN', 'South Georgia' => 'GS',
        'British Indian Ocean Territory' => 'IO',
        'Bosnia and Herzegovina' => 'BA', 'Bosnia' => 'BA',
        'Hong Kong' => 'HK', 'South Africa' => 'ZA',
        'Saudi Arabia' => 'SA', 'Sierra Leone' => 'SL',
        'Antigua and Barbuda' => 'AG', 'Antigua' => 'AG',
        'Trinidad and Tobago' => 'TT',
        'Saint Kitts' => 'KN', 'Nevis' => 'KN',
        'Guinea-Bissau' => 'GW', 'Equatorial Guinea' => 'GQ',
        'Central African Republic' => 'CF', 'CAR' => 'CF',
        'Dominican Republic' => 'DO',
        'Moldova' => 'MD', 'Kyrgyzstan' => 'KG',
        'Kazakhstan' => 'KZ', 'Uzbekistan' => 'UZ',
        'Turkmenistan' => 'TM', 'Tajikistan' => 'TJ',
        'Azerbaijan' => 'AZ', 'Armenia' => 'AM', 'Georgia' => 'GE',
        'Mauritania' => 'MR',
    ];
    if(isset($map[$name])) return $cache[$name]=$map[$name];

    return $cache[$name]=null;
}
