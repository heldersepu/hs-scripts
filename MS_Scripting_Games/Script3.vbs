directory = "C:\Scripts\"
Set objFSO = CreateObject("Scripting.FileSystemObject")
If Not objFSO.FolderExists("C:\Temp") then objFSO.CreateFolder("C:\Temp")
Set objOutputFile = objFSO.CreateTextFile("C:\Temp\Newfile.txt")
Set Fldr = objFSO.GetFolder(directory)

' -- Get all files in the folder
For Each File In Fldr.Files
   If Ucase(Right(File,4)) = ".TXT" then
     Set inFile = objFSO.OpenTextFile(File, 1)
     dline = inFile.readline
     objOutputFile.writeline dline 
     inFile.close
   end  if
next
objOutputFile.close

 