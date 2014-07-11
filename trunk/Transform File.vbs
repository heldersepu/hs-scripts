'Get the File tranform it to URLS

'On Error Resume Next

Set fso = CreateObject("Scripting.FileSystemObject")
myFile = "municip.cu"

'Call the Convert Procedure
If fso.FileExists(myFile) Then
    outPutFile = DoConvert(myFile)

    Set objShell = CreateObject("WScript.Shell")
    Set inFile  = fso.OpenTextFile(outPutFile, 1)
    count = 0
    Do until inFile.AtEndOfStream
        dLine = inFile.ReadLine
        If Trim(dLine) <> "" Then
            objShell.Run dLine
            count = count + 1
        End if
        If count = 10 then
            resp = MsgBox("Continue with the next group?", vbYesNo, "Pause...")
            If resp = vbYes then 
                count = 0
            Else
                Exit Do
            End if
        End If
    Loop
    inFile.Close
    MsgBox "Done"
End If

Function DoConvert(dFile)
    ' Sample URL
    ' http://www.openstreetmap.org/?lat=22.7799&lon=-81.9117&zoom=13&name=SanNico

    sURL = "http://www.openstreetmap.org/edit"
    sLa = "?lat="
    sLo = "&lon="
    sZo = "&zoom=13"
    sNa = "&Name="

    Set inFile  = fso.OpenTextFile(dFile, 1)
    strURL_file = dFile & ".links"
    Set outFile = fso.CreateTextFile(strURL_file, True)

    'Loop file & copy info to new file
    Do until inFile.AtEndOfStream
        dLine = inFile.ReadLine
        'Do NOT output the blank Lines
        If Trim(dLine) <> "" Then
            arrItems = split(dLine, vbTAB)
            If Ubound(arrItems) = 4 then
                arrLoc = split(arrItems(3), " ")
                If Ubound(arrLoc) = 1 then
                    numLat = Left(arrLoc(0), len(arrLoc(0))-2)
                    numLon = "-" & Left(arrLoc(1), len(arrLoc(1))-2)
                    strHTML = sURL & sLa & numLat & sLo & numLon & sZo & sNa & "-" & Replace(arrItems(0)," ","_")
                    If trim(arrItems(4)) <> "" then
                        strHTML = strHTML & "--" & Replace(arrItems(4)," ","_")
                    End If
                    outFile.WriteLine(strHTML)
                End If
            End If
        End If
    Loop
    outFile.Close
    inFile.Close
    DoConvert = strURL_file
End Function
