Set FSO = CreateObject("Scripting.FileSystemObject")

Set outFile = FSO.CreateTextFile("C:\TEMP\IMAGES.TAB", True)
outfile.writeline "FolderName" & vbTAB & "Size"
Set outFileCNV = FSO.CreateTextFile("C:\TEMP\IMAGESCNV.TAB", True)
outFileCNV.writeline "FolderName" & vbTAB & "Size"

'Call procSubFolders(FSO.GetFolder("R:\"))
Call procSubFolders(FSO.GetFolder("C:\temp"))
outFileCNV.close
outFile.close
MsgBox " FILE LOG COMPLETE! "


'Loop through all folders
Sub procSubFolders(topFolder)
    For Each subFldr in topFolder.SubFolders
        fldName = UCase(Left(subFldr.Name,2))
        If fldName = "QQ" Then
            Set qqFolder = FSO.GetFolder(subFldr.Path)
            outfile.writeline qqFolder.Path & vbTAB & qqFolder.Size
            If FSO.FolderExists(subFldr.Path & "\Converted") Then
                Set cnvFolder = FSO.GetFolder(subFldr.Path & "\Converted")
                outFileCNV.writeline cnvFolder.Path & vbTAB & cnvFolder.Size
            End If
        ElseIF (fldName = "TP" or fldName = "SP") Then
            Call procSubFolders(subFldr)
        End If
    Next
End Sub
