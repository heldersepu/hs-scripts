dMax = 200

For I = 2 to dMax
    If IsPrime(I) then
        WScript.Echo I
    End If
Next

'Function that check if is a Prime #
Function IsPrime(intNum)
    blnTemp = True
    If intNum > 2 then
        For J = 2 to intNum\2
            If (intNum mod J = 0 ) then
                blnTemp = False
                Exit For
            End If
        Next
    End If
    IsPrime = blnTemp
End Function
