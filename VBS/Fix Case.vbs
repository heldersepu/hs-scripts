'Rename ALL files to lcase
'On Error Resume Next

If WScript.Arguments.Count = 0 Then
	Set FSO = CreateObject("Scripting.FileSystemObject")

	Dim myArray(3)
	    myArray(0) = "C:\QuickFL\qqfl.mdb"
	    myArray(1) = "C:\QuickFL\qqflc.mdb"
	    myArray(2) = "C:\QuickGA\qqga.mdb"
	    myArray(3) = "C:\QuickTX\qqtx.mdb"

	For Each strFile In myArray
		Set myFile = FSO.GetFile(strFile)
		Call myFile.Move(LCase(myFile.Path))
	Next
Else
	Set objShell = CreateObject("WScript.Shell")
	objShell.Run "notepad++ Fix Case.vbs"
	Set objShell = Nothing
End If
