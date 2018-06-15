' List some services

'Array with the names of the services
arrNames = Array("w32time", "Alerter", "CiSVC")

Set objWMISrv = GetObject("winmgmts:!\\.\root\cimv2")
'Concatenate the query string
strQuery = "Select * from Win32_Service where"
For Each item In arrNames
    strQuery = strQuery & " Name='" & item & "' or "
Next
Set colServ   = objWMISrv.ExecQuery (Left(strQuery,Len(strQuery)-3))

dMsg = "DisplayName    Name    StartMode" & VbCrLf
For Each objServ in colServ
	dMsg = dMsg & objServ.DisplayName & "   " & objServ.Name & "    " & objServ.StartMode & VbCrLf 
Next

Wscript.Echo dMsg
