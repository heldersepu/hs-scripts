Set filesys = CreateObject("Scripting.FileSystemObject")
ReadFile("List.txt")
ReadFile("List2.txt")

Sub ReadFile(dfile)
	If filesys.FileExists(dfile) Then
		dNames = ""
		Set ObjFile = filesys.OpenTextFile(dfile, 1)
		'dNames = dNames & vbcrlf & "Names in File " & dfile
		dNames = dNames & vbcrlf & objFile.ReadLine
		Do until (objFile.AtEndOfStream)
			dLine = objFile.ReadLine
			If dLine = "" then 'Names are after the empty line
				dNames = dNames & vbcrlf & objFile.ReadLine
			End If
		Loop
		Wscript.Echo dNames
		ObjFile.Close
	Else
		'Give the user the option to look for the file
		Resp = MsgBox ("The file "& dFile & " was not found" & _
			VBcrlf& "Do you want to look for the file", _
			VbYesNo," File not found!")
		If Resp = vbYes then
			Set oDLG=CreateObject("MSComDlg.CommonDialog") 
			oDLG.DialogTitle="Open"
			oDLG.Filter= "Text Files|*.txt|All files|*.*"
			oDLG.MaxFileSize=255
			oDLG.ShowOpen
			If oDLG.FileName<>"" Then
				ReadFile(oDLG.FileName)
			End If
			Set oDLG=Nothing
		End If
	End If
End Sub 