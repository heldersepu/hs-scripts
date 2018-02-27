' // Extract CAB files using expand.exe
Set fso  = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

myFile = "QQTX.cab"
Extract(myFile)
Msgbox "Done"

Sub Extract(dFile)
	Success = True
	If fso.FileExists(dFile) Then
		' //  Delete the folder if it exist & Recreate it
		dFolder = Left(dFile,len(dFile)-4)
		If fso.FolderExists(dFolder) Then
			fso.DeleteFolder(dFolder)
		End If
		fso.CreateFolder(dFolder)
		' //Extract all the files from the Cab file into the Folder
		WshShell.Run "expand -F:* """ & dFile & """ """ & dFolder & """"

		' // Wait until Job is done
		Do Until Success = False
			Wscript.Sleep 1000
			Success = objShell.AppActivate("C:\WINDOWS\system32\expand.exe")
		Loop
	End If
End Sub
