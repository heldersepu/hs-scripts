'Ask  for a phone number
dPhone = inputBox("Please enter 7 digit Phone Number")

If (Len(dPhone) = 7) and isNumeric(dPhone) then
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set inFile = fso.OpenTextFile("C:\Scripts\WordList.txt", 1)
  'Read all lines in the file
  wordFound = false
  Do until (inFile.AtEndOfStream or wordFound)
    dLine = trim(inFile.ReadLine)
    'look for a match
    If Len(dLine) = 7 then
      If dPhone = ConvertToNum(dLine) then
        Wscript.Echo dLine
        wordFound = true
      end if
    end if
  Loop

  if not wordFound then
    Wscript.Echo "No word found in the list"
  end if
  inFile.Close
Else
  Wscript.Echo "Wrong phone Number"
End If

'Function converts a word to Phone munber
Function ConvertToNum(strWord)
    temp = ""
    for i = 1 to Len(strWord)
      dChar = Mid(strWord,i,1)
      Select Case UCase(dChar)
        Case "A", "B", "C"
          temp = temp & "2"
        Case "D", "E", "F"
          temp = temp & "3"
        Case "G", "H", "I"
          temp = temp & "4"
        Case "J", "K", "L"
          temp = temp & "5"
        Case "M", "N", "O"
          temp = temp & "6"
        Case "P", "R", "S"
          temp = temp & "7"
        Case "T", "U", "V"
          temp = temp & "8"
        Case "W", "X", "Y"
          temp = temp & "9"

      End Select
    next
    ConvertToNum = Temp
End Function
