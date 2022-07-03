''**Convert the territory info files from Dairyland (Fl) to code format

Set filesys = CreateObject("Scripting.FileSystemObject")

mfile = InputBox (vbcrlf & "Please enter File to convert","  File Converter")
if filesys.FileExists(mfile) Then

  Set db      = filesys.OpenTextFile(mfile, 1)
  Set outFile = filesys.CreateTextFile(mfile & "2.txt", True)
  Do until (db.AtEndOfStream)
      ThisLine = db.ReadLine
      outFile.WriteLine(Right(left(Thisline,34),4))
      outFile.WriteLine(Right(left(Thisline,77),4))
      outFile.WriteLine(Right(Thisline,4))
  Loop
  outFile.Close
end if
