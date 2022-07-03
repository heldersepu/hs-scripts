Set fso = CreateObject("Scripting.FileSystemObject")
myFolder = "C:\Public\PDF\DATA"

If myFolder <> "" Then
    Set outFile = fso.CreateTextFile("C:\Public\PDF\ALL_FILES.CSV", True)
	outfile.writeline "TYPE,NAME,SIZE,DATE-CREATED"
    Call ShowSubFolders(FSO.GetFolder(myFolder))
	Call ProcFolder(FSO.GetFolder(myFolder))
    outfile.close
    WSCRIPT.ECHO "All Done"
End If

'Recursively loop through all folders
Sub ShowSubFolders(Folder)
    For Each Subfolder in Folder.SubFolders
        Call ProcFolder(Subfolder)
        outfile.writeline "FOLDER,""" & Subfolder.Path & """," & Subfolder.Size & "," & Subfolder.DateCreated
        ShowSubFolders Subfolder
    Next
End Sub

'Loop through all the files in the folder
Sub ProcFolder(dFolder)
	For Each File In dFolder.Files
		outfile.writeline "FILE,""" & File.Path & """," & File.Size & "," & File.DateCreated
	Next
End Sub
