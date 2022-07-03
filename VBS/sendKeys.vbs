Set oShell  = CreateObject("WScript.Shell")
wscript.sleep 5000

Do
	for i = 1 to 200
        gol = "G" + String((i Mod 12)+1, "O") + "L"
        x = "```" + String((i Mod 5)+4, " ") + gol + String((i Mod 7)+4, " ") + "```"
		oShell.SendKeys x
		wscript.sleep 10
		oShell.SendKeys "{ENTER}"
		wscript.sleep 50

        oShell.SendKeys "*" + gol + "*"
		wscript.sleep 10
		oShell.SendKeys "{ENTER}"
		wscript.sleep 50
	next
	result = MsgBox("Do you want to continue?", vbYesNo, "Continue Processing")
Loop Until (result = vbNo)


