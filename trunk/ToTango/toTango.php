<?php

$API_KEY = "294281578d23199c82023f20a57293e93bfce260";

echo "<h2> calling Totango API </h2>";
$res = totangoActiveListCurrent($API_KEY, 0);

if ($res == null) {
	echo "<h1> invalid API response. Please make sure you are using a valid API KEY </h1> ";
} else if ($res->_error) {
	echo  "<h1> error fetching list: {$res->_error}  </h1>";
} else {
	echo "$res->total_items <br>";
	echo "$res->current_item_count <br>";
	echo "$res->accounts <br>";
}

function totangoActiveListCurrent($API_KEY, $page, $pageLength = 100) {
    $url = "https://app.totango.com/api/v1/accounts/active_list/1/current.json";
	$ch = curl_init();
    curl_setopt($ch, CURLOPT_HTTPHEADER, array("Authorization: $API_KEY"));
    curl_setopt($ch, CURLOPT_URL, $url . "?length=$pageLength&offset=$page&return=$returnType");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $res = curl_exec($ch);
    $resObj = json_decode($res);
    return $resObj;
}

?>
