dMessage = ""
dLast = 89
dMin = 64
a = now
ReDim arrNames(dLast-dMin)

Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
I = dMin
Do
    For Each objclass in objWMI.SubclassesOf()
        With objClass.Path_
        If (Left(.Class,6) = "Win32_") and (Len(.Class) < 35) Then
            For each strItem in objWMI.Get(.Class).properties_
                dLen = Len(strItem.name)
                If (dLen < 25) and (dLen > 4) Then
                    dAsc = Asc(Left(strItem.name,1)) - dMin
                    If dAsc <= (dLast - dMin) Then
                        If (arrNames(dAsc) = "") Then
                            arrNames(dAsc) = strItem.name & _
                            String(35 - dLen," ") & vbTab & .Class 
                            I = I + 1
                            Exit For
                        End IF
                    End IF
                End IF
            Next
            If (I >= dLast) Then Exit For
        End If
        End With
    Next
Loop Until (I >= dLast)

For Each item in arrNames
    Wscript.Echo item
Next
