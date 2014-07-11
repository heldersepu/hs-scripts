'// Delete old files from given Directory
'//


Set fso = CreateObject("Scripting.FileSystemObject")
iNum = WScript.Arguments.Count
If iNum > 0 Then
	If fso.FolderExists(WScript.Arguments.Item(0)) Then
		Call checkFolder(WScript.Arguments.Item(0))
    Else
        Call msgBox("Directory not found")
	End If
Else
	Call msgBox("You must provide a directory")
End If


Sub checkFolder(directory)
	Set Fldr = fso.GetFolder(directory)
    dtmOld = DateAdd("h", -8, Now)
    dtmVeryOld = DateAdd("d", -5, Now)
    For Each File In Fldr.Files
        If RIGHT(File.Name,4) = ".txt" Then
            If (File.DateCreated < dtmOld) And (File.Size < 120) Then
                fso.DeleteFile(File)
            ElseIf (File.DateCreated < dtmVeryOld) Then
                fso.DeleteFile(File)
            End If
        End If
    Next
End Sub

