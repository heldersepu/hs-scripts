'Create a Batch file that will remove all the DBF files not used in TX.DBF

directory = "C:\Quick95\COMPZIPS\"
dFile = "C:\Quick95\COMPZIPS\TXZIP.DBF"
Set fso  = CreateObject("Scripting.FileSystemObject")

IF fso.FolderExists(directory) and fso.FileExists(dFile) then
	GetHeaders(dFile)
	dFile = dFile & ".TXT"	
	Set objShell = CreateObject("WScript.Shell")
	Set outFile = fso.CreateTextFile(directory & "\DelOld.bat", True)
	Set inFile = fso.OpenTextFile(dFile, 1)
	txtFile = InFile.ReadAll
	Set Fldr = fso.GetFolder(directory)
	For Each File In Fldr.Files
		dbFile = Ucase(File.Name)
		LendbFile = Len(dbFile)
		If (Right(dbFile, 4) = ".DBF") And (LendbFile <= 8 ) then
			If InStr(txtFile, Mid(dbFile, 1, LendbFile - 4)) = 0  then
				outFile.writeLine("@Del /S " & File)
			End If 
		End If
	Next
	
	outFile.writeLine("")	
	outFile.writeLine("@Echo.")                   
	outFile.writeLine("@if ""%1"" == ""/s"" GOTO END")
	outFile.writeLine("@Pause")
	outFile.writeLine(":END")
	outFile.Close
	inFile.Close
	objShell.Run "notepad " & directory & "\DelOld.bat"
Else
	MsgBox "Required objects not found"
End If


'Get the First row of the DBF file
Sub GetHeaders(dbfFile)
	On Error Resume Next
	Set ObjExcel = CreateObject("Excel.Application")
	If Err.Number <> 0 Then
		Wscript.Echo "You must have Excel installed to perform this operation."
		Wscript.Quit
	Else
		Set objWorkbook  = objExcel.Workbooks.Open(dbfFile)	
		'Output the values to a TXT file
		Set outFile = fso.CreateTextFile(dbfFile & ".TXT", True)
		col = 2
		CellValue = objExcel.Cells(1,col).Value
		Do Until CellValue = ""
			If (CellValue <> "CITY") and (CellValue <> "COUNTY") and (CellValue <> "TERR") then
				outFile.WriteLine(CellValue)
			End If
			col = col + 1
			CellValue = objExcel.Cells(1,col).Value
		Loop
		outFile.Close
		objExcel.Workbooks(1).Close
		objexcel.Quit
	End If
End Sub
