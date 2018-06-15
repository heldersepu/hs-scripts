Set oShell  = CreateObject("WScript.Shell")
wscript.sleep 3000

FOR I = 1 to 5
    FOR EACH item IN Split("9,{TAB},12,{TAB},13,{TAB},18,{TAB},{TAB},{TAB}", ",")
        wscript.sleep 50
        oShell.SendKeys item
    NEXT
NEXT
