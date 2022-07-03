arrFrames = Array(2,5,7,"/",8,1,"X",9,"/",5,3,7,0,4,5,"X",2,0)
'arrFrames = Array("X","X","X","X","X","X","X","X","X",2,0)

dTotal = 0
count = 0
For Each item In arrFrames
    Select case UCase(item)
        Case "X"
            intPoints = 10 + Bonus(count + 1) + Bonus(count + 2)
        Case "/"
            intPoints = (10 - arrFrames(count - 1)) _
                         + Bonus(count + 1)
        Case Else
            intPoints = item
    End Select
    dTotal = dTotal + intPoints
    count = count + 1
Next

Wscript.Echo dTotal

Function Bonus(intPos)
    If intPos <= Ubound(arrFrames) then
        Select case UCase(arrFrames(intPos))
            Case "X"
                Bonus = 10
            Case "/"
                Bonus = (10 - arrFrames(intPos - 1))
            Case Else
                Bonus = arrFrames(intPos)
        End Select
    Else
        Bonus = 0
    End If
End Function
