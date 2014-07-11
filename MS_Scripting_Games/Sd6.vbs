myFile = "C:\Scripts\Lettercase.txt"
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
            If IsNumeric(dChar) then
                dMessage = dMessage & dChar -1
            Else
                If UCase(dChar) = dChar Then
                    dMessage = dMessage & LCase(dChar)
                Else
                    dMessage = dMessage & UCase(dChar)
                End If
            End If
		Next
        dMessage = dMessage & VbCrLf
	Loop
	inFile.Close

	doConvert = dMessage
End Function
