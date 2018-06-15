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
	Call FixLines(myFile)
End If 	

Sub DoConvert(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	
	'Loop file & copy info to new file
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
		'Do NOT output the Lines that begin with @@
		If Left(dLine,2) <> "@@" Then
			outFile.WriteLine(dLine)
		End If
		
		'dPos = InStr(dLine,"SetBiPdLimits")
		'If dPos > 0 then
		'	outFile.WriteLine(Mid(dLine, dPos ,Len(dLine)))
		'End If
	Loop
	outFile.Close
	inFile.Close
End Sub

Sub DoConvertPlustoMin(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	inFile.SkipLine
	'Loop file & copy info to new file
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
		'Do NOT output the Lines that begin with @@
		If Left(dLine,1) = "-" Then
			outFile.WriteLine( "+" & Mid(dLine,2,len(dLine)-4))
		Else
			outFile.WriteLine(dLine)
		End If
		
		'dPos = InStr(dLine,"SetBiPdLimits")
		'If dPos > 0 then
		'	outFile.WriteLine(Mid(dLine, dPos ,Len(dLine)))
		'End If
	Loop
	outFile.Close
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

Function GetLast(strLine, chrSepa)
	I = Len(strLine) - 1
	Do
		dChar = Mid(strLine,I,1)
		If (dChar <> chrSepa) then
			I = I - 1
		End If
	Loop While (dChar <> chrSepa and I > 0)
	GetLast = I
End Function 

Sub DoConvert3(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	'Output first line
	dLine = inFile.ReadLine
	'Loop file & copy info to new file
	Do until inFile.AtEndOfStream
		X = GetLast(dLine, " ")
		outFile.WriteLine(Mid(dLine,12,5) & ", " & _
						  Mid(dLine,19,X-19) & ", " & Mid(dLine,X+1))
		dLine = inFile.ReadLine
	Loop
	outFile.Close
	inFile.Close
End Sub

Sub DoConvert4(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	'Output first line
	dLine = inFile.ReadLine
	outFile.WriteLine(dLine)
	'Loop file & do not output dup lines
	Do until inFile.AtEndOfStream
		X1 = RIGHT(dLine,25)
		PrevLine = dLine
		dLine = inFile.ReadLine
		X2 = RIGHT(dLine,25)
		If X1 <> X2 then 
		'If PrevLine <> dLine then 
			'outFile.WriteLine(PrevLine)
			outFile.WriteLine(dLine)
		Else
			outFile.WriteLine(Mid(PrevLine,7,4) & ".." & Trim(dLine))
		End if		
	Loop
	outFile.WriteLine(dLine)
	outFile.Close
	inFile.Close
End Sub

Sub DoConvert5(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	'Output first line
	dLine = inFile.ReadLine
	'outFile.WriteLine(dLine)
	'Loop file & do not output dup lines
	Do until inFile.AtEndOfStream
		PrevLine = dLine
		dLine = inFile.ReadLine
		If Left(Trim(PrevLine),4) = Left(Trim(dLine),4) then 
			If Len(Trim(PrevLine)) > Len(Trim(dLine)) then
				outFile.WriteLine(PrevLine)
			else
				outFile.WriteLine(dLine)
			end if
		else
			If Len(Trim(PrevLine)) < 35 then
				outFile.WriteLine(PrevLine)
			End If
		End if		
	Loop
	'outFile.WriteLine(dLine)
	outFile.Close
	inFile.Close
End Sub

'Remove Blank Lines
Sub DoConvert6(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	
	'Loop file & do not output blank lines
	Do until inFile.AtEndOfStream
		dLine = Trim(inFile.ReadLine)
		If (dLine <> "") and (Left(dLine,1) <> "F") then 
			outFile.WriteLine(dLine)
		End if
	Loop
	outFile.Close
	inFile.Close
End Sub

'Fix lines
Sub DoConvert7(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	
	dLine = Trim(inFile.ReadLine)
	'Loop file & do not output blank lines
	Do until inFile.AtEndOfStream
		If (Left(dLine,1) <> ":") then 
			If not inFile.AtEndOfStream then
				dNextLine = Trim(inFile.ReadLine)
			End If
			If (Left(dNextLine,1)  <> ":") then 
				outFile.WriteLine(dLine &  ", ")
				dLine = dNextLine
			Else
				outFile.WriteLine(dLine & " " & myTrap)
				dLine = dNextLine 
			End If			
		Else
			'outFile.WriteLine("")
			myTrap = dLine 
			dLine = Trim(inFile.ReadLine)
		End if
	Loop
	outFile.WriteLine(dLine &  myTrap)
	outFile.Close
	inFile.Close
End Sub

'Join small Lines
Sub DoConvert8(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	dLine = ""
	dConLine = ""
	'Loop file & do not output small lines
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
		
		If right(dLine,1) = ";" then
			outFile.WriteLine(dConLine)
			dConLine = ""
			outFile.WriteLine(dLine)
		Else
			dConLine = dConLine & dLine
		End If
		
		If (len(dConLine) > 40) then 
			outFile.WriteLine(dConLine)
			dConLine = ""
		End if
	Loop
	outFile.WriteLine(dLine)
	outFile.Close
	inFile.Close
End Sub

'Fix lines
Sub FixLines(dFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
	Set outFile = fso.CreateTextFile(ObjFile.ParentFolder  & "\Clean " & ObjFile.Name, True)
	Set ObjFile = Nothing
	
	dLine = Trim(inFile.ReadLine)
	'Loop file & do not output blank lines
	Do until inFile.AtEndOfStream
        chr8Left = UCase(Left(dLine,8))
        chr1Left = Left(dLine,1)
        
		If ((chr1Left = " ") or (chr1Left = "[") or _
        (chr8Left = "NUMBERFI") or (chr8Left = "COMMENTS") or (chr8Left = "FIELDNUM")) then 
			outFile.WriteLine(dLine)
		Else
            outFile.WriteLine(" "  & dLine)
		End if
		dLine = Trim(inFile.ReadLine)
	Loop
	outFile.WriteLine(dLine)
	outFile.Close
	inFile.Close
End Sub