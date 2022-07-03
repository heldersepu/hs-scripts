Set fso = CreateObject("Scripting.FileSystemObject")
Set inFile = fso.OpenTextFile("C:\Scripts\skaters.txt", 1)

GoldAve = 0
SilvAve = 0
BronAve = 0

'Read all lines in the file
Do until (inFile.AtEndOfStream)
  dLine = trim(inFile.ReadLine)
  dAve = doAverage(dLine,dName)
' check who has the  highest score
  If dAve > GoldAve then
    GoldAve = dAve
    GoldName = dName
  Else
    If dAve > SilvAve then
      SilvAve = dAve
      SilvName = dName
    Else
      If dAve > BronAve then
        BronAve = dAve
        BronName = dName
      End IF
    End IF
  End IF
Loop
inFile.Close
'Output the medal list
wscript.Echo "Gold medal:   " & GoldName & ", " & GoldAve & VbCrLf & _
             "Silver medal: " & SilvName & ", " & SilvAve & VbCrLf & _
             "Bronze medal: " & BronName & ", " & BronAve


'Calculate the average and return the name
Function doAverage(strWord, strName)
  intTotal = 0
  intCount = 0
  dMin = -1
  dMax = -1
  isFirst = True
  'Loop trough all items of the line
  For each item in Split(dLine,",")
    ' first element is always the name
    If isFirst then
      strName = item
      isFirst = False
    Else
        ' Be sure the item is a number
      If Isnumeric(item) then
        intCount = intCount + 1
        intTotal = intTotal + item
            ' Check  which  number is the biggest one
        If (item > dMax) or (dMax = -1) then
          dMax = item
        End If
            'chek what  number is smallest one
        If (item < dMin) or (dMin = -1) then
          dMin = item
        End If
      End if
    End If
  Next
  'Calculate the average
  'At the total is subtracted bigget and smallest  number ,
  'the result is divided by  the numbers of score minus 2
  doAverage = (intTotal - dMax - dMin)/(intCount - 2)
End Function
