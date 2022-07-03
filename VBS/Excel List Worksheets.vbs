' Count the worksheets in and Excel file

Set fso = CreateObject("Scripting.FileSystemObject")
myFile = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	If fso.FileExists(WScript.Arguments.Item(0)) Then
		myFile = WScript.Arguments.Item(0)
	End If
End if
'Input via Explorer
If myFile = "" Then
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	ObjFSO.Filter = "Excel File|*.xls"
	ObjFSO.FilterIndex = 3
	ObjFSO.ShowOpen
	myFile = ObjFSO.FileName
End If

IF myFile <> "" then
	' open the excel document as read-only
	On Error Resume Next
	Set objExcel = CreateObject("Excel.Application")
	If Err.Number <> 0 Then
		Wscript.Echo "You must have Excel installed to perform this operation."
		Wscript.Quit 1
	Else
		objExcel.DisplayAlerts = 0
		objExcel.Workbooks.open myFile, false, true
		' Loop through each worksheet
		intWorksheets = objExcel.Worksheets.Count
		IF intWorksheets > 40 Then
			Safe = 40
		Else
			Safe = intWorksheets
		End If
		For counter = 1 to Safe
			Set currentWorkSheet = objExcel.ActiveWorkbook.Worksheets(counter)
			AllSheets =  AllSheets & " # " & counter & " 	- " & currentWorkSheet.name & vbcrlf
		Next
		objExcel.Workbooks(1).Close
		objExcel.Quit

		Answ = MsgBox("Out put to a file",VbYesNo,"VbQuestion")
		If Answ = VbYes then
			Set outFile = fso.CreateTextFile(myFile & ".txt", True)
			outFile.WriteLine("We have " & intWorksheets & " worksheets" & _
						VbCrLf & myFile & VbCrLf & AllSheets)
			outFile.Close
		Else
			WScript.Echo "We have " & intWorksheets & " worksheets" & _
						VbCrLf & myFile & VbCrLf & AllSheets
		End If
	End If
End If

