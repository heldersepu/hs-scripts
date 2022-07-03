'//Clear the file attributes in the given directories

Set objfso 	= CreateObject("Scripting.FileSystemObject")
clearAtrib("C:\QUICK95\allcomp")
clearAtrib("C:\NEWQQGA\allcomp")
clearAtrib("C:\Quick95\ALLCOMP")

Sub clearAtrib(Source)
	Set Fldr = objFSO.GetFolder(Source)
	For Each File In Fldr.Files
		File.attributes = 0
	Next
End Sub
