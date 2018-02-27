myFile = "C:\Scripts\Alice.txt"
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
        arrWords = Split(dLine," ")
        
        For I = 0 to Ubound(arrWords)
            strRever = ""
            dLen = Len(arrWords(I))
            For J = 0 to dLen -1
                dChar = Mid(arrWords(I),dLen - J,1)
                strRever = strRever & dChar
            Next
            dMessage = dMessage & strRever & " "
        Next
        
        dMessage = dMessage & VbCrLf
    Loop
    inFile.Close
    
    doConvert = dMessage
End Function
