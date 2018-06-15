' Change the date to the provided date, also stops the windows time service
' It takes 2 different arguments a date or the amount of days
' Ex:  cdate 01/26/2007

On Error Resume Next
Set objShell    = CreateObject("WScript.Shell")

If WScript.Arguments.Count > 0  Then
    If WScript.Arguments.Item(0) = "/?" then 
		objShell.Run "notepad " & wscript.ScriptFullName
		Wscript.Quit
	Else
		nDays = WScript.Arguments.Item(0)
	End If
Else
	nDays = InputBox (vbcrlf & "Please enter amount of days or the date in format: (mm/dd/yyyy)","  Time Machine")
End If

'If a date is entered then convert to days from today's date
If IsDate(nDays) then nDays = DateDiff("d",Date,nDays)

If IsNumeric(nDays) and nDays <> "" then
	'Stop  Windows Time Service
	Set objWMISrv = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	Set colCompSys = objWMISrv.ExecQuery  ("Select * from Win32_Service where Name='w32time'")
	For Each objCompSys in colCompSys
		If nDays = 0 then 
			errReturn = objCompSys.StartService()
		Else
			errReturn = objCompSys.StopService()
		End If
	Next
	'Change Date 
	Set fso  = CreateObject("Scripting.FileSystemObject")
	If nDays = 0 then
		If fso.FileExists("C:\WINDOWS\system32\dDate.ini") Then
			'Go back to the original Date & delete backup file
			Set inFile 	= fso.OpenTextFile("C:\WINDOWS\system32\dDate.ini", 1)
			nDays = inFile.ReadLine
			inFile.Close
			objShell.Run "%comspec% /c  date " & nDays
			fso.DeleteFile("C:\WINDOWS\system32\dDate.ini")
		End If
	Else
		If Not fso.FileExists("C:\WINDOWS\system32\dDate.ini") Then
			'BackUp  current date into a Text file 
			Set outFile = fso.CreateTextFile("C:\WINDOWS\system32\dDate.ini", True)
			outFile.WriteLine(Now)
			outFile.Close
		End If
		objShell.Run "%comspec% /c  date " & Now + nDays

	End If
Else
	If nDays <> "" then
		MsgBox 	"The value you enter is not numeric" & vbcrlf &_
				"              Please try again!"
	End If
End If