'Try all possible combinations of operators and output the ones that satisfy the equation

strOper = "12?8?4?2?9=23"
X = Len(strOper)
Op = 0
J = 0
Redim dNum(X)
'Extract the numbers 
For I = 1 to X
    dChar = mid(strOper,I,1)
    If IsNumeric(dChar) then
        Temp = Temp & dChar
    Else
		If dChar = "?" then Op = Op + 1
        J = J + 1
        dNum(J) = cInt(Temp)
        Temp = ""
    End If
Next
dNum(J+1) = cInt(Temp)
Temp = ""

'Try all possible combinations
Redim dOper(Op)
For I = 0 to Op^Op - 1
	Temp = dNum(1)
	For J = 0 to Op - 1
		X = (I \ Op^J ) mod 4
		Select Case X
			Case 0
				Temp = Temp & " + " & dNum(J+2) 
			Case 1
				Temp = Temp & " - " & dNum(J+2) 
			Case 2
				Temp = Temp & " * " & dNum(J+2) 
			Case 3
				Temp = Temp & " / " & dNum(J+2) 
		End Select
	Next
	Execute "total="&Temp
	If total = dNum(J+2) then   
		Wscript.echo temp &" = "& dNum(J+2)
	End If 
	'Wscript.echo temp & "	-> " & total
Next

