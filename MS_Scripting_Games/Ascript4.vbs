
dSepa = " " & Chr(9)
myDate = inputBox("Please enter month and a Year (mm/yyyy)")
posSlash = inStr(myDate,"/")
'Date must contain Slash & be 7 chars ()mm/yyyy)
If (posSlash <> 0) and (Len(myDate) < 8) then
    dMont = Mid(myDate,1,posSlash-1)
    If Left(dMont,1) = 0 then dMont = Right(dMont,1)
    dYear = Mid(myDate,posSlash+1)
    dOutput = dOutput & MonthName(dMont)  & " " & dYear & VbCrLf & VbCrLf
    'Days of the week
    For I = 1 to 7
        dOutput = dOutput & WeekdayName(I,true) & dSepa
    Next
    dOutput = dOutput & VbCrLf

    myDate = (dMont & "/1/" & dYear)
    LendMont = Len(dMont)
    For I = 0 to 31
        NewDate = DateAdd("D", I, myDate)
        If Left(NewDate,LendMont) = dMont then
            'WScript.Echo "True " & WeekDay(NewDate) & " " & NewDate
            If I = 0  then
                For J = 1 to WeekDay(NewDate)-1
                    dOutput = dOutput & "   " & dSepa
                Next
            End If
            dOutput = dOutput & I + 1 & dSepa
            If WeekDay(NewDate) = 7 then
                dOutput = dOutput & VbCrLf
            End If
        Else
            Exit For
        End If
    Next

    Wscript.Echo dOutput
Else
    Wscript.Echo "Incorrect Date Format"
End If