myFile = "C:\Scripts\presidents.txt"

If myFile <> "" Then
    Wscript.Echo doTasks(myFile)
End If     

Function doTasks(dFile)
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set inFile  = fso.OpenTextFile(dFile, 1)
    
    totVowels = 0
    dLongest = ""
    dInitial = "" 
    dMax = 0
    
    'Loop file 
    Do until inFile.AtEndOfStream
        dLine = inFile.ReadLine
        'Wscript.Echo dLine
        arrNames = Split(dLine, ", ")'Error made
        dLen = Len(arrNames(1))
        If (dLen > dMax) then
            dMax = dLen
            dLongest = arrNames(1) & " " & arrNames(0) 
        End If
        dInitial = dInitial & Ucase(Left(arrNames(1),1) & Left(arrNames(0),1))
        For I = 1 to Len(dLine)
            dChar = Ucase(Mid(dLine,I,1))
            If (dChar = "A") or (dChar = "E") or (dChar = "I") or _
               (dChar = "O") or (dChar = "U") then
                totVowels = totVowels + 1
            End If
        Next
    Loop
    inFile.Close
    
    strVowels = VbCrLf
    For I = 65 to 90
        If InStr(dInitial,Chr(I)) = 0 Then
            strVowels = strVowels & Chr(I) & VbCrLf
        End If
    Next
    doTasks = "Longest first name: " & dLongest & VbCrLf & VbCrLf & _
              "Letters not used as initials: " & strVowels & VbCrLf & _
              "Total vowels used: " & totVowels & VbCrLf 
End Function
