'Find old DBF files that are no longer used

dirDBF = "C:\Quick95\COMPZIPS\"
dirPAS = "C:\Quick95\ALLCOMP\"
Set fso  = CreateObject("Scripting.FileSystemObject")

IF fso.FolderExists(dirDBF) and fso.FolderExists(dirPAS) then
	dFile = dirDBF & "OLD.DIFF"	
	Set outFile = fso.CreateTextFile(dFile, True)
	outFile.writeLine("+++ Begin "  & now)
	Set Fldr = fso.GetFolder(dirDBF)
	cnt = 0
	outFile.writeLine("--- Loading DBF file names from  "  & dirDBF)
	For Each File In Fldr.Files
		lenName = Len(File.Name)
		ucName = Ucase(File.Name)
		If (Right(ucName, 4) = ".DBF") and (lenName <= 8) then
			cnt = cnt + 1
			Redim Preserve arFiles(cnt)
			arFiles(cnt) = Mid(ucName,1,lenName-4)
			outFile.writeLine("+ 	" & cnt & "	" & arFiles(cnt))
		End If
	Next
	If cnt > 0 then
		Set Fldr = fso.GetFolder(dirPAS)
		outFile.writeLine(VbCrLf & "--- Looking in the PAS files for a match "  & dirDBF)
		For Each File In Fldr.Files
			ucName = Ucase(File.Name)
			If ((Len(File.Name) <= 8) and (Right(ucName, 4) = ".PAS") and (Mid(ucName,4,1) <> "I")) then
				If (cnt > 0) Then 
					For I = 1 to cnt
						Set inFile = fso.OpenTextFile(File.Path, 1)
						txtFile = InFile.ReadAll
						inFile.Close
						If (I <= cnt) Then
							If (InStr(txtFile, arFiles(I)) > 0) then
								outFile.writeLine("- " & arFiles(I) & "	->	" & File.Name)
								arFiles(I) = arFiles(cnt)
								If I > 1 then I = I - 1
								cnt = cnt - 1
								Redim Preserve arFiles(cnt)
							End If
						End If						
					Next
				Else
					MsgBox "No Old DBF found"
					Exit For
				End If
			End If
		Next
		outFile.writeLine(VbCrLf & "--- Final Results "  & dirDBF)
		outFile.writeLine("@@ We found " & cnt & " old DBF files " )
		If (cnt > 0) Then 
			For I = 1 to cnt
				outFile.writeLine("@ " & arFiles(I) & ".DBF" )
			Next
		End If
	End If
	outFile.writeLine("--- End "  & now)
	outFile.Close
	Set objShell = CreateObject("WScript.Shell")
	objShell.Run "notepad " & dFile
Else
	MsgBox "Required objects not found"
End If

