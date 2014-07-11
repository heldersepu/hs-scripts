<?php

class FaxOut {

	var $api = "https://service.ringcentral.com/faxapi.asp";
	var $User;	var $Pasw;
	
	function FaxOut($user, $pasw) {
		$this->User = $user;
		$this->Pasw = $pasw;
	}	

	function send($recipient, $covertext, $document) {
		if ($document[0] != "@" )
			$document = "@" . $document;
		$data = array(
			'Username' => $this->User,
			'Password' => $this->Pasw,
			'Recipient' => $recipient,
			'Coverpage' => "None",
			'Coverpagetext' => $covertext,
			'Resolution' => "Low",
			'Attachment' => $document
		);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $this->api);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$headers = array(
			"POST /faxapi.asp HTTP/1.0",
			"Content-type: multipart/form-data"
		);
		curl_setopt($ch, CURLOPT_HEADER, $headers);

		$result = curl_exec($ch);
		curl_close($ch);
		return $result;
	}
}

$fax = new FaxOut("18512347294", "7184123400");

echo "<pre>";
foreach (array("test.docx") as $doc) {
	$result = $fax->send("17112346100", "Sample Fax", $doc);
	echo $result;
	echo "<br>";
}
echo "</pre>";

?>
