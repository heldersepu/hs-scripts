Dim A(20)
For I = 0 to 19
	Select case (I Mod 4)
		Case 0 A(I)="Yellow ***"
		Case 1 A(I)="Red"
		Case 2 A(I)="Blue      ===="
		Case 3 A(I)="Green      %%"
	End Select
Next

For I = 0 to 19
	Wscript.Echo I&"	"& A(I)
Next
Wscript.Echo "   ************"
For I = 0 to 19
	Do
		RndNR = (Timer*Rnd) Mod 20
		IF A(RndNR) = "" then Wscript.Echo "Duplicate " & RndNR
	Loop While A(RndNR) = ""
	Wscript.Echo I &" 	"& RndNR &" 	- "& A(RndNR)
	A(RndNR)= ""
Next
