dFile = "C:\Scripts\votes.txt"
dWinner = ""
dEliminated = ""
intCandidates = 4

Do
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set inFile = fso.OpenTextFile(dFile, 1)
    TotalVotes = 0
    ReDim myCandid(intCandidates,2)

    Do until (inFile.AtEndOfStream)
        TotalVotes = TotalVotes + 1
        dLine = trim(inFile.ReadLine)
        For each item in Split(dLine,",")
            dCandidate = Trim(item)
            'Check that the candidate was not eliminated
            If InStr(dEliminated, dCandidate) = 0 then
                'Count the candidate's vote
                For I = 1 to intCandidates
                    If (Ucase(dCandidate) = Ucase(myCandid(I,1))) or _
                       (myCandid(I,1) = "") then
                        myCandid(I,1) = dCandidate
                        myCandid(I,2) = myCandid(I,2) + 1
                        Exit For
                    End If
                Next
                Exit For
            End If
        Next
    Loop
    inFile.Close

    Call doSort(myCandid)

    'my Debuging...
    'For I = 1 to intCandidates
    '    Wscript.Echo I & " - " & myCandid(I,1) & " - " & myCandid(I,2)
    'Next
    'Wscript.Echo " " & TotalVotes

    dPerc = (myCandid(1,2)*100)/TotalVotes
    If dPerc > 50 then
        dWinner = myCandid(1,1)
    Else
        dEliminated = dEliminated & myCandid(intCandidates,1)
        intCandidates = intCandidates -1
    End If
Loop While (dWinner = "") and (intCandidates > 0)

If dWinner <> "" Then
    Wscript.Echo "The winner is " & dWinner & " with " & dPerc & "% of the vote."
Else
    Wscript.Echo "No candidate with more than 50% of the vote "
End IF

Function doSort(dArray)
    For I = 1 to intCandidates - 1
        For J = I + 1 to intCandidates
            'Compare the counted votes
            If (dArray(I,2) < dArray(J,2)) then
                'Swap Items
                Temp1 = dArray(I,1)
                dArray(I,1) = dArray(J,1)
                dArray(J,1) = Temp1

                Temp2 = dArray(I,2)
                dArray(I,2) = dArray(J,2)
                dArray(J,2) = Temp2
            End IF
        Next
    Next
End Function

