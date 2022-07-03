myFile = "C:\Scripts\cmdlets.txt"
'Call the Convert Procedure
dScramble = ".CSRIIEHRRTOENSWWPOCTIHPT-T"
If myFile <> "" Then
    Wscript.Echo doConvert(myFile)
End If

Function doConvert(dFile)
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set inFile  = fso.OpenTextFile(dFile, 1)
    dMessage = ""

    Do until inFile.AtEndOfStream
        dLine = inFile.ReadLine
        'Wscript.Echo dLine
        dLen = Len(dLine)
        isFound = True
        For I = 1 to dLen
            dChar = UCase(Mid(dLine,I,1))
            If InStr(dScramble,dChar) = 0 then
                isFound = False
            End If
        Next

        if isFound then
            dMessage = dMessage & dLine& VbCrLf
        End IF
    Loop
    inFile.Close

    doConvert = dMessage
End Function
