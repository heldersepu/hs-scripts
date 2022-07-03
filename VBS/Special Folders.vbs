' Returns all the Special Folders

set WshShell = WScript.CreateObject("WScript.Shell")
For I = 1 to 17
    strSF = strSF & VbCrLf & I & " - " & WshShell.SpecialFolders(I)
Next
msgbox  "SpecialFolders(I)" & VbCrLf & strSF

strSF = ""

Set filesys = CreateObject("Scripting.FileSystemObject")
For I = 0 to 2
    strSF = strSF & VbCrLf & I & " - " & filesys.GetSpecialFolder(I)
Next
msgbox  "SpecialFolders(I)" & VbCrLf & strSF
