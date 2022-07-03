' Display Excel Spreadsheet info in Col  A B C
On Error Resume Next
Set objExcel     = CreateObject("Excel.Application")
If Err.Number <> 0 Then
   Wscript.Echo "You must have Excel installed to perform this operation."
   Wscript.Quit 1
End If
'objExcel.Visible = False
Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
ObjFSO.Filter = "Excel File|*.xls"
ObjFSO.FilterIndex = 3
InitFSO = ObjFSO.ShowOpen
 If ObjFSO.FileName <> "" Then
	Set objWorkbook  = objExcel.Workbooks.Open(ObjFSO.FileName)

	intRow = 1
	Info = "      | A                        | B                        | C" & VbCrLf
	Info = Info & "---------------------------------------------------------------------" & VbCrLf

	Do Until objExcel.Cells(intRow,1).Value = ""
		cA = objExcel.Cells(intRow, 1).Value
		If Len(cA) > 24 Then
			cA = Left(cA,24)
		End If
		cB = objExcel.Cells(intRow, 2).Value
		If Len(cB) > 24 Then
			cB = Left(cB,24)
		End If
		cC = objExcel.Cells(intRow, 3).Value
		If Len(cC) > 24 Then
			cC = Left(cC,24)
		End If
	    Info = Info & intRow & String(5 - Len(intRow), " ") & " | " & _
					cA & String(25 - Len(cA), " ") & "| " & cB & _
					String(25 - Len(cB), " ") & "| " & cC & VbCrLf
	    intRow = intRow + 1
		If intRow > 1000 then Exit Do
	Loop

	Info = Info & "---------------------------------------------------------------------" & VbCrLf
	Wscript.Echo Info
	objExcel.Quit
End If
