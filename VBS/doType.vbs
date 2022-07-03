Set obShell  = CreateObject("WScript.Shell")

wscript.sleep 200
obShell.SendKeys "%{TAB}"

For i = 1 to 20
    Call DoType()
Next
Call msgBox("   All DoNe!!   ")

Sub DoType()
    wscript.sleep 10
    obShell.SendKeys "{F3}"
    wscript.sleep 10
    obShell.SendKeys "{RIGHT}"
    wscript.sleep 10
    obShell.SendKeys "{ENTER}"
End Sub
