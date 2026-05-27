<?php
return [
    'host' => getenv('ANGANI_DB_HOST') ?: '127.0.0.1',
    'port' => getenv('ANGANI_DB_PORT') ?: '3306',
    'database' => getenv('ANGANI_DB_NAME') ?: 'angani_data',
    'username' => getenv('ANGANI_DB_USER') ?: 'root',
    'password' => getenv('ANGANI_DB_PASS') ?: '',
    'charset' => 'utf8mb4',
];
