'Check that all reference files exist 

Set fso = CreateObject("Scripting.FileSystemObject")
myFile = "C:\vbscript\references.txt"


'Read all the input File
Set inFile = fso.OpenTextFile(myFile, 1)
txtFile = inFile.ReadAll : inFile.Close
Set inFile  = Nothing

For each dLine in Split(txtFile, VbCrLF)
    dLine = trim(dLine)
    If UCase(Left(dLine, 3)) = "C:\" then 
        If not FSO.FileExists(dLine) then 
            msgBox("File not Found: " & VBCRLF & dLine)
        End If
    End If    
Next