Set fso = CreateObject("Scripting.FileSystemObject")

strFolder = "C:\solr\remaxlistings\errorfiles\old\"
For Each File in FSO.GetFolder(strFolder).Files
	CALL splitFile(strFolder, File.Name, "C:\TEMP\solr\")
Next
MsgBox "All Done!"


Sub splitFile(strFolder, strFileName, strDestFolder)
	strFile = strFolder & strFileName
	Set inFile  = fso.OpenTextFile(strFile, 1)
	txtFile = inFile.ReadAll
	inFile.Close
	fileNum = 0
	count = 0
	intPos = 1
	strFile2 = strDestFolder & replace(strFileName, ".xml", "-")

	Do 
		intPos = InStr(intPos + 2, txtFile, "<doc>")
		if (intPos > 0) then
			count = count + 1
			if count >= 100 then
				count = 0
				fileNum = fileNum + 1
				CALL writeFile(strFile2 & fileNum & ".xml", Mid(txtFile, iniPos, intPos - iniPos) & "</add>")
			else 
				if count = 1 then iniPos = intPos
			end if
		end if
	Loop While (intPos > 0)
	CALL writeFile(strFile2 & (fileNum+1) & ".xml", Mid(txtFile, iniPos))
End Sub


Sub writeFile(strFileName, strText)
    Set outFile = fso.CreateTextFile(strFileName , True)
    outFile.WriteLine("<?xml version=""1.0"" encoding=""UTF-8""?>")
    outFile.WriteLine("<add>")
    outFile.WriteLine(strText)
    outFile.Close
End Sub
