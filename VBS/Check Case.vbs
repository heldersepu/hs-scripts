'// Save the case of all the .PAS files in a directory to a file "case.ini"
'//
'// CASE [/C] [/G] source
'//
'//   /G	Generate the case.ini file
'//   /C	Check the directory against the case.ini file
'//   /R	Rename the File Based in the Original in SVN or case.ini
'//   /REG  	Register the Rename++ Context menu <- will add a right click funtion to the windows shell
'//   source	Specifies the directory to be inspected,
'//		"ALL" can be used to process all 3 states
'//		" FL"	C:\newqq95\allcomp
'//   		"GA"	C:\NEWQQGA\allcomp
'//   		"TX"	C:\Quick95\ALLCOMP
'// Ex:  case  /c all

Set objShell    = CreateObject("WScript.Shell")
Set fso  		= CreateObject("Scripting.FileSystemObject")
scriptFile   	= Wscript.Path & "\case.vbs"

If (Not fso.FileExists(scriptFile)) Then
'// Register the file
	dRegist(scriptFile)
'// process all 3 states
	GenList ("C:\newqq95\allcomp")
	GenList ("C:\NEWQQGA\allcomp")
	GenList ("C:\Quick95\ALLCOMP")
Else
	iNum = WScript.Arguments.Count
	If iNum > 0  Then
		Select Case UCase(WScript.Arguments.Item(0))
			Case "/G"
				GenCase (WScript.Arguments.Item(1))
			Case "/C"
				CheckCase (WScript.Arguments.Item(1))
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
End If

Sub GenCase(Param)
	If UCase(Param) = "ALL" then			'// process all 3 states
		GenList ("C:\newqq95\allcomp")
		GenList ("C:\NEWQQGA\allcomp")
		GenList ("C:\Quick95\ALLCOMP")
		Exit Sub
	else
		If fso.FolderExists(Param) then
			GenList (Param)
		else
			Select Case Ucase(Param)
				case "FL"
					GenList ("C:\newqq95\allcomp")
				case "GA"
					GenList ("C:\NEWQQGA\allcomp")
				case "TX"
					GenList ("C:\Quick95\ALLCOMP")
				case else
					GenList (".")
			End Select
		End If
	End If
End Sub

Sub GenList (directory)
	If fso.FolderExists(directory) Then
		Set Fldr 	= fso.GetFolder(directory)
		Set outFile = fso.CreateTextFile(directory & "\case.ini", True)
		For Each File In Fldr.Files
			If (UCase(Right(File,4)) = ".PAS") then outFile.WriteLine(File)
		next
		For i = 1 to 10
			outFile.WriteLine(" ")
		next
		outFile.Close
	Else
		MsgBox "Folder does NOT exist! Please check the path :" & VbCrLf & directory
	End If
End Sub

Sub CheckCase (Param)
	If UCase(Param) = "ALL" then			'// process all 3 states
		CheckList ("C:\newqq95\allcomp")
		CheckList ("C:\NEWQQGA\allcomp")
		CheckList ("C:\Quick95\ALLCOMP")
		Exit Sub
	else
		If fso.FolderExists(Param) then
			CheckList (Param)
		else
			Select Case Ucase(Param)
				case "FL"
					CheckList ("C:\newqq95\allcomp")
				case "GA"
					CheckList ("C:\NEWQQGA\allcomp")
				case "TX"
					CheckList ("C:\Quick95\ALLCOMP")
				case else
					CheckList (".")
			End Select
		End If
	End If

End Sub

Sub CheckList (directory)
	If fso.FolderExists(directory) then
		Set Fldr 	= fso.GetFolder(directory)
		If fso.FileExists(directory & "\case.ini") Then
			Set inFile 	= fso.OpenTextFile(directory & "\case.ini", 1)
			Set outFile 	= fso.CreateTextFile(directory & "\DIff.ini", True)
			nLine = true	' var keeping track if is needed  to read Next Line in the INI file
			For Each File In Fldr.Files							'Loop through all files in the folder
				If (UCase(Right(File,4)) = ".PAS") then
					Do
						If inFile.AtEndOfStream then Exit For
						If nLine then dLine = inFile.ReadLine
						nLine = true
						If fso.FileExists(dLine) then
							deleted = false
							If File <> dline then 						'Check files against the ini file
								If UCase(File) = UCase(dline)  then
									outFile.WriteLine(File & "	" & dLine )
								Else
									outFile.WriteLine(File & "	" & "  <- This file was Added" )
									nLine = false
								End If
							End If
						Else
							If dLine <> "" then outFile.WriteLine("  This file was deleted ->   " & "	" & dLine )
							deleted = true
						End If
					Loop while deleted
				End If
			Next
			inFile.Close
			outFile.Close
			Set DIffFile = fso.GetFile(directory & "\DIff.ini")
			initSize = DIffFile.size
			If  ( initSize > 0 ) then
				objShell.Run "notepad.exe " & directory & "\DIff.ini"
			else
				DIffFile.Delete true   '// If the file is Size = 0 delete it!
			end If
		else
			MsgBox "File does NOT exist! Please check the path :" & VbCrLf & directory & "\case.ini"
		end If
	Else
		MsgBox "Folder does NOT exist! Please check the path :" & VbCrLf & directory
	End If
End Sub

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
		If fso.FileExists(dFile.ParentFolder & "\case.ini") Then
			'Change to proper case based on case.ini
			Set inFile 	= fso.OpenTextFile(dFile.ParentFolder& "\case.ini", 1)
			Do until inFile.AtEndOfStream
				ThisLine = inFile.ReadLine
				If Ucase(ThisLine) = Ucase(File) then
					cFile = ThisLine
					Exit Do
				End If
			Loop
		End If
		If cFile =  "" then
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
		End If
		'Wscript.Echo dFile.Name &" = " & vbcrlf & cFile
		If cFile <> dFile.Name then
		dFile.Move cFile
		objShell.SendKeys "{F5}"
		End IF
		Set dFile = Nothing
	Else
		Wscript.Echo "File not Found! " & vbcrlf & File
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
	RegProg = "wscript " & myFile & " /R ""%1"""
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
