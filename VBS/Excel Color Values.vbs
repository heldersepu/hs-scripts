On Error Resume Next
Set objExcel = CreateObject("Excel.Application")
If Err.Number <> 0 Then
   Wscript.Echo "You must have Excel installed to perform this operation."
   Wscript.Quit 1
End If

objExcel.Visible = True
objExcel.Workbooks.Add

For i = 1 to 100
    objExcel.Cells(i, 1).Value = i
    objExcel.Cells(i, 2).Interior.ColorIndex = i
Next
