$servers = @("work01","workAA")
Write-Host $servers
$Test = @("Test01","TEST02")
Write-Host $Test
$Test2 = @("11111","22222")
Write-Host $Test2



#initialise the Array
$NewArray =  @()

# Add the arrays
$NewArray = $NewArray + $servers
Write-Host " Items in  NewArray = " $NewArray.count  -ForegroundColor Red
For($i = 0;$i -lt $NewArray.count;$i++)
{
    Write-Host $NewArray[$i] -ForegroundColor Blue
}

$NewArray = $NewArray + $Test
Write-Host " Items in  NewArray = " $NewArray.count  -ForegroundColor Red
For($i = 0;$i -lt $NewArray.count;$i++)
{
    Write-Host $NewArray[$i] -ForegroundColor Blue
}

$NewArray = $NewArray + $Test2
Write-Host " Items in  NewArray = " $NewArray.count  -ForegroundColor Red
For($i = 0;$i -lt $NewArray.count;$i++)
{
    Write-Host $NewArray[$i] -ForegroundColor Blue
}