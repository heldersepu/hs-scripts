'Compile all Delphi Source files in batch mode

Set fso = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

' Input via Arguments
If WScript.Arguments.Count > 0 then
	Select Case UCase(WScript.Arguments.Item(0))
		Case "GA", "/GA"
			Call myCompile("c:\NewqqGA\allcomp")
			Call CheckCompile
		Case "TX", "/TX"
			Call myCompile("c:\Quick95\allcomp")
			Call CheckCompile
		Case "FL", "/FL"
			Call myCompile("c:\newqq95\allcomp")
			Call CheckCompile
		Case "ALL", "/ALL"
			Call myCompile("c:\NewqqGA\allcomp")
			Call myCompile("c:\newqq95\allcomp")
			Call myCompile("c:\Quick95\allcomp")
			Call CheckCompile
		Case "-?", "/?"
			objShell.Run "notepad C:\bat\Joe\Commands\Build All.vbs"
		Case Else
			objShell.Run "C:\bat\Joe\Commands\CompileAll.bat"
	End Select
Else
	objShell.Run "C:\bat\Joe\Commands\CompileAll.bat"
End if

'Compile all .PAS files in given folder
Sub myCompile (dFolder)
	dFiles = ""
	cmplog = dFolder & "\Compile.txt"
	'Change the Active directory
	objShell.CurrentDirectory = dFolder
	'Delete the report File if it exists
	If fso.FileExists(cmplog) Then fso.DeleteFile(cmplog)
	'Get all the .Pas files
	Set Fldr = fso.GetFolder(dFolder)
	For each file in Fldr.files
		If Ucase(Right(File.Name, 4)) = ".PAS" Then
			dFiles = dFiles & File.Name & " "
		End if
		If Len(dFiles) > 1500 then
			objShell.Run "dcc32 " & dFiles & " -B -w- -h-  >> " & cmplog
			dFiles = ""
		End if
	Next

	If dFiles <> "" then
		objShell.Run "dcc32 " & dFiles & " -B -w- -h-  >> " & cmplog
	End If
End Sub

Sub CheckCompile
	' // Wait until Job is done
	Do
	  Wscript.Sleep 1000
	  WaitExp = objShell.AppActivate("dcc32.exe")
	Loop While WaitExp = False
	objShell.Run "C:\bat\Joe\Commands\CheckAll.vbs /S"
End Sub
