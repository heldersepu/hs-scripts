' Rename++ Context menu <- will add a right click funtion to the windows shell
' use tortoise SVN to determine propercase if not 
' Will change "New Text Document.txt"  to "nEW tEXT dOCUMENT.TXT"

Set objShell    = CreateObject("WScript.Shell")
Set fso  		= CreateObject("Scripting.FileSystemObject")
scriptFile      = Wscript.Path & "\case.vbs"

If (Not fso.FileExists(scriptFile)) Then	
    '// Register the file 	
	dRegist(scriptFile)
End If

If WScript.Arguments.Count > 0  Then
	Select Case UCase(WScript.Arguments.Item(0))
		Case "/R" 
			dRename (WScript.Arguments.Item(1))
		Case "/REG"
			dRegist(scriptFile)
		Case "/DEL"
			Delet()
		Case Else
			objShell.Run "notepad " & Wscript.Path & "\case.vbs"
	End Select
Else
	objShell.Run "notepad " & Wscript.Path & "\case.vbs"
End If


Sub dRename(argFile)
	strFile = Trim(argFile)
	If fso.FileExists(strFile) Then
		Set dFile = fso.GetFile(strFile)
		gotFixed = False
		cFile =  ""
		
		tsvnFile = dFile.ParentFolder & "\.svn\text-base\" & dFile.Name & ".svn-base"
		If fso.FileExists(tsvnFile) then
			'Change the case Based on the \.svn\text-base\
			'.svn-base is the correct File case
			Set objOkFile = fso.GetFile(tsvnFile)
			cFile =  Left(objOkFile.Name, Len(dFile.name))
			Set objOkFile = Nothing
			'msgbox cFile & " " & Len(dFile.name)
			gotFixed = True
		End If
		
		If Not gotFixed then
			'Change the case of the file per letter
			For I = 1 to Len(strFile)
				dChar = Mid(strFile,I,1)
				If dChar = UCase(dChar) Then
					dChar = Lcase(dChar)
				Else
					dChar = UCase(dChar)
				End If
				cFile = cFile & dChar
			Next
		End If
		
		'Wscript.Echo File &" = " & vbcrlf & cFile
		If cFile <> dFile.Name then
			dFile.Move cFile
			objShell.SendKeys "{F5}"
		End If
		Set dFile = Nothing
	Else
		Wscript.Echo "File not Found! " & vbcrlf & strFile
	End If
End Sub

Sub dRegist(myFile)
	' Copy the file to "C:/WINDOWS/system32"
	fso.CopyFile wscript.ScriptName,  Wscript.Path & "\case.vbs", true
	'Create Shortcut
	Set oShLink  = objShell.CreateShortcut(Wscript.Path & "\case.lnk")
	oShLink.TargetPath = Wscript.Path & "\case.vbs"
	oShLink.Save
	' Create the Regedit keys	
	DllReg  = "HKCR\*\shell\Rename++\command\"
	RegProg = "wscript " & myFile & " /R %1"
	objShell.RegWrite DllReg , RegProg
End Sub

Sub Delet()
	'Delete all the files
	If fso.FileExists(Wscript.Path & "\case.vbs") then 
		fso.DeleteFile Wscript.Path & "\case.vbs"
	End If
	If fso.FileExists(Wscript.Path & "\case.lnk") then 
		fso.DeleteFile Wscript.Path & "\case.lnk"
	End If
	' Delete the Regedit keys	
	objShell.RegDelete "HKCR\*\shell\Rename++\command\"
	objShell.RegDelete "HKCR\*\shell\Rename++\"
End Sub
