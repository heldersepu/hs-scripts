'If has args then get the first
If (WScript.Arguments.Count > 0) then
    dPassw = WScript.Arguments.Item(0)
Else
    'Ask  for a Password
    dPassw = inputBox("Please enter your password")
End If

If (dPassw <> "") then
  dMessage = ""
  dScore = dComplex(dPassw, dMessage )
  Select Case dScore
    Case 11, 12, 13
        dMessage = dMessage & VbCrLf & "A password score of " & dScore & " indicates a strong password."
    Case 7, 8, 9, 10
        dMessage = dMessage & VbCrLf & "A password score of " & dScore & " indicates a moderately-strong password."
    Case Else
       dMessage = dMessage & VbCrLf & "A password score of " & dScore & " indicates a weak password."
  End Select

  Wscript.Echo dMessage

End If

'Function that check complexity
Function dComplex(strWord, strMessage)
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set inFile = fso.OpenTextFile("C:\Scripts\WordList.txt", 1)
    Temp = 13
    'Read all lines in the file
    wordFound1 = False
    srtComp1 = Ucase(strWord)
    wordFound2 = False
    srtComp2 = Ucase(Mid(strWord,1,Len(strWord)-1))
    wordFound3 = False
    srtComp3 = Ucase(Mid(strWord,2))
    wordFound4 = False
    srtComp4 = Replace(Ucase(strWord),"0","O")
    wordFound5 = False
    srtComp5 = Replace(Ucase(strWord),"1","L")

    Do until (inFile.AtEndOfStream )
        dLine = Ucase(inFile.ReadLine)
        'Make sure that the password is not an actual word.
        If dLine = srtComp1 then
            wordFound1 = True
        end if
        'Make sure that the password, minus the last letter, is not an actual word.
        If dLine = srtComp2 then
            wordFound2 = True
        end if
        'Make sure that the password, minus the first letter, is not an actual word
         If dLine = srtComp3 then
            wordFound3 = True
        end if
        'Make sure that the password does not simply substitute 0 (zero) for the letter o
        If (dLine = srtComp4) and (srtComp4 <> srtComp1) then
            wordFound4 = True
        end if
        'Make sure that the password does not simply substitute 1 (one) for the letter l
        If dLine = srtComp5 and (srtComp5 <> srtComp1) then
            wordFound5 = True
        end if
    Loop
    inFile.Close

    If (wordFound1) then
        strMessage = strMessage & "Password is an actual word." & VbCrLf
        Temp = Temp - 1
    End If

    If (wordFound2) then
        strMessage = strMessage & "Password minus the last letter, is an actual word." & VbCrLf
        Temp = Temp - 1
    End If

    If (wordFound3) then
        strMessage = strMessage & "Password minus the first letter, is an actual word." & VbCrLf
        Temp = Temp - 1
    End If

    If (wordFound4) then
        strMessage = strMessage & "Password simply substitute 0 (zero) for the letter o." & VbCrLf
        Temp = Temp - 1
    End If

    If (wordFound5) then
        strMessage = strMessage & "Password simply substitute 1 (one) for the letter l." & VbCrLf
        Temp = Temp - 1
    End If

    If Len(strWord)<10 or Len(strWord)>20 then
        strMessage = strMessage & "Password is NOT at least 10 characters long and no more than 20 long." & VbCrLf
        Temp = Temp - 1
    End If

    hasNumber = False
    hasLowerLetter = False
    hasUpperLetter = False
    has4LowerChar = False
    has4UpperChar = False
    hasSymbol = False
    UpChar = 0
    LoChar = 0

    For I = 1 to Len(strWord)
        dChar = Asc(Mid(strWord,I,1))

        If ((dChar >= 48) and (dChar =< 57)) then
            hasNumber = True
            UpChar = 0
            LoChar = 0
        Else
            If ((dChar >= 65) and (dChar < 90)) then
                hasUpperLetter = True
                UpChar = UpChar + 1
                If UpChar >= 4 then
                    has4UpperChar = True
                End If
                LoChar = 0
            Else
                If ((dChar >= 97) and (dChar =< 122)) then
                    hasLowerLetter = True
                    LoChar = LoChar + 1
                    If LoChar >= 4 then
                        has4LowerChar = True
                    End If
                    UpChar = 0
                Else
                    hasSymbol = True
                    UpChar = 0
                    LoChar = 0
                End If
            End If
        End If
    Next

    If not hasNumber then
        strMessage = strMessage & "Password does NOT include at least one number." & VbCrLf
        Temp = Temp - 1
    End If
    If not hasUpperLetter then
        strMessage = strMessage & "Password does NOT include at least one uppercase letter." & VbCrLf
        Temp = Temp - 1
    End If
    If not hasLowerLetter then
        strMessage = strMessage & "Password does NOT include at least one lowercase letter." & VbCrLf
        Temp = Temp - 1
    End If
    If not hasSymbol then
        strMessage = strMessage & "Password does NOT include at least one symbol." & VbCrLf
        Temp = Temp - 1
    End If
    If has4LowerChar then
        strMessage = strMessage & "Password includes four (or more) lowercase letters in succession." & VbCrLf
        Temp = Temp - 1
    End If
    If has4UpperChar then
        strMessage = strMessage & "Password includes four (or more) uppercase letters in succession." & VbCrLf
        Temp = Temp - 1
    End If

    DupChars = False
    For I = 1 to Len(strWord) - 1
        For J = I+1 to Len(strWord)
            If Mid(strWord,I,1) = Mid(strWord,J,1) then
                DupChars = True
                Exit For
            End If
        Next
        If DupChars then Exit For
    Next

    If DupChars then
        strMessage = strMessage & "Password includes duplicate characters." & VbCrLf
        Temp = Temp - 1
    End If

    dComplex = Temp
End Function
