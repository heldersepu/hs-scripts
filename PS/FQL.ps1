$site = Get-SPSite http://nyc-dc1


$kg = New-Object Microsoft.Office.Server.Search.Query.KeywordQuery $site
$kg.ResultTypes = []::RelevantResults