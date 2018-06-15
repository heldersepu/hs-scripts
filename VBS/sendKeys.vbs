Set oShell  = CreateObject("WScript.Shell")
wscript.sleep 5000

Do
	for i = 1 to 10
		oShell.SendKeys "{DOWN}"
		wscript.sleep 50
		oShell.SendKeys " "
		wscript.sleep 100
	next
	result = MsgBox("Do you want to continue?",vbYesNo,"Continue Processing")
Loop Until (result = vbNo)


