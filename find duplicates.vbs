' Find Continuous duplicates in the file

Set filesys = CreateObject("Scripting.FileSystemObject")

mfile = InputBox (vbcrlf & "Please enter File to Check","  Duplicates finder")
if filesys.FileExists(mfile) Then
	Set db      = filesys.OpenTextFile(mfile, 1)
	Set outFile = filesys.CreateTextFile(mfile & "_Dup.txt", True)
	ThisLine = db.ReadLine
	Do until (db.AtEndOfStream)
		NextLine = db.ReadLine
		if ThisLine = NextLine then 	outFile.WriteLine(Thisline)
		ThisLine = NextLine
	Loop
	outFile.Close
else 
	msgbox "File not Found"
end if
