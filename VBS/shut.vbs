'ShutDown the PC after a given Delay

Set objShell = CreateObject("WScript.Shell")

If WScript.Arguments.Count > 0 Then
    If WScript.Arguments.Item(0) = "/?" then
		objShell.Run "notepad " & wscript.ScriptFullName
	Else
		myDelay = WScript.Arguments.Item(0)
	End If
Else
	myDelay = InputBox ("Please enter delay in seconds" & VbCrLf & _
						 VbCrLf & "    1H = 3600 Seconds" & VbCrLf & _
								  "    1M = 60 Seconds"," Time Delay", "1H" )
End If
myDelay = Trim(myDelay)

If myDelay <> "" Then
	If IsNumeric(myDelay) then
		myDelay = myDelay * 1000
	Else
		LastChar = UCase(Right(MyDelay,1))
		myDelay  = Left(MyDelay,Len(MyDelay)-1)
		If IsNumeric(myDelay) then
			Select Case LastChar
			Case "H"
				myDelay = myDelay * 3600000
			Case "M"
				myDelay = myDelay * 60000
			Case Else
				MsgBox "Incorrect Delay " & myDelay & LastChar
				Wscript.Quit
			End Select
		Else
			MsgBox "Incorrect Delay " & myDelay
			Wscript.Quit
		End If
	End If

	WScript.Sleep myDelay
	objShell.Run "shutdown /s /t: 60"
End If

Set objShell = Nothing
