'148148 * 3 = 444444   ->   444444 mod 3 = 0
X = 4
Do
	If X mod 3 = 0 Then
		Wscript.Echo X/3
		Wscript.Quit
	End If
	X = (X*10) + 4
Loop While (X < 444444)
