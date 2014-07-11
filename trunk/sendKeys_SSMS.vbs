Set oShell  = CreateObject("WScript.Shell")

wscript.sleep 2000
For i = 1 to 300
    oShell.SendKeys "{F2}"
	wscript.sleep 50
    oShell.SendKeys "^X"
	wscript.sleep 50
    oShell.SendKeys "{ESCAPE}"
	wscript.sleep 50
    oShell.SendKeys "+{F10}"
	wscript.sleep 50
	oShell.SendKeys "S"
	wscript.sleep 50
	oShell.SendKeys "C"
	wscript.sleep 50
    oShell.SendKeys "{DOWN}"
	wscript.sleep 50
    oShell.SendKeys "{ENTER}"
	wscript.sleep 250
    oShell.SendKeys "C:\temp\SQL\"
	wscript.sleep 50
    oShell.SendKeys "^V"
	wscript.sleep 50
    oShell.SendKeys "{ENTER}"
	wscript.sleep 250
    oShell.SendKeys "{DOWN}"
	wscript.sleep 50
next
msgbox "All done"


