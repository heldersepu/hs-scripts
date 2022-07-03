Set objFSO = CreateObject("Scripting.FileSystemObject")

CALL deleteBigFiles("E:\GeoCoder\request")
CALL deleteBigFiles("E:\GeoCoder\response")

Sub deleteBigFiles(strFolder)
    Set objFolder = objFSO.GetFolder(strFolder)
    Set colFiles = objFolder.Files
    For Each objFile in colFiles
        If (objFile.Size > 40000000) Then
            CALL objFSO.DeleteFile(objFile)
        End If
    Next
End Sub
