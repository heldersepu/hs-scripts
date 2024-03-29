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
		Do Until Success = True
			Success = oShell.AppActivate("Database Desktop")
			Wscript.Sleep 100
		Loop
		Call ProcFolder(FSO.GetFolder(myFolder))
		'msgbox "All Done"
	End If
End If

'Loop through all the files in the folder
Sub ProcFolder(dFolder)
	For each File in dFolder.Files
		If Ucase(Right(File.Path,4)) = ".DBF" then
			Wscript.Sleep 100
			oShell.SendKeys "%+T"
			oShell.SendKeys "U"
			oShell.SendKeys "S"
			oShell.SendKeys File.Path
			oShell.SendKeys "{TAB}"
			oShell.SendKeys "{TAB}"
			oShell.SendKeys "{ENTER}"
			Wscript.Sleep 100
			'Sort 5 Fields
			For I = 1 to 5
				oShell.SendKeys "{TAB}"
				oShell.SendKeys "{ENTER}"
			Next
			oShell.SendKeys "{ENTER}"
		End If
	Next
	Wscript.Sleep 1000
	oShell.SendKeys "%{F4}"
End Sub
