'Create CSV (TAB separeted) report from GNU Diff file

Set fso = CreateObject("Scripting.FileSystemObject")
myTxtFile = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	If fso.FileExists(WScript.Arguments.Item(0)) Then
		myTxtFile = WScript.Arguments.Item(0)
	End If
End If
'Input via Explorer
If myTxtFile = "" Then
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	ObjFSO.Filter = "GNU Diff File|*.*"
	ObjFSO.ShowOpen
	myTxtFile = ObjFSO.FileName
End If
'Call the Write Procedure
If myTxtFile <> "" Then
	Call DoWrite(myTxtFile)
End If

Sub DoWrite(txtFile)

	'InFile is the GNU diff file (input file)
	Set inFile  = fso.OpenTextFile(txtFile, 1)
	'Append the rest of the info to the HTML file
	'OutFile HTML file (OutPut File)
	Set outFile = fso.CreateTextFile(txtFile & ".CSV",, True)

	'Write the Comparison details
	outFile.WriteLine("Comparison details")
	outFile.WriteLine("Line	Contents	Comp")

	'Counters needed for the Statistics
	IntLine = 0
	IntPlus = 0
	IntMinus = 0
	IntModif = 0

	inFile.SkipLine
	inFile.SkipLine
	'Loop lines  Count + and - & Write all the Comparison Details
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
		dChar = Left(dLine,1)
		If dChar = "@" Then
			IntPosS = inStr(5,dLine," ")
			IntPosC = inStr(5,dLine,",")
			If IntPosC = 0 then
				IntPos = IntPosS
			Else
				If IntPosC > IntPosS then
					IntPos = IntPosS
				Else
					IntPos = IntPosc
				End IF
			End If

			IntLine = Mid(dLine,5,IntPos-5)
		Else
			If dChar = "+" Then
				IntPlus = IntPlus + 1
				outFile.WriteLine(IntLine & "	" &chr(34)& Mid(dLine,2,len(dline)) &chr(34)& "	ADD")
			Else
				If dChar = "-" Then
					IntMinus = IntMinus + 1
					outFile.WriteLine(IntLine & "	" &chr(34)& Mid(dLine,2,len(dline)) &chr(34)& "	DEL")
				Else
					outFile.WriteLine(IntLine & "	" &chr(34)& dLine &chr(34)& "	UNK")
				End If
			End If

			IntLine = IntLine + 1
		End If
	Loop

	'Write the end of the file with the Statistics
	outFile.WriteLine("")
	outFile.WriteLine("COMPARISON STATISTICS")
    outFile.WriteLine("Description	Amount")
    outFile.WriteLine("  Added	" & IntPlus)
    outFile.WriteLine("  Deleted	" & IntMinus)
    outFile.WriteLine("  Modified	" & IntModif)
	outFile.WriteLine("")
	outFile.Close
	inFile.Close

End Sub
