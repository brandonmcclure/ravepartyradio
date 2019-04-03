<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL);

$data = file_get_contents('http://icecast:8000/status-json.xsl');
$json = json_decode($data, true);
$title = $json['icestats']['source'][4]['title'];
echo $title;
?>
