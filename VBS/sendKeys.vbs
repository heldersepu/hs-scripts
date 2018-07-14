Set oShell  = CreateObject("WScript.Shell")
wscript.sleep 5000

Do
	for i = 1 to 200
		oShell.SendKeys "G" + String((i Mod 12)+1, "o") + "l"
		wscript.sleep 10
		oShell.SendKeys "{ENTER}"
		wscript.sleep 50
	next
	result = MsgBox("Do you want to continue?", vbYesNo, "Continue Processing")
Loop Until (result = vbNo)


