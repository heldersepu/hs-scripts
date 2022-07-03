'Count the + & - in a GNU DIFF file

On Error Resume Next
Set objExcel = CreateObject("Excel.Application")
If Err.Number <> 0 Then
	Wscript.Echo "You must have Excel installed to perform this operation."
Else
	Set fso = CreateObject("Scripting.FileSystemObject")
	myTxtFile = ""
	' Input via Arguments
	If fso.FileExists(WScript.Arguments.Item(0)) Then
		myTxtFile = WScript.Arguments.Item(0)
	End If
	'Input via Explorer
	If myTxtFile = "" Then
		Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
		ObjFSO.Filter = "File to count|*.*"
		ObjFSO.ShowOpen
		myTxtFile = ObjFSO.FileName
	End If
	'Call the Count Procedure
	If myTxtFile <> "" Then
		Call DoCount(myTxtFile)
	End If
End If

Sub DoCount(txtFile)
	Set inFile = fso.OpenTextFile(txtFile, 1)
	IntPlus  = 0
	IntMinus = 0
	'Loop lines & Count + and -
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
		dChar = Left(dLine,1)
		If dChar = "+" Then
			IntPlus = IntPlus + 1
		Else
			If dChar = "-" Then
				IntMinus = IntMinus + 1
			End If
		End If
	Loop
	inFile.Close
	MsgBox txtFile & VbCrLf & "IntPlus " & IntPlus & VbCrLf & "IntMinus " & IntMinus
End Sub
