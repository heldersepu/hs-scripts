' Get all the Icons from the Desktop and Putput all the info in a File LNK.TXT

Set objFSO   = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

strDesktop   = objShell.SpecialFolders("Desktop")
Set Fldr     = objFSO.GetFolder(strDesktop)
Set outFile  = objFSO.CreateTextFile(strDesktop & "\LNK.TXT", True)

For Each File In Fldr.Files
	If UCase(Right(File,4))= ".LNK"  then
		outFile.Writeline(File)
		Set oShLink  = objShell.CreateShortcut(File)
		outFile.Writeline("IconLocation - " & oShLink.IconLocation)
		outFile.Writeline("TargetPath   - " & oShLink.TargetPath)
		Set oShLink = Nothing
		
		Set inFile 	= objFSO.OpenTextFile(File, 1)
		Do until inFile.AtEndOfStream
			ThisLine = inFile.ReadLine
			outFile.Writeline("-> " & ThisLine)
		Loop
		inFile.Close

		outFile.Writeline(" ")
		outFile.Writeline(" <---------**********---------> ")
		outFile.Writeline(" ")
	End If
Next
outFile.Close
