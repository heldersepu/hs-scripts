$o = Get-ChildItem C:\windows\notepad.exe
$o | Get-Member

$o | Add-Member -type noteProperty -name ServerName -value "MyServer"
$o | Get-Member
