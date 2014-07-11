'Launch a Torrent after a given delay

Set objShell = CreateObject("WScript.Shell")
Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
ObjFSO.Filter = "Torrent Files|*.torrent"
'ObjFSO.Flags = &H0200
ObjFSO.FilterIndex = 3
InitFSO = ObjFSO.ShowOpen

If ObjFSO.FileName <> "" Then
	myDelay = InputBox ("Please enter delay default is in seconds" & VbCrLf & _ 
						 VbCrLf & "    1H = 3600 Seconds" & VbCrLf & _
						          "    1M = 60 Seconds"," Time Delay",3600 )
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
		objShell.Run """" & ObjFSO.FileName & """"
	End If
End If 

Set objShell = Nothing
Set oShell = Nothing
