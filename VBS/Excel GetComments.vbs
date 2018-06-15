On Error Resume Next
Set objExcel = CreateObject("Excel.Application")
If Err.Number <> 0 Then
   Wscript.Echo "You must have Excel installed to perform this operation."
   Wscript.Quit 1
End If

Set fso = CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell") 
Set outFile = fso.CreateTextFile(WshShell.SpecialFolders("Desktop") & "\NU.TXT",True)
Set WshShell = Nothing

With objExcel
    .Visible = False
    Set objWorkbook  = .Workbooks.Open("C:\QuickQuoteBatchRater\Texas\inputtest.xls")
    I = 1

    Do
        dValue = Trim(.Cells(1, I).Value)
        If (dValue <> "") then
            outFile.WriteLine("+ " &dValue)
            outFile.WriteLine( .Cells(1, I).Comment.Text)
        End If
        I = I + 1
    Loop While (dValue <> "")
    	
    outFile.Close
    Set outFile = Nothing 
     
    .Workbooks(1).Close
    .Quit   
End With

Set fso = Nothing
Set objExcel = Nothing
