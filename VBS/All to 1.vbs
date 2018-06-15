
Set fso = CreateObject("Scripting.FileSystemObject")
' Input via Arguments
If WScript.Arguments.Count > 0 then
	'Create file	
	iniFile = WScript.Arguments.Item(0) & "_ALL.TXT"
	Set outFile = fso.CreateTextFile(iniFile, True)
	outFile.close
	
	For I = 0 to WScript.Arguments.Count - 1		
		dFile = WScript.Arguments.Item(I)
		If fso.FileExists(dFile) and (Ucase(Right(dFile,4)) = ".TXT") Then
			'Open file for appending
			Set outFile = fso.OpenTextFile(iniFile, 8)
			'ReadAll file
			Set inFile 	= fso.OpenTextFile(dFile, 1)
			'write all the info to the file
			outfile.writeline inFile.ReadAll
			outfile.close
			inFile.close
		End if		
	Next
Else
	Wscript.Echo "Pass Files in the Arguments"
End If
