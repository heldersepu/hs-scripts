'Initialize Cards
Dim A(20)
For I = 0 to 19
	Select case (I Mod 4) 
		Case 0 A(I)="Yellow"
		Case 1 A(I)="Red"
		Case 2 A(I)="Blue"
		Case 3 A(I)="Green"
	End Select
Next 
'Randomly draw the card 
For I = 0 to 19
	RndNR = (Timer*Rnd) Mod 20
	Do While A(RndNR) = ""
		Wscript.Echo "Duplicate " & RndNR
		RndNR = (RndNR + 1) Mod 20
	Loop 	
	Wscript.Echo I &" 	"& RndNR &" 	- "& A(RndNR)
	A(RndNR)= ""
Next

