Set oShell  = CreateObject("WScript.Shell")
'Open Notepad
oShell.Run "notepad"
'Create 1 sec delay
wscript.sleep 1000

'send some keystrokes 
oShell.SendKeys "TERR"
oShell.SendKeys "{ENTER}"
oShell.SendKeys " - A.B, C;DE"
oShell.SendKeys "{ENTER}"
oShell.SendKeys "{ENTER}"

'wscript.sleep 2000
msgbox "type triangle"
'Draw a "Triangle"
for i = 1 to 10
  for j = 1 to i
    oShell.SendKeys "*"
  next
  oShell.SendKeys "{ENTER}"
next
oShell.SendKeys "{ENTER}"

'wscript.sleep 200
msgbox "type Numbers"
'Output #  1..10 separated by Tabs
for i = 1 to 10
  oShell.SendKeys i
  oShell.SendKeys "{TAB}"
next
oShell.SendKeys "{ENTER}"
