Set fso = CreateObject("Scripting.FileSystemObject")
Set inFile = fso.OpenTextFile("C:\Scripts\Coffee.txt", 1)
TotCapp = 0
TotEspr = 0
TotLatte = 0

 Do until (inFile.AtEndOfStream)
    dLine = trim(inFile.ReadLine)
	dAmount = Right(dLine,len(dLine) - instr(dLine," "))
	dCoffe = UCase(Left(dLine,instr(dLine," ")-1))

	Select Case dCoffe
		Case "ESPRESSO"
			TotEspr = TotEspr + dAmount
		Case "CAPPUCCINO"
			TotCapp = TotCapp + dAmount
		Case "LATTE"
			TotLatte = TotLatte + dAmount
	End Select

Loop

Wscript.Echo "ESPRESSO = "  & TotEspr & VbCrLf & _
             "CAPPUCCINO = "  & TotCapp & VbCrLf & _
             "LATTE = "  & TotLatte
