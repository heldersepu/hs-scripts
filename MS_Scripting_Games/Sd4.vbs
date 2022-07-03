myFile = "C:\Scripts\numbers.txt"
'Call the Convert Procedure
If myFile <> "" Then
    Wscript.Echo doConvert(myFile)
End If

Function doConvert(dFile)
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set inFile  = fso.OpenTextFile(dFile, 1)
    dMessage = ""

    'Loop file
    Do until inFile.AtEndOfStream
        dLine = inFile.ReadLine
        'convert to chars
		For I = 1 to (Len(dLine)\2 + 1)
            dChar = Mid(dLine,(I*2 - 1),2)
            If IsNumeric(dChar) then
              dMessage = dMessage & Chr(dChar)
            End If
        Next
        dMessage = dMessage & VbCrLf
    Loop
    inFile.Close

    doConvert = dMessage
End Function
