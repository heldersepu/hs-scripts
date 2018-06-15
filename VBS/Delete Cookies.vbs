
Set fso = CreateObject("Scripting.FileSystemObject")
dFolder = "C:\Documents and Settings\hsepulveda\Local Settings\Temporary Internet Files"

Set Fldr = fso.GetFolder(dFolder)
For each file in Fldr.files
	If Ucase(Left(File.Name, 6)) = "COOKIE" Then
		wscript.echo file
		fso.DeleteFile(file)
	End if
	wscript.echo file
Next
