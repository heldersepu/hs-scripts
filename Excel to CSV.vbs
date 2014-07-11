'Save (.XLS) Excel file as (.CSV) Comma Delimited can also be as Tab separated
' Can Prosess multiple files, just pass them as arguments
' Can launch external FileCompare utility such as WinMerge


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

If myFile <> "" Then
	Call doConvert(myFile)
	'Check all other arguments
	With WScript.Arguments
		If .Count > 1 then
			For J = 1 to .Count - 1
				If fso.FileExists(.Item(J)) Then 
					Call doConvert(.Item(J))
				Else
					' If Argument is /C then do compare with giving program
					If (Ucase(.Item(J)) = "/C") and  (J > 1) then
						If fso.FileExists(.Item(0) & ".csv") And _
						  fso.FileExists(.Item(1) & ".csv") And _
						  fso.FileExists(.Item(J+1)) Then 
							Set objShell = CreateObject("WScript.Shell")
							objShell.Run  chr(34) & .Item(J+1) & chr(34) & " " & chr(34) & .Item(0) & ".csv" & _ 
										  chr(34) & " " & chr(34) & .Item(1) & ".csv" & chr(34)
							Exit For
						End If
					End If
				End If
			Next
		End if	
	End With
End If

Function CleanTxt(dString)
	'Trim trailing commas & Spaces
    dCommas = ",,,,,,,,,,,,,,,,,,,,,"
    Do
        dString = Replace(dString, dCommas & VbCrLf, VbCrLf)
        dCommas = Left(dCommas, Len(dCommas) - 1)
    Loop While dCommas <> ""
	
	dLen = Len(dString)
	If dLen > 0 then 
		Do
			dChar = asc(Mid(dString,dLen,1))
			dLen = dLen - 1
		Loop While ((dChar = 10 or dChar = 13 or dChar = 32 or dChar = 44) And dLen > 0)
		CleanTxt = Mid(dString,1,dLen+1)
	Else
		CleanTxt = dString
	End if
End Function

Sub doConvert(dFile)
	'Only works with .XLS files 
	If Ucase(Right(dFile,4)) = ".XLS" then
		On Error Resume Next
		Set ObjExcel     = CreateObject("Excel.Application")
		If Err.Number <> 0 Then
			Wscript.Echo "You must have Excel installed to perform this operation."
			Wscript.Quit 1
		Else
			Set objWorkbook  = objExcel.Workbooks.Open(dFile)
			intWorksheets = ObjExcel.Worksheets.Count
			'Create a file to append all the Worksheets
			Set outFile = fso.CreateTextFile(dFile & ".csv", True)
			'Create a new Folder to put each Worksheet
			dFolder = Mid(dFile,1,Len(dFile)-4)
			If fso.FolderExists(dFolder) Then fso.DeleteFolder(dFolder)
			fso.CreateFolder(dFolder)
			'Put all the Sheets in an Array
			ReDim mySheets(intWorksheets)
			For I = 1 to intWorksheets
				mySheets(I) = objExcel.Worksheets(I).Name
			Next
			'Sort the Sheets array
			n = intWorksheets 
			Do
				swapped = false
				n = n - 1
				For I = 1 to n 
					if Ucase(mySheets(I)) > Ucase(mySheets(I+1)) then
						temp = mySheets(I)
						mySheets(I) = mySheets(I+1)
						mySheets(I+1) = temp
						swapped = true
					End if
				Next
			Loop While swapped	
			'Save each Worksheet as coma separated
			For counter = 1 to intWorksheets
				Set currentWorkSheet = objExcel.ActiveWorkbook.Worksheets(mySheets(counter))
				'Create individual files in the new Folder
				dFileName = dFolder & "\" & mySheets(counter) & ".csv"
				currentWorkSheet.SaveAs dFileName,6,0
				Set inFile 	= fso.OpenTextFile(dFileName, 1)
				AllInfo = inFile.ReadAll
				inFile.Close
				outFile.WriteLine( "___/ " & mySheets(counter) & " \___")	
				outFile.WriteLine(CleanTxt(AllInfo))
				outFile.WriteLine(chr(13)&chr(10))
				
			Next
			outFile.Close
			'Wscript.echo "Done"
			ObjExcel.ActiveWorkbook.Close(0)
			ObjExcel.Quit
		End If
	Else
		Wscript.Echo " This file is not an Excel Document" & VbCrLf & myFile
	End If
End Sub

'
'FileExtStr = ".csv": FileFormatNum = 6
'FileExtStr = ".txt": FileFormatNum = -4158 ' TAB separated
'FileExtStr = ".prn": FileFormatNum = 36
'
