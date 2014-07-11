'Print the Ascii code use "Open with Command Prompt"

Set objShell = CreateObject("WScript.Shell")
'Wscript.Sleep 1000
For k = 1 To 255	
	'Wscript.Sleep 10
	Wscript.Echo k & "	" & chr(k)
Next
