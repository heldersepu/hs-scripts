' Create Excel file in the desktop 

set WshShell = WScript.CreateObject("WScript.Shell") 
strDesktop = WshShell.SpecialFolders("Desktop")
On Error Resume Next
Set objExcel = createobject("Excel.application")  
If Err.Number <> 0 Then
   Wscript.Echo "You must have Excel installed to perform this operation."
Else
	objexcel.Visible = False
	objexcel.Workbooks.add
	objexcel.Cells(1, 1).Value = "Testing"
	objexcel.ActiveWorkbook.SaveAs(strDesktop & "\ExcelTest.xls")
	objexcel.Quit
End If