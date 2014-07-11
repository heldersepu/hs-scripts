Set fso = CreateObject("Scripting.FileSystemObject")
'ScriptFullName property is read only and returns 
'the full path to the script currently being executed
Set inFile = fso.OpenTextFile(WScript.ScriptFullName, 1)
dCounter = 0
'read the file until the end and count the characters 
Do until (inFile.AtEndOfStream)
    dLine = (inFile.ReadLine)
    dCounter = dCounter + Len(dLine)
Loop
inFile.close
'Display  the results 
Wscript.Echo "The Script: " & VbCrLf & _
             WScript.ScriptFullName &  VbCrLf & _
              "has " & dCounter & " characters"
