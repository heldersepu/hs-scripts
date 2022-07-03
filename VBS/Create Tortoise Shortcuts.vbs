' // Create Links to TortoiseProc.exe

Set fso  = CreateObject("Scripting.FileSystemObject")
TortProc = "C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe"

If fso.FileExists(TortProc) then

	Set WshShell = WScript.CreateObject("WScript.Shell")
	'strFolder    = WshShell.SpecialFolders("Desktop")
	strFolder    = Wscript.Path
	strCommon    = "/command:repostatus /path:"  & Chr(34)

	Set oShLink  = WshShell.CreateShortcut(strFolder & "\TFL.lnk")
	oShLink.TargetPath = TortProc
	oShLink.Arguments = strCommon & "C:\NEWQQ95" & Chr(34)
	oShLink.Save

	Set oShLink  = WshShell.CreateShortcut(strFolder & "\TGA.lnk")
	oShLink.TargetPath = TortProc
	oShLink.Arguments = strCommon & "C:\NEWQQGA" & Chr(34)
	oShLink.Save

	Set oShLink  = WshShell.CreateShortcut(strFolder & "\TTX.lnk")
	oShLink.TargetPath = TortProc
	oShLink.Arguments = strCommon & "C:\QUICK95" & Chr(34)
	oShLink.Save

Else
		MsgBox "File not found " & VbCrLf & TortProc
End If

'"C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:repostatus /path:"C:\Quick95"
'"C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:repostatus /path:"C:\NEWQQ95"
