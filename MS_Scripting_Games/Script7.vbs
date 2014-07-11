Set objFSO = CreateObject("Scripting.FileSystemObject")'missing scripting.
Set objFolder = objFSO.GetFolder("C:\scripts")

dtmOld = DateAdd("d", -10, Now):i = 0 'should be day  not month & 'Initalize the Counter

AllFolders objFolder 

CopyTextFiles objFolder

Sub AllFolders(Folder)'parententis missing
    For Each dFolder in Folder.SubFolders ' use local variable

        CopyTextFiles dFolder  ' using local variable
        AllFolders dFolder     

    Next
End Sub


Sub CopyTextFiles(subFolder)

    Set colFiles = SubFolder.Files ' Need to "Set"

    For Each objFile in colFiles
        arrSplitName = Split(objFile.Name, ".")
        strExtension = arrSplitName(UBound(arrSplitName))'Get last item
        'Change > to < 
		If strExtension = "txt" and objFile.DateCreated < dtmOld Then 
            objFSO.CopyFile objFile.Path, "C:\old\"
            Wscript.Echo objFile.Name
            i = i + 1
        End If ' misspelled end 
    Next

End Sub ' missing Sub

Wscript.Echo
Wscript.Echo "Total Files: " & i
