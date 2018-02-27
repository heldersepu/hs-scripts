'Compare the headers of the DBF files "TX.DBF"

dFile1 = "\\AppSrvA\QQData\quick95c\COMPZIPS\TXZIP.DBF"
dFile2 = "C:\Quick95\COMPZIPS\TXZIP.DBF"
Set fso  = CreateObject("Scripting.FileSystemObject")

If fso.FileExists(dFile1) and fso.FileExists(dFile2) then	
	txtFile1 = "C:\temp\TXZIP1.TXT"
	txtFile2 = "C:\temp\TXZIP2.TXT"
	Call GetHeaders(dFile1, txtFile1)
	Call GetHeaders(dFile2, txtFile2)

	IF fso.FileExists(dFile1) and fso.FileExists(dFile2) then
		Set objShell = CreateObject("WScript.Shell")
		objShell.Run "WinMerge " & txtFile1 & " " & txtFile2
	Else
		MsgBox "Required objects not found"
	End If
End If

'Get the First row of the DBF file
Sub GetHeaders(dbfFile, dOutFile)
	On Error Resume Next
	Set ObjExcel = CreateObject("Excel.Application")
	If Err.Number <> 0 Then
		Wscript.Echo "You must have Excel installed to perform this operation."
		Wscript.Quit
	Else
		Set objWorkbook  = objExcel.Workbooks.Open(dbfFile)	
		'Output the values to a TXT file
		Set outFile = fso.CreateTextFile(dOutFile, True)
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
