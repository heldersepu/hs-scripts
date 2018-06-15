'// Add Right Click context menu to pass Arguments
'// Context menu will be added to .vbs & .lnk files

On Error Resume Next
Set objShell = CreateObject("WScript.Shell")
Set fso  	 = CreateObject("Scripting.FileSystemObject")

' Array with all the extensions to add the Context Menu
ExtArray = Array("lnk", "vbs")
' Path to the executable script
dFile = Wscript.Path & "\VBSargs.vbs"
' Info to write in the registry 
RegProg = "wscript " & dFile & " ""%1"""
' Name of the context menu item 
DiName = "Inject Arguments"

If Not fso.FileExists(dFile) then
 ' Self Copy the script to c:\windows\system32\
	fso.CopyFile wscript.ScriptName,  dFile, true
 ' Register the files 
	For Each dExt In ExtArray
		DllReg  = "HKCR\" & dExt & "file\shell\Args\"
		objShell.RegWrite DllReg , DiName
		objShell.RegWrite DllReg & "command\" , RegProg
	Next
Else
	If WScript.Arguments.Count > 0  Then
		temp = Trim(WScript.Arguments.Item(0))
		If UCase(right(temp,4)) = ".LNK" Then
		' get the ShortCut Target 
			Set oShLink  = objShell.CreateShortcut(temp)
			temp = oShLink.TargetPath
			Set oShLink = Nothing
		Else
			If UCase(right(temp,4)) = ".VBS" Then
				temp = "wscript """ & temp & """"
			End If 
		End If		

		dArgs = InputBox ("Enter Arguments", DiName)
		objShell.Run temp & " " & dArgs
	Else
		objShell.Run "notepad.exe " & dFile
	End If
End If
