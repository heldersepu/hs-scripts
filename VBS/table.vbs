Set filesys = CreateObject("Scripting.FileSystemObject")
if filesys.FileExists("mult.txt") Then
	Set outFile = filesys.CreateTextFile("table.txt", True) 
	
	for i = 1 to 9
		for j = 1 to 9
			outFile.WriteLine("     " & i & " * " & j & " = " & i*j)
		next
		outFile.WriteLine("<-------------------->")
	next
	outFile.Close
end if
