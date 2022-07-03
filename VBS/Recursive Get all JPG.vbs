'Get all the JPG files bigger than 512K
On Error Resume Next

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
	Set oShell  = CreateObject("WScript.Shell")
	Set outFile = fso.CreateTextFile("C:\allFldr.txt", True)
	Call ShowSubFolders(FSO.GetFolder(myFolder))
	Call ProcFolder(FSO.GetFolder(myFolder))
	outFile.Close
	oShell.Run "Notepad C:\allFldr.txt"
End If

'Recursively loop through all folders
Sub ShowSubFolders(Folder)
    For Each Subfolder in Folder.SubFolders
        Call ProcFolder(Subfolder)'  <- Action here
        ShowSubFolders Subfolder
    Next
End Sub

'Loop through all the files in the folder
Sub ProcFolder(dFolder)
	For Each File In dFolder.Files
		If Ucase(Right(File.Path,4)) = ".JPG" then
			If File.Size > 600000 then
				outFile.WriteLine( chr(34) & File.Path & chr(34) & " 	" & File.Size)
			End If
		End If
	Next
End Sub
