'Get all the DBF in a folder & sort them using Database desktop

Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists("C:\Program Files\Borland\Database Desktop\dbd32.exe") then
	myFolder = ""
	Success  = False
	' Input via Arguments
	If WScript.Arguments.Count > 0 then
		If fso.FolderExists(WScript.Arguments.Item(0)) Then
			myFolder = WScript.Arguments.Item(0)
		Else
			If fso.FileExists(WScript.Arguments.Item(0)) Then
				myFolder = fso.GetParentFolderName(WScript.Arguments.Item(0))
			End If
		End If
	End if
	'Input via Explorer
	If myFolder = "" Then
		Set SA = CreateObject("Shell.Application")
		Set f = SA.BrowseForFolder(0, "Choose a folder", 0, "c:\")
		If (Not f Is Nothing) Then
		    myFolder =  f.Items.Item.Path
		End If
	End If

	If myFolder <> "" Then
		Set FSO = CreateObject("Scripting.FileSystemObject")
		Set oShell  = CreateObject("WScript.Shell")
		'Launch Database Desktop & Wait until is fully loaded
		oShell.Run "dbd32.exe"
		Wscript.Sleep 500
		Do Until Success = True
			Success = oShell.AppActivate("Database Desktop")
			Wscript.Sleep 500
		Loop
		Call ProcFolder(FSO.GetFolder(myFolder))
		'msgbox "All Done"
	End If
End If

'Loop through all the files in the folder
Sub ProcFolder(dFolder)
	For each File in dFolder.Files
		If Ucase(Right(File.Path,4)) = ".DBF" then
			oShell.SendKeys "%+F" 	'File Menu
			Wscript.Sleep 100
			oShell.SendKeys "O"		'Open
			oShell.SendKeys "T"		'Table
			oShell.SendKeys File.Path
			oShell.SendKeys "{ENTER}"
			Wscript.Sleep 200
			oShell.SendKeys "%+A" 	'Table menu
			Wscript.Sleep 100
			oShell.SendKeys "T"		'Restructure

			For I = 0 to 6
				oShell.SendKeys "{DOWN}"
				Wscript.Sleep 10
			Next

			oShell.SendKeys "PIP"
			oShell.SendKeys "%+K" 	'Pack Table
			oShell.SendKeys "%+S" 	'Save
			Wscript.Sleep 200
			oShell.SendKeys "%+F" 	'File Menu
			oShell.SendKeys "%+C" 	'Close table
		End If
	Next
	Wscript.Sleep 1000
	oShell.SendKeys "%{F4}"
End Sub
