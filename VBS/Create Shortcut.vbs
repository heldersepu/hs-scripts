' // Create a Notepad Link on the desktop

Set WshShell = WScript.CreateObject("WScript.Shell")
strDesktop   = WshShell.SpecialFolders("Desktop")
Set oShLink  = WshShell.CreateShortcut(strDesktop & "\YourShortcut.lnk")
' Make the Icon the Internet Explorer
'oShLink.IconLocation = "%SystemRoot%\system32\SHELL32.dll, 220"
oShLink.IconLocation = "%SystemRoot%\system32\SHELL32.dll, 219"
oShLink.TargetPath = "C:\WINDOWS\notepad.exe"
oShLink.Save
