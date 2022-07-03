dCommand = "%comspec% /k SVN update "
dLogFile = "C:\LOG\FLBeta.txt"

ArrFolders = Array( _
"C:\newqq95", _
"C:\NEWQQGA", _
"C:\Quick95", _
"C:\qqfleng", _
"C:\qqtxeng", _
"C:\qqenginems")

Set objShell = CreateObject("WScript.Shell")
Set objFSO   = CreateObject("Scripting.FileSystemObject")

For each dFolder in ArrFolders
    If objFSO.FolderExists(dFolder) Then
        objShell.Run dCommand & dFolder & " >> " & dLogFile
    End If
Next
