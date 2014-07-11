' Sample Using Arrays

Dim myArray(2)
myArray(0) = "Clean Under Water"
myArray(1) = "Vacuum Cleaner"
myArray(2) = "New Computer"
For Each present In myArray
	Wscript.Echo present
Next

ExtArray = Array("lnk", "vbs", "exe")
For Each present In ExtArray
	Wscript.Echo present
Next
