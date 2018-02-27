$objIE = new-object -comobject "InternetExplorer.Application"
$objIE.visible = $false

$objIE.Navigate("https://login.yahoo.com/")
while ($objIE.readyState -ne 4) {sleep -Milliseconds 250}

$objIE.Document.getElementById("username").Value = "ElTao"
$objIE.Document.getElementById("passwd").Value = "ElTao"
#$objIE.Document.getElementById(".save").click()

Write-Host $objIE.Document.getElementById("mainBox").innerHTML

$objIE.Quit()
