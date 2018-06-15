' Returns the Full pathe to the Desktop folder

set WshShell = CreateObject("WScript.Shell") 
strDesktop = WshShell.SpecialFolders("Desktop")
msgbox strDesktop


