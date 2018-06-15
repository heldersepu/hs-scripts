Set fso  = CreateObject("Scripting.FileSystemObject")
myDir    = "C:\Quick95\COMPZIPS"
Set Fldr = fso.GetFolder(myDir)

Set outFile = fso.CreateTextFile("ALL.SQL", True)
For Each File In Fldr.Files
	If Right(UCase(File.Path),4) = ".DBF" and Len(File.Name) = 8 then
		outFile.WriteLine("SELECT ZIPCODE, CITY, COUNTY, """ & Left(File.Name,4) & """ AS NAME FROM """ & File.Path & """" )
		outFile.WriteLine("WHERE CITY <> " & CHR(34)&CHR(34) & " OR COUNTY <> " & CHR(34)&CHR(34) )
		outFile.WriteLine("UNION")
	End If
Next
outFile.Close
