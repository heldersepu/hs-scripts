On Error Resume Next
a = 5
b = 6
c = "seven"
d = 8

x = a + b
x = x + c
x = x + d

Wscript.Echo x

If Err.Number <> 0 Then
	Wscript.Echo "An error has occurred." 
End If 
