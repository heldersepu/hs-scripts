'Compare 2 Files

Set fso = CreateObject("Scripting.FileSystemObject")
myFile1 = ""
myFile2 = ""

' Input via Arguments
If WScript.Arguments.Count > 1 then
	If fso.FileExists(WScript.Arguments.Item(0)) Then
		myFile1 = WScript.Arguments.Item(0)
		myFile2 = WScript.Arguments.Item(1)
	End If
End If

'Input via Explorer
If myFile1 = "" Then 
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	'ObjFSO.Filter = "HTML File|*.html"
	ObjFSO.FilterIndex = 3
	ObjFSO.ShowOpen
	myFile1 = ObjFSO.FileName
End If
If (myFile1 <> "") and (myFile2 = "") Then 
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	'ObjFSO.Filter = "HTML File|*.html"
	ObjFSO.FilterIndex = 3
	ObjFSO.ShowOpen
	myFile2 = ObjFSO.FileName
End If

'Call the Compare Procedure
If (myFile1 <> "") and (myFile2 <> "") Then
	Call DoCompare(myFile1, myFile2)
End If 	

Sub DoCompare(dFile1, dFile2)
	Set inFile1  = fso.OpenTextFile(dFile1, 1)
	Set inFile2  = fso.OpenTextFile(dFile2, 1)
	Set outFile = fso.CreateTextFile(dFile2 & ".ini", True)
	
	dLine1 = inFile1.ReadAll
	dLine2 = inFile2.ReadAll
	outFile.WriteLine dLine1
	outFile.WriteLine VbCrLf & "  --------" & VbCrLf
	outFile.WriteLine dLine2
	
	If dLine1 = dLine2 then
		msgBox "Files are =" 
	Else
		msgBox "Files are NOT the same"
	End if

	outFile.Close
	inFile1.Close
	inFile2.Close
End Sub
