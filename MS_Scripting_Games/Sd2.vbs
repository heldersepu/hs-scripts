myFile = "C:\Scripts\Vertical.txt"
'Call the Convert Procedure
If myFile <> "" Then
    Wscript.Echo doConvert(myFile)
End If     

Function doConvert(dFile)
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set inFile  = fso.OpenTextFile(dFile, 1)
    Dim arLine()
    'Loop file & copy info to Dinamic Array
    Do until inFile.AtEndOfStream
        dLine = inFile.ReadLine
        'Wscript.Echo dLine
        dLen = Len(dLine)
        Redim Preserve arLine(dLen)
        For I = 1 to dLen
            arLine(I) = arLine(I) & Mid(dLine,I,1)
        Next
    Loop
    inFile.Close
    
    dMessage = ""
    For I = 1 to Ubound(arLine)
        dMessage = dMessage & arLine(I)
    Next
    doConvert = dMessage
End Function
