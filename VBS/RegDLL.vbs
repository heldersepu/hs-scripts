Set WshShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
' Array with all the extensions to add the Context Menu
ExtArray = Array("ocx", "dll")

AskDo = MsgBox("Do you want to add a right-click context menu item to " &_
   vbcrlf &"Register and Unregister .dll and .ocx files?",4,"Context Menu")
If AskDo = VbYes Then
	'Set path for Regsvr32.exe and make sure it exists.
	RegSvr = fso.GetSpecialFolder(1) & "\REGSVR32.EXE"
	If not fso.FileExists(RegSvr) Then
		MsgBox "Error.  Could not locate RegSvr32.exe."
	Else
		For Each dExt In ExtArray
			DllReg = "HKCR\" & dExt & "file\shell\"
			'Add the Register context menu item.
			WshShell.RegWrite DllReg & "Register\","Re&gister " & UCase(dExt)
			WshShell.RegWrite DllReg & "Register\command\",_
			  RegSvr & " " & Chr(34) &  "%1" & Chr(34)
			'Add the Unregister context menu item.
			WshShell.RegWrite DllReg & "UnRegister\","&UnRegister " & UCase(dExt)
			WshShell.RegWrite DllReg & "UnRegister\command\",_
			  RegSvr & " /u " & Chr(34) &  "%1" & Chr(34)
		Next
	End If
End If
