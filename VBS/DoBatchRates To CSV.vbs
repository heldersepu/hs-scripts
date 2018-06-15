'On Error Resume Next

Set fso = CreateObject("Scripting.FileSystemObject")
myFile = "C:\QuickTX\batchRates.txt"

'Call the Convert Procedure
If myFile <> "" Then
	Call DoConvert(myFile)
    
    'Try making an Excell file
    On Error Resume Next
    Set ObjExcel = CreateObject("Excel.application")
    If Err.Number <> 0 Then
       'Wscript.Echo "You must have Excel installed to perform this operation."
       msgBox "File created:" & VbCrLf & myFile & ".csv"  
    Else
        If FSO.FileExists(myFile & ".xls") Then
            FSO.DeleteFile (myFile & ".xls")
        End If
        
        'create Excell file
        ObjExcel.Visible = False
        call ObjExcel.Workbooks.Open(myFile & ".csv")
        ObjExcel.Rows("1:1").AutoFilter
        
        ObjExcel.Cells.EntireColumn.AutoFit
        ObjExcel.Range("A2").Select
        ObjExcel.ActiveWindow.FreezePanes = True
        
        ObjExcel.Range("A1").Select
        
        With ObjExcel.Range("A1:L1").Interior
            .ColorIndex = 15
            .Pattern = 1
        End With

        Call ObjExcel.ActiveWorkbook.SaveAs(myFile & ".xls", 1)
        ObjExcel.Visible = True
    End If
    Set ObjExcel = Nothing  
End If 	

Set fso = Nothing

Sub DoConvert(dFile)
	'Read all the input File
    Set inFile = fso.OpenTextFile(dFile, 1)
	txtFile = inFile.ReadAll : inFile.Close
    Set inFile  = Nothing
    
    Set outFile = fso.CreateTextFile(dFile & ".csv", True)
	'Output first line
	outFile.WriteLine("Company,Abbr,Policy Term,Liability,Phys,Fees,Total,Down Pay,Pay Amnt,Num Pmnts,Grand Total,Credit")
    dConcat = ""
    
	'Loop file & copy info to new file
	For each dLine in Split(txtFile,VbCrLF)
		dLine = trim(dLine)
		'Split the line by "(" 
        dItem = Split(dLine,"(")
        If Ubound(dItem) >= 2 then     		
            'If the second # is 0 that is a new company
            If (Left(dItem(2),1) = "0") Then
    			If (dConcat <> "") Then 
                    call outFile.WriteLine(Replace(dConcat,chr(34),""))
                End If
                'Add the Name of the company
                dConcat = Split(dItem(2),") ")(1)
            Else
                'Concatenate using comma delimited format
                dConcat = dConcat & "," & Split(dItem(2),") ")(1)
    		End If
		End If
	Next
    
	outFile.Close
End Sub
