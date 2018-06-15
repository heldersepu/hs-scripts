
myFile = "C:\QuickFL\hsepulveda\lbArgs.txt"


'Call the Convert Procedure
If myFile <> "" Then
	
	strFinal = DoConvert(myFile)
	
	Set objShell = CreateObject("WScript.Shell")
	objShell.Run "notepad++ " & strFinal
	Set objShell = Nothing
	
End If 	

Function DoConvert(dFile)
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set inFile = fso.OpenTextFile(dFile, 1)
	strAlltxtFile = inFile.ReadAll
	inFile.Close
	Set inFile = Nothing
	
	Set ObjFile = fso.GetFile(dFile)
	strOutFile = ObjFile.ParentFolder  & "\Clean " & ObjFile.Name & ".ini"
	Set ObjFile = Nothing
	
	Set outFile = fso.CreateTextFile(strOutFile, True)	
	
	For I = 1 to 4
		intPos = InStr(1, strAlltxtFile, "Driver" & I & "_record")
		If intPos > 0  then 
			intEOL = InStr(intPos, strAlltxtFile, VbCrLf)
			outFile.WriteLine(" ")
			outFile.WriteLine(Mid(strAlltxtFile, intPos, (intEOL-intPos)))
			intNum = 0
			Do
				intNum = intNum + 1
				intPos = InStr(1, strAlltxtFile, "Dvr" & I & "_Vio" & intNum) 'Only the VIO
				If intPos > 0 then
					intEOL = InStr(intPos, strAlltxtFile, VbCrLf)
					outFile.WriteLine("     " & Mid(strAlltxtFile, intPos, (intEOL-intPos)))
				End If
			Loop While intPos > 0
		End If			
	Next
	
	outFile.Close
	Set outFile = Nothing
	Set fso = Nothing	
	DoConvert = strOutFile
End Function
