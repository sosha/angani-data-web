<?php
// Compare DB country codes with CSV filenames

// Hardcoded from remote query result
$dbCodes = ['AE','AG','AI','AL','AM','AO','AR','AS','AT','AU','AW','AZ','BA','BB','BD','BE','BF','BG','BH','BI','BJ','BM','BN','BO','BR','BS','BT','BW','BY','BZ','CA','CD','CF','CG','CH','CI','CK','CL','CM','CN','CO','CR','CU','CV','CY','CZ','DE','DJ','DK','DO','DZ','EC','EE','EG','ER','ES','ET','FI','FJ','FO','FR','GA','GB','GE','GF','GH','GL','GLOBAL','GM','GN','GP','GQ','GR','GT','GU','GW','GY','HK','HN','HR','HT','HU','ID','IE','IL','IN','IQ','IR','IS','IT','JM','JO','JP','KE','KG','KH','KI','KM','KN','KP','KR','KW','KY','KZ','LA','LB','LC','LK','LR','LS','LT','LU','LV','LY','MA','MC','MD','ME','MG','MH','MK','ML','MM','MN','MO','MP','MQ','MR','MS','MT','MU','MV','MW','MX','MY','MZ','NA','NC','NE','NF','NG','NI','NL','NO','NP','NR','NU','NZ','OM','PA','PE','PF','PG','PH','PK','PL','PM','PR','PT','PW','PY','QA','RE','RO','RS','RU','RW','SA','SB','SC','SD','SE','SG','SH','SI','SK','SL','SM','SN','SO','SR','SS','ST','SV','SX','SY','SZ','TC','TD','TG','TH','TJ','TL','TM','TN','TO','TR','TT','TV','TW','TZ','UA','UG','US','UY','UZ','VC','VE','VG','VI','VN','VU','WS','YE','YT','ZA','ZM','ZW'];
sort($dbCodes);

echo "DB country codes: " . count($dbCodes) . "\n";

// Read all filenames — try local path, then remote data dir, then CLI arg
$csvDir = $argv[1] ?? (is_dir(__DIR__ . '/../../RAW/airlines_by_country') ? __DIR__ . '/../../RAW/airlines_by_country' : (is_dir(__DIR__ . '/../data/airlines_by_country') ? __DIR__ . '/../data/airlines_by_country' : null));
if (!$csvDir) { echo "ERROR: Cannot find CSV directory. Pass it as argument.\n"; exit(1); }
$files = glob($csvDir . '/*.csv');
$fileBasenames = array_map(fn($f) => str_replace('.csv', '', basename($f)), $files);

// Filename → country code mapping (same logic as merge script)
$overrides = [
    'usa' => 'US', 'united states' => 'US',
    'uk' => 'GB', 'great britain' => 'GB',
    'uae' => 'AE',
    'türkiye' => 'TR', 'turkiye' => 'TR',
    'trkiye' => 'TR',
    'czechia' => 'CZ', 'czech republic' => 'CZ',
    "cote d'ivoire" => 'CI', 'cote divoire' => 'CI',
    'réunion' => 'RE', 'reunion' => 'RE',
    'palestinian territory' => 'PS', 'palestine' => 'PS',
    'bosnia and herzegovina' => 'BA',
    'timor-leste' => 'TL',
    'viet nam' => 'VN', 'vietnam' => 'VN',
    'venezuela (bolivarian republic of)' => 'VE',
    'korea (republic of)' => 'KR', 'south korea' => 'KR',
    'korea (democratic people\'s republic of)' => 'KP', 'north korea' => 'KP',
    'iran (islamic republic of)' => 'IR',
    'moldova (republic of)' => 'MD',
    'syrian arab republic' => 'SY',
    'tanzania (united republic of)' => 'TZ',
    'lao people\'s democratic republic' => 'LA',
    'russian federation' => 'RU',
    'congo (the democratic republic of the)' => 'CD', 'congo (kinshasa)' => 'CD',
    'congo (brazzaville)' => 'CG',
    'north macedonia' => 'MK',
    'netherlands antilles' => 'AN',
    'saint kitts and nevis' => 'KN',
    'saint lucia' => 'LC',
    'saint vincent and the grenadines' => 'VC',
    'saint pierre and miquelon' => 'PM',
    'saint helena' => 'SH',
    'sao tome and principe' => 'ST',
    'trinidad and tobago' => 'TT',
    'turks and caicos islands' => 'TC',
    'virgin islands british' => 'VG',
    'virgin islands us' => 'VI',
    'american samoa' => 'AS',
    'french polynesia' => 'PF',
    'french guiana' => 'GF',
    'cayman islands' => 'KY',
    'cook islands' => 'CK',
    'faroe islands' => 'FO',
    'northern mariana islands' => 'MP',
    'marshall islands' => 'MH',
    'solomon islands' => 'SB',
    'guinea-bissau' => 'GW',
    'equatorial guinea' => 'GQ',
    'central african republic' => 'CF',
    'democratic republic of the congo' => 'CD',
    'congo the democratic republic of the' => 'CD',
    'papua new guinea' => 'PG',
    'south sudan' => 'SS',
    'sierra leone' => 'SL',
    'brunei darussalam' => 'BN',
    'antigua and barbuda' => 'AG',
    'bosnia and herzegovina' => 'BA',
    'cape verde' => 'CV',
    'dominican republic' => 'DO',
    'el salvador' => 'SV',
    'hong kong' => 'HK',
    'new caledonia' => 'NC',
    'sint maarten' => 'SX',
    'sri lanka' => 'LK',
    'swaziland' => 'SZ',
    'macao' => 'MO',
    'norfolk island' => 'NF',
    'palestinian territory occupied' => 'PS',
    'puerto rico' => 'PR',
    'south africa' => 'ZA',
    'new zealand' => 'NZ',
    'saudi arabia' => 'SA',
    'sierra leone' => 'SL',
    'costa rica' => 'CR',
    'burkina faso' => 'BF',
    'moldova republic of' => 'MD',
];

$fileCodes = [];
foreach ($fileBasenames as $basename) {
    $name = str_replace('_', ' ', $basename);
    $key = strtolower(trim($name));
    
    $code = $overrides[$key] ?? null;
    if (!$code) {
        // Try direct country name lookup via common names
        $common = [
            'albania' => 'AL', 'algeria' => 'DZ', 'angola' => 'AO', 'argentina' => 'AR',
            'armenia' => 'AM', 'aruba' => 'AW', 'australia' => 'AU', 'austria' => 'AT',
            'azerbaijan' => 'AZ', 'bahamas' => 'BS', 'bahrain' => 'BH', 'bangladesh' => 'BD',
            'barbados' => 'BB', 'belarus' => 'BY', 'belgium' => 'BE', 'belize' => 'BZ',
            'benin' => 'BJ', 'bermuda' => 'BM', 'bhutan' => 'BT', 'bolivia' => 'BO',
            'botswana' => 'BW', 'brazil' => 'BR', 'bulgaria' => 'BG', 'burundi' => 'BI',
            'cambodia' => 'KH', 'cameroon' => 'CM', 'canada' => 'CA', 'chad' => 'TD',
            'chile' => 'CL', 'china' => 'CN', 'colombia' => 'CO', 'comoros' => 'KM',
            'congo' => 'CG', 'croatia' => 'HR', 'cuba' => 'CU', 'cyprus' => 'CY',
            'denmark' => 'DK', 'djibouti' => 'DJ', 'ecuador' => 'EC', 'egypt' => 'EG',
            'eritrea' => 'ER', 'estonia' => 'EE', 'ethiopia' => 'ET', 'fiji' => 'FJ',
            'finland' => 'FI', 'france' => 'FR', 'gabon' => 'GA', 'gambia' => 'GM',
            'georgia' => 'GE', 'germany' => 'DE', 'ghana' => 'GH', 'greece' => 'GR',
            'greenland' => 'GL', 'guadeloupe' => 'GP', 'guam' => 'GU', 'guatemala' => 'GT',
            'guinea' => 'GN', 'guyana' => 'GY', 'haiti' => 'HT', 'honduras' => 'HN',
            'hungary' => 'HU', 'iceland' => 'IS', 'india' => 'IN', 'indonesia' => 'ID',
            'iraq' => 'IQ', 'ireland' => 'IE', 'israel' => 'IL', 'italy' => 'IT',
            'jamaica' => 'JM', 'japan' => 'JP', 'jordan' => 'JO', 'kazakhstan' => 'KZ',
            'kenya' => 'KE', 'kiribati' => 'KI', 'kuwait' => 'KW', 'kyrgyzstan' => 'KG',
            'laos' => 'LA', 'latvia' => 'LV', 'lebanon' => 'LB', 'lesotho' => 'LS',
            'liberia' => 'LR', 'libya' => 'LY', 'lithuania' => 'LT', 'luxembourg' => 'LU',
            'madagascar' => 'MG', 'malawi' => 'MW', 'malaysia' => 'MY', 'maldives' => 'MV',
            'mali' => 'ML', 'malta' => 'MT', 'martinique' => 'MQ', 'mauritania' => 'MR',
            'mauritius' => 'MU', 'mayotte' => 'YT', 'mexico' => 'MX', 'monaco' => 'MC',
            'mongolia' => 'MN', 'montenegro' => 'ME', 'montserrat' => 'MS', 'morocco' => 'MA',
            'mozambique' => 'MZ', 'myanmar' => 'MM', 'namibia' => 'NA', 'nauru' => 'NR',
            'nepal' => 'NP', 'netherlands' => 'NL', 'nicaragua' => 'NI', 'niger' => 'NE',
            'nigeria' => 'NG', 'niue' => 'NU', 'norway' => 'NO', 'oman' => 'OM',
            'pakistan' => 'PK', 'palau' => 'PW', 'panama' => 'PA', 'paraguay' => 'PY',
            'peru' => 'PE', 'philippines' => 'PH', 'poland' => 'PL', 'portugal' => 'PT',
            'qatar' => 'QA', 'romania' => 'RO', 'rwanda' => 'RW', 'samoa' => 'WS',
            'san marino' => 'SM', 'senegal' => 'SN', 'serbia' => 'RS', 'seychelles' => 'SC',
            'singapore' => 'SG', 'slovakia' => 'SK', 'slovenia' => 'SI', 'somalia' => 'SO',
            'spain' => 'ES', 'sudan' => 'SD', 'suriname' => 'SR', 'sweden' => 'SE',
            'switzerland' => 'CH', 'taiwan' => 'TW', 'tajikistan' => 'TJ', 'thailand' => 'TH',
            'togo' => 'TG', 'tonga' => 'TO', 'tunisia' => 'TN', 'turkmenistan' => 'TM',
            'tuvalu' => 'TV', 'uganda' => 'UG', 'ukraine' => 'UA', 'uruguay' => 'UY',
            'uzbekistan' => 'UZ', 'vanuatu' => 'VU', 'venezuela' => 'VE', 'yemen' => 'YE',
            'zambia' => 'ZM', 'zimbabwe' => 'ZW',
        ];
        $code = $common[$key] ?? null;
    }
    
    if ($code) {
        $fileCodes[] = $code;
    } else {
        echo "WARNING: No mapping for $basename ($key)\n";
    }
}

$fileCodes = array_unique($fileCodes);
sort($fileCodes);

echo "\nCSV file country codes: " . count($fileCodes) . "\n";

$missing = array_diff($dbCodes, $fileCodes);
$extra = array_diff($fileCodes, $dbCodes);

echo "\n=== COUNTRIES IN DB BUT NOT IN CSV FILES ===\n";
if (empty($missing)) {
    echo "(none)\n";
} else {
    foreach ($missing as $c) {
        echo "  $c\n";
    }
}

echo "\n=== COUNTRIES IN CSV FILES BUT NOT IN DB ===\n";
if (empty($extra)) {
    echo "(none)\n";
} else {
    foreach ($extra as $c) {
        echo "  $c\n";
    }
}
