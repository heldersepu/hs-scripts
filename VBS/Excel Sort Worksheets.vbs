'Sort all worksheets in an Excel file

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
'Call the Sort Procedure
If myFile <> "" Then
	Answ = MsgBox("Out put to a file",VbYesNo,"VbQuestion")
	If Answ = VbYes then 
		Set outFile = fso.CreateTextFile(myFile & ".txt", True)
		outFile.WriteLine(SortWorksheets(MyFile))
		outFile.Close
	Else
		WScript.Echo SortWorksheets(MyFile)
	End If
End If 

Function SortWorksheets(MyFile)
	On Error Resume Next
	Set objExcel = CreateObject("Excel.Application")
	If Err.Number <> 0 Then
		Wscript.Echo "You must have Excel installed to perform this operation."
		Wscript.Quit 1
	Else
		objExcel.DisplayAlerts = 0
		objExcel.Workbooks.open MyFile, false, true
	    LastWS = objExcel.Worksheets.Count
		ReDim mySheets(LastWS)
	    For I = 1 To LastWS 
			mySheets(I) = objExcel.Worksheets(I).Name
	    Next
		objExcel.Workbooks(1).Close
		objExcel.Quit
		'Sort the Sheets
		n = LastWS 
		Do
			swapped = false
			n = n - 1
			For i = 1 to n 
				if Ucase(mySheets(I)) > Ucase(mySheets(I+1)) then
					temp = mySheets(I)
					mySheets(I) = mySheets(I+1)
					mySheets(I+1) = temp
					swapped = true
				End if
			Next
		Loop While swapped	
		
		For I = 1 To LastWS 
			SortWorksheets = SortWorksheets & VbCrLf & mySheets(I) 
	    Next
	End if
End Function
