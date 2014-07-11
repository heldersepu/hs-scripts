result = MsgBox("Do you want to continue?",vbYesNo,"Continue Processing")
If result = vbYes then
	MsgBox "Yes – Processing will continue..."
Else
	MsgBox "No – Processing stopped"
End If
