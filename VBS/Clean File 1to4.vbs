'Clean File remove Unneeded Lines

'On Error Resume Next

Set fso = CreateObject("Scripting.FileSystemObject")
myFile = ""

' Input via Arguments
If WScript.Arguments.Count > 0 then
	If fso.FileExists(WScript.Arguments.Item(0)) Then
		myFile = WScript.Arguments.Item(0)
	End If
End If

'Input via Explorer
If myFile = "" Then
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	ObjFSO.Filter = "File|*.*"
	ObjFSO.FilterIndex = 3
	ObjFSO.ShowOpen
	myFile = ObjFSO.FileName
End If

'Call the Convert Procedure
If myFile <> "" Then
	'Call DoConvert(myFile)
	Call DoConvert(myFile)
	MsgBox "Done"
End If

Sub DoConvert(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFileZip = fso.CreateTextFile(ObjFile.ParentFolder  & "\ZIP "    & ObjFile.Name, True)
	Set outFileCit = fso.CreateTextFile(ObjFile.ParentFolder  & "\CITY "   & ObjFile.Name, True)
	Set outFileCou = fso.CreateTextFile(ObjFile.ParentFolder  & "\COUNTY " & ObjFile.Name, True)
	Set outFileTer = fso.CreateTextFile(ObjFile.ParentFolder  & "\TERR "   & ObjFile.Name, True)
	Set ObjFile = Nothing

	'Loop file & copy info to new files
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
		'Do NOT output the Lines that begin with @@
		If dLine = "ZIP CODE" Then
			doFile = "ZIP"
			dLine = inFile.ReadLine
		Else
			If dLine = "CITY" Then
				doFile = "CIT"
				dLine = inFile.ReadLine
			Else
				If dLine = "COUNTY" Then
					doFile = "COU"
					dLine = inFile.ReadLine
				Else
					If dLine = "TERRITORY" Then
						doFile = "TER"
						dLine = inFile.ReadLine
					End if
				End if
			End if
		End If
		Select Case doFile
			Case "ZIP"
				outFileZip.WriteLine(dLine)
			Case "CIT"
				outFileCit.WriteLine(dLine)
			Case "COU"
				outFileCou.WriteLine(dLine)
			Case "TER"
				outFileTer.WriteLine(dLine)
		End Select
	Loop
	outFileZip.Close
	outFileCit.Close
	outFileCou.Close
	outFileTer.Close

	inFile.Close
End Sub

Sub DoConvert2(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	'Output first line
	dLine = inFile.ReadLine
	outFile.WriteLine(dLine)
	'Loop file & copy info to new file
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
		'Only some lines
		If Ucase(Left(dLine,20)) = "1,COMPANY STANDINGS," Then
			outFile.WriteLine(dLine & Chr(34))
		End If
	Loop
	outFile.Close
	inFile.Close
End Sub