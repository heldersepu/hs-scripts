'On Error Resume Next
Set FSO = CreateObject("Scripting.FileSystemObject")

Call procSubFolders(FSO.GetFolder("C:\temp"))
MsgBox " DEL COMPLETE! "


'Loop through all folders
Sub procSubFolders(topFolder)
    For Each subFldr in topFolder.SubFolders
        Call procSubFolders(subFldr)
        If (subFldr.Size = 0) and (subFldr.files.count = 0) then
            fso.DeleteFolder(subFldr.Path)
        End If
    Next
End Sub
