 'Get the Info from all the PAS files
'On Error Resume Next

Set fso = CreateObject("Scripting.FileSystemObject")
myFolder = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	If fso.FolderExists(WScript.Arguments.Item(0)) Then
		myFolder = WScript.Arguments.Item(0)
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
	Set outFile = fso.CreateTextFile(myFolder & "\info.diff", True)
		Call ShowSubFolders(FSO.GetFolder(myFolder))
		Call ProcFolder(FSO.GetFolder(myFolder))
	outFile.Close

	Set objShell = CreateObject("WScript.Shell")
	objShell.Run "notepad " & myFolder & "\info.diff"
	Set objShell = Nothing
End If

'Loop all the lines  in the file
Sub ProcFile(dFile)
	Set inFile 	= fso.OpenTextFile(dFile, 1)
	outFile.WriteLine("@ " & dFile)
	Do until inFile.AtEndOfStream
		dLine = UCase(Trim(inFile.ReadLine))
		If Left(dLine,11) = "BR.CUMPNAME" Then
			dIniPos = InStr(dLine,"'")
			If dIniPos > 0 then
				dIniPos = dIniPos + 1
				dFinPos = InStr(dIniPos, dLine, "'")
				dLine = Trim(Mid(dLine, dIniPos, dFinPos - dIniPos))
				'wscript.Echo dLine & " - " & dIniPos  & " - " & dFinPos
				If dLine <> "" then
					If IsNumeric(Right(dLine,1)) then
						outFile.WriteLine("- " & dLine)
					End If
				End If
			End if
		End if
	Loop
	inFile.Close
End Sub

'Loop through all the files in the folder
Sub ProcFolder(dFolder)
	Wscript.Echo dFolder
	For Each File In dFolder.Files
		regFile = (Ucase(Right(File.Name,4)) = ".PAS") and (Len(File.Name) = 7) and _
				  (Ucase(dFolder) <> "C:\QUICK95\ALLCOMP")
		speFile = (Ucase(Right(File.Name,5)) = "1.PAS") and (Len(File.Name) = 8) and _
				  (Ucase(dFolder) <> "C:\QUICK95\ALLCOMP")
		TxFile  = (Ucase(Right(File.Name,5)) = "I.PAS") and (Len(File.Name) = 8)

		If regFile or speFile or TxFile then ' <- Filter here
			ProcFile(File.Path)
		End If
	Next
End Sub

'Recursively loop through all folders
Sub ShowSubFolders(Folder)
    For Each Subfolder in Folder.SubFolders
		If Subfolder.Attributes = 16 then 'Only regular folders
			Call ProcFolder(Subfolder)'  <- Action here
			ShowSubFolders Subfolder
		End if
    Next
End Sub


