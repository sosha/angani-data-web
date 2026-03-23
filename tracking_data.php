<?php
require_once 'db.php';

// OpenSky API Proxy
// Documentation: https://openskynetwork.github.io/opensky-api/rest.html

// Regional Bounding Box (East Africa area)
// lamin, lomin, lamax, lomax
$lamin = -15.0; // Southern Tanzania / Malawi
$lomin = 20.0;  // DR Congo
$lamax = 15.0;  // Ethiopia / Sudan
$lomax = 52.0;  // Somalia / Indian Ocean

$url = "https://opensky-network.org/api/states/all?lamin=$lamin&lomin=$lomin&lamax=$lamax&lomax=$lomax";

header('Content-Type: application/json');

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 10);
curl_setopt($ch, CURLOPT_USERAGENT, 'AnganiData/1.0 (Open Source Aviation Project)');

// Use authentication if provided (Optional, increases quota)
// curl_setopt($ch, CURLOPT_USERPWD, "username:password");

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($httpCode === 200) {
    echo $response;
} else {
    echo json_encode(['error' => 'Failed to fetch tracking data', 'code' => $httpCode]);
}
