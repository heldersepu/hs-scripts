dMaxTeams = 6
dSepa = " vs. "

'Load all the teams into the Array
ReDim arrTeams(dMaxTeams)
For I = 1 to dMaxTeams
    arrTeams(I) = Chr(64 + I)
Next

'Every team plays each of the other teams once
match = 0
For I = 1 to dMaxTeams - 1
    For J = I + 1 to dMaxTeams
        match = match + 1
        ReDim Preserve arrGames(match)
        arrGames(match) = arrTeams(I) & dSepa & arrTeams(J)
    Next
Next

'randomly schedule the games
ReDim arrRndGames(match)
For I = 1 to match
    intRep = 0
    Do
        If intRep > 5 then
            dRnd = (dRnd + 1) Mod Match
        Else
            dRnd = ((Timer*Rnd) Mod match) +1
            intRep = intRep + 1
        End If
        'Avoid the same team
        isBlank = arrGames(dRnd) = ""
        If (I > 1) and (I < match\2) and Not isBlank then
            dCurr = Split(arrGames(dRnd), dSepa)
            dPrev = Split(arrRndGames(I-1), dSepa)
            SameTeam = (InStr(dPrev(0)&dPrev(1), dCurr(0)) > 0) or _
                       (InStr(dPrev(0)&dPrev(1), dCurr(1)) > 0)
        Else
            SameTeam = False
        End If
    Loop While isBlank or SameTeam

    arrRndGames(I) = arrGames(dRnd)
    arrGames(dRnd) = ""
Next

'Display the final Schedule
For I = 1 to match
    Wscript.Echo arrRndGames(I)
Next
