' Remove All non Numeric chars from a text file

Set fso = CreateObject("Scripting.FileSystemObject")
myFile = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	If fso.FileExists(WScript.Arguments.Item(0)) Then
		myFile = WScript.Arguments.Item(0)
	End If
End if
'Input via Explorer
If myFile = "" Then
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	ObjFSO.FilterIndex = 3
	ObjFSO.ShowOpen
	myFile = ObjFSO.FileName
End If

If myFile <> "" Then
    Call UpdateFile(myFile)
End If


'Sub UpdateFile(dFile)
'  This is the main procedure of this script
'  it takes the full path to a file & transform it
Sub UpdateFile(dFile)
    Set InFile 	= fso.OpenTextFile(dFile, 1)
	Set outFile = fso.CreateTextFile(dFile & ". Del.txt", True)
	Separator   = chr(9)
    'Loop line by line
	Do until inFile.atEndofStream
		dLine   = Trim(inFile.ReadLine)
		'Add a Space at the end of the line to make sure all the words are read properly
		dLine   = dLine & " "
		Temp 	= ""
		dWord   = ""

        For i = 1 to len(dLine)
    		dChar = Mid(dLine,i,1)
			If dChar <> " " and dChar <> chr(9) Then
				dWord = dWord & dChar
			Else
				If isNumeric(dWord) Then
					Temp = Temp & dWord & Separator
				Else
					If dWord = "-" Then
						Temp = Temp & "0" & Separator
					End If
	            End If
				dWord = ""
            End If
        Next

        'At this point the line is formated properly & ready to wite to new file
        outFile.WriteLine(Temp)
	Loop
	InFile.Close
	OutFile.Close
End Sub


'
'
'SAMPLE  INTUP FILE:
'
'192 Alachua  189  0.121  0.125  - 0.118
'292 Baker  216  0.116  0.119  - 0.117
'601 Bay, Coastal  270  0.362  0.365  82  0.118
'721 Bay, Remainder  254  0.276  0.277  76  0.117
'392 Bradford  216  0.113  0.117  - 0.117
'
'
'SAMPLE  OUTUP FILE:
'
'192	189	0.121		0.125		0	0.118
'292	216	0.116		0.119		0	0.117
'601	270	0.362	0.365	82	0.118
'721	254	0.276	0.277	76	0.117
'392	216	0.113		0.117		0	0.117
'