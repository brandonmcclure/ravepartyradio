<?php
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "s8.myradiostream.com:57132/7.html");
curl_setopt($ch,CURLOPT_USERAGENT,'Mozilla');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
$data = curl_exec($ch);
curl_close($ch);
$data = str_replace('</body></html>', "", $data);
$split = explode(',', $data);
if (empty($data)) {
	$listeners = 0;
} else { 
	if ($split[1] == "0") {
		$listeners = 0;
	} else {
		$listeners = $split[0];
	}
}
echo $listeners;
?>