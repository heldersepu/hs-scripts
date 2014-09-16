Add-PSSnapin "Microsoft.SharePoint.PowerShell"
 
$site = Get-SPSite http://nyc-dc1


$kg = New-Object Microsoft.Office.Server.Search.Query.KeywordQuery $site
$kg.ResultTypes = [Microsoft.Office.Server.Search.Query.ResultType]::RelevantResults

$kg.RowLimit = 5
$kg.EnableFQL = 1
$kg.QueryText = "cat"

$resTC = $kg.Execute()

Write-Host Total Hits: $resTC[1].TotalRows

$rTab = $resTC.Item([Microsoft.Office.Server.Search.Query.ResultType]::RelevantResults)
$relDataTable = $rTab.Table
$relDataTable | Format-Table -AutoSize -Property title, url

