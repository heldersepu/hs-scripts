myFile = "C:\Scripts\Symbols.txt"
'Call the Convert Procedure
If myFile <> "" Then
    Wscript.Echo doConvert(myFile)
End If

Function doConvert(dFile)
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set inFile  = fso.OpenTextFile(dFile, 1)
    dMessage = ""
    'Loop file & copy info to Dinamic Array
    Do until inFile.AtEndOfStream
        dLine = inFile.ReadLine
        'Wscript.Echo dLine
        dLen = Len(dLine)

        For I = 1 to dLen
            dChar = Mid(dLine,I,1)
            If IsNumeric(dChar) or dChar = " " or _
               (UCase(dChar) <> LCase(dChar)) then
                dMessage = dMessage & dChar
            End If
        Next
        dMessage = dMessage & VbCrLf
    Loop
    inFile.Close

    doConvert = dMessage
End Function
