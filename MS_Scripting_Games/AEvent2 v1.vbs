'148148 * 3 = 444444   ->  148148 * 3 = 4 *111111
For I = 1 to 148148
    Num = 0
	For J = 0 to Len(I)-1
		Num = Num + 10^J
	Next

	If I*3 = Num*4 then
		wscript.echo I
		wscript.quit
	End If
Next
