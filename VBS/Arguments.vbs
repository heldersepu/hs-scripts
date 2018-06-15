' http://www.microsoft.com/technet/scriptcenter/guide/sas_wsh_ywsa.mspx?mfr=true
' Working with arguments

iNum = WScript.Arguments.Count
For I = 0 to iNum -1
	Args = Args & I & " - " & WScript.Arguments.Item(I) & VbCrLf
Next

Wscript.Echo " You Enter " & iNum & " arguments " & VbCrLf & Args 
