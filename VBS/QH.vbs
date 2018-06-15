Set oFSO = CreateObject("Scripting.FileSystemObject")

Set oFSO = Nothing

'Delete all files  & folders in a given directory
Sub DeleteAll(sDirectoryPath)
    set oFolder = oFSO.GetFolder(sDirectoryPath)

    For each myFile in oFolder.Files
       myFile.Delete(True)
    Next

    For each myFolder in oFolder.SubFolders
       myFolder.Delete(True)
    Next

    Set oFolder = Nothing
End Sub

'Copy all files & folders in a given directory to another
Sub CopyAll(sourceDirectoryPath, destinDirectoryPath)
    set oFolder = oFSO.GetFolder(sourceDirectoryPath)

    For each myFile in oFolder.Files
       myFile.Copy(destinDirectoryPath, True)
    Next

    For each myFolder in oFolder.SubFolders
       myFolder.Copy(destinDirectoryPath, True)
    Next

    Set oFolder = Nothing
End Sub
