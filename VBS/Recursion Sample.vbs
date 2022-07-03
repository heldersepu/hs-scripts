'Recursively loop through all folders in drive C: and Ouput all folders into "allFldr.txt"

On Error Resume Next

strFile = "C:\allFldr.txt"

Set FSO = CreateObject("Scripting.FileSystemObject")
Set oShell  = CreateObject("WScript.Shell")
Set outFile	= fso.CreateTextFile(strFile, True)
call ShowSubFolders(FSO.GetFolder("C:\Windows"))
outFile.Close
oShell.Run "Notepad " & strFile

Sub ShowSubFolders(Folder)
    For Each Subfolder in Folder.SubFolders
			outFile.WriteLine( Subfolder.Path ) '  <- Action here
        Call ShowSubFolders(Subfolder)
    Next
End Sub
