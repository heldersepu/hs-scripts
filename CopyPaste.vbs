Set oShell  = CreateObject("WScript.Shell")

wscript.sleep 500
oShell.SendKeys "%{TAB}"
oShell.SendKeys "^{HOME}"
oShell.SendKeys "{LEFT}"
oShell.SendKeys "{RIGHT}"
oShell.SendKeys "^{INSERT}"  'Copy

wscript.sleep 500
oShell.SendKeys "%{TAB}"
oShell.SendKeys "^{HOME}"
oShell.SendKeys "{DOWN}"
Call doPaste

wscript.sleep 500
oShell.SendKeys "%{TAB}"
oShell.SendKeys "^{INSERT}"  'Copy

wscript.sleep 500
oShell.SendKeys "%{TAB}"
Call doPaste

wscript.sleep 500
oShell.SendKeys "%{TAB}"
oShell.SendKeys "^{INSERT}"  'Copy
Call doPaste

wscript.sleep 500
oShell.SendKeys "{TAB}"
oShell.SendKeys "{TAB}"
oShell.SendKeys "{TAB}"
oShell.SendKeys "{TAB}"
oShell.SendKeys " "


Sub doPaste
	wscript.sleep 500
	oShell.SendKeys "+{INSERT}"	 'Paste
	oShell.SendKeys "{ENTER}" 
	oShell.SendKeys "{DOWN}"
	oShell.SendKeys "{DOWN}"
End Sub
