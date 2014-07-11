'Recursively check drive C: for PAS files Ouput all files into "allPAS.txt"

On Error Resume Next '//Just in case

Set FSO 	= CreateObject("Scripting.FileSystemObject")
Set objShell    = CreateObject("WScript.Shell")

Set outFile 	= fso.CreateTextFile("C:\allPAS.txt", True)
ShowSubFolders FSO.GetFolder("C:\")
outFile.Close
objShell.Run "notepad.exe C:\allPAS.txt"

Sub ShowSubFolders(Folder)
    For Each Subfolder in Folder.SubFolders
		For Each File In Subfolder.Files
			If (UCase(fso.GetExtensionName(file)) = "PAS") then
				outFile.WriteLine( file )	
			end if 
			
		Next
        ShowSubFolders Subfolder
    Next
End Sub