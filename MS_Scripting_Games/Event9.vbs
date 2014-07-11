Set filesys = CreateObject("Scripting.FileSystemObject")
ReadFile("wo.txt")


Sub ReadFile(dfile)
	If filesys.FileExists(dfile) Then
		Set ObjFile = filesys.OpenTextFile(dfile, 1)
		
		Do until (objFile.AtEndOfStream)
			dLine = objFile.ReadLine
			Redim A(Len(Dline))
			For I = 1 to Len(Dline)
				A(I) = mid(Dline,I,1)
				'Wscript.Echo A(I)
			Next
			x = 2
			Do Until Temp = Dline
				Temp = ""
				For I = 0 to Len(Dline)
					Temp = Temp & A((I+x) mod (Len(Dline)+1))
				Next
				x = x + 1
				Wscript.Echo Temp
			Loop 
			Wscript.Echo " ------"
		Loop
		ObjFile.Close
	End If
End Sub 