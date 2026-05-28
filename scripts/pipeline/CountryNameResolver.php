<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../includes/functions.php';

class CountryNameResolver {
    private static array $overrides = [
        'Côte d\'Ivoire' => 'CI',
        'Cote d\'Ivoire' => 'CI',
        'Congo, the Democratic Republic of the' => 'CD',
        'Congo, Democratic Republic of the' => 'CD',
        'Congo (Democratic Republic)' => 'CD',
        'Congo' => 'CG',
        'Bolivia, Plurinational State of' => 'BO',
        'Bolivia' => 'BO',
        'Iran, Islamic Republic of' => 'IR',
        'Iran' => 'IR',
        'Korea, Democratic People\'s Republic of' => 'KP',
        'North Korea' => 'KP',
        'Korea, Republic of' => 'KR',
        'South Korea' => 'KR',
        'Macedonia, the former Yugoslav Republic of' => 'MK',
        'North Macedonia' => 'MK',
        'Moldova, Republic of' => 'MD',
        'Moldova' => 'MD',
        'Micronesia, Federated States of' => 'FM',
        'Micronesia' => 'FM',
        'Palestine, State of' => 'PS',
        'Palestine' => 'PS',
        'Russia' => 'RU',
        'Russian Federation' => 'RU',
        'Syria' => 'SY',
        'Syrian Arab Republic' => 'SY',
        'Taiwan' => 'TW',
        'Taiwan, Province of China' => 'TW',
        'Tanzania' => 'TZ',
        'Tanzania, United Republic of' => 'TZ',
        'United States' => 'US',
        'USA' => 'US',
        'United Kingdom' => 'GB',
        'Venezuela' => 'VE',
        'Venezuela, Bolivarian Republic of' => 'VE',
        'Vietnam' => 'VN',
        'Viet Nam' => 'VN',
        'Eswatini' => 'SZ',
        'Swaziland' => 'SZ',
        'England' => 'GB-ENG',
        'Scotland' => 'GB-SCT',
        'Wales' => 'GB-WLS',
        'Northern Ireland' => 'GB-NIR',
        'Åland Islands' => 'AX',
    ];

    private static ?array $cache = null;

    public static function resolve(string $countryName): ?string {
        $name = trim($countryName);
        if (isset(self::$overrides[$name])) return self::$overrides[$name];
        $code = self::lookupInDb($name);
        if ($code) return $code;
        $code = self::lookupInDb(self::stripParenthetical($name));
        if ($code) return $code;
        return self::fuzzyLookup($name);
    }

    private static function lookupInDb(string $name): ?string {
        try {
            $r = row('SELECT iso_alpha_2 FROM countries WHERE name_common=? OR name_official=? LIMIT 1', [$name, $name]);
            if ($r) return $r['iso_alpha_2'];
            $r = row('SELECT code FROM legacy_countries WHERE name=? LIMIT 1', [$name]);
            if ($r) return $r['code'];
        } catch (Throwable $e) {}
        return null;
    }

    private static function stripParenthetical(string $name): string {
        return trim(preg_replace('/\s*\(.*?\)\s*/', '', $name));
    }

    private static function fuzzyLookup(string $name): ?string {
        try {
            $rows = rows('SELECT code, name FROM legacy_countries');
            $best = null; $bestScore = 0;
            foreach ($rows as $r) {
                similar_text(strtolower($name), strtolower($r['name']), $pct);
                if ($pct > $bestScore) { $bestScore = $pct; $best = $r['code']; }
            }
            if ($bestScore > 80) return $best;
        } catch (Throwable $e) {}
        return null;
    }
}
