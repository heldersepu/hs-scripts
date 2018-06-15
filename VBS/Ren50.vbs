'Rename ALL .RTF files be no more than 50 chars
'On Error Resume Next

Set fso = CreateObject("Scripting.FileSystemObject")
myFolder = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	If fso.FolderExists(WScript.Arguments.Item(0)) Then
		myFolder = WScript.Arguments.Item(0)
		Call ShowSubFolders(FSO.GetFolder(myFolder))
	End If
End if


'Recursively loop through all folders
Sub ShowSubFolders(Folder)
    For Each Subfolder in Folder.SubFolders
		Call ShowSubFolders(Subfolder)
    Next
	Call ProcFolder(Folder)
End Sub

'Loop through all the files in the folder
Sub ProcFolder(dFolder)
	For Each File In dFolder.Files
		If UCase(Right(File.Path,4)) = ".RTF" then
			If Len(File.Name) > 45 then
				i = 1
				strFileName = Right(File.Name, 45)
				Do While fso.FileExists(File.ParentFolder & "\" & strFileName)
					strFileName = Cstr(i) & Right(File.Name, 45)
					i = i + 1
				Loop
				Call File.Move(File.ParentFolder & "\" & strFileName)
			End If
		End If
	Next
End Sub
