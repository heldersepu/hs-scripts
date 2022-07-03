'The calculator accepts non-standard roman numerals such as IM and IIII
Wscript.StdOut.Write "Please enter a Roman numeral "
RomanNum = Wscript.StdIn.ReadLine
dLen = Len(RomanNum)
Redim arArabic (dLen)
For I = 1 to dLen
	Select Case Ucase (Mid(RomanNum,I,1))
	Case "I"
		arArabic(I) = 1
	Case "V"
		arArabic(I) = 5
	Case "X"
		arArabic(I) = 10
	Case "L"
		arArabic(I) = 50
	Case "C"
		arArabic(I) = 100
	Case "D"
		arArabic(I) = 500
	Case "M"
		arArabic(I) = 1000
	Case Else
		Wscript.StdOut.WriteLine "You enter an invalid Roman numeral "
		Wscript.Quit
	End Select
Next

ArabicNum = arArabic(dLen)
For I = 1 to dLen -1
    If  arArabic(I) >= arArabic(I+1) then
		ArabicNum = ArabicNum + arArabic(I)
	Else
		ArabicNum = ArabicNum - arArabic(I)
	End If
Next


Wscript.StdOut.WriteLine ArabicNum