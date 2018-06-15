Set oShell  = CreateObject("WScript.Shell")
strZIP = "Zipit_QQ0000000_Data_"
strZIP = strZIP & MonthName(Month(now))
strZIP = strZIP & "_" & Day(now)
strZIP = strZIP & "_" & Year(now)
strZIP = strZIP & "_" & Hour(time)
strZIP = strZIP & "_" & Minute(time)

wscript.sleep 200
oShell.SendKeys "%{TAB}"
oShell.SendKeys "{F2}"
oShell.SendKeys strZIP
