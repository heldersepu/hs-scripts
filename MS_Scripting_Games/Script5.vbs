'If has args then get the first
If (WScript.Arguments.Count > 0) then 
    dDate = WScript.Arguments.Item(0)
Else
    'Ask  for a Date
    dDate = inputBox("Please enter a date (March 3, 2008)")
End If
'Check for date
If (dDate <> "") then
    dMessage = ""    
	'returns  days difference
    dDays = DateDiff("d",Date,dDate)
	'returns  months difference
    dMont = DateDiff("m",Date,dDate)
	'compare months
    If dMont = 0 then
        dDaysMont = dDays
        dMontDays = 0
    else
        dMontDays = dMont 'Substract only if today's day is higher 
        If Day(Date) > Day(dDate) then dMontDays = dMont -1
        dDaysMont = DateDiff("d",DateAdd("m",dMontDays ,Date),dDate)
    End If
    
    dMessage =  "Days: " & dDays & VbCrLf
    dMessage = dMessage & "Months: " & dMont & VbCrLf
    dMessage = dMessage & "Months/Days: "  & dMontDays & " / " & _
               dDaysMont & VbCrLf
    
    Wscript.Echo dMessage
End If
