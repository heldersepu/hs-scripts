'Check DBF without corresponding PAS file

dir2 = "C:\Quick95\COMPZIPS\"
dir1 = "C:\Quick95\ALLCOMP\"
Set fso  = CreateObject("Scripting.FileSystemObject")

IF fso.FolderExists(dir1) and fso.FolderExists(dir2) then
	Set objShell = CreateObject("WScript.Shell")
	strOutFile = objShell.SpecialFolders("Desktop") & "\DelOld.bat"

	'Read Files form first Directory & put in Array
	cnt = 0
	Set Fldr = fso.GetFolder(dir1)
	For Each File In Fldr.Files
		dbFile = Ucase(File.Name)
		LendbFile = Len(dbFile)
		If (Right(dbFile, 4) = ".PAS") And (LendbFile <= 7 ) Then
			cnt = cnt + 1
			Redim Preserve arFiles(cnt)
			arFiles(cnt) = dbFile
		End IF
	Next

	Set outFile = fso.CreateTextFile(strOutFile, True)
	'Read Files from second Directory
	Set Fldr = fso.GetFolder(dir2)
	For Each File In Fldr.Files
		dbFile = Ucase(File.Name)
		LendbFile = Len(dbFile)
		If (Right(dbFile, 4) = ".DBF") And (LendbFile <= 8 ) then
			NotFound = True
			For I = 1 to cnt
				If (Left(arFiles(I),3) = Left(dbFile,3)) or (Mid(dbFile,3,1) = "O") Then
					NotFound = False
					Exit For
				End If
			Next

			If NotFound then
				outFile.writeLine(File.Name)
			End If
		End If
	Next
	outFile.Close

	objShell.Run "notepad " & strOutFile
Else
	MsgBox "Required objects not found"
End If

