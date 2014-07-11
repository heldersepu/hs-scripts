'// Create HTML Shortcut for given Folders

Set fso = CreateObject("Scripting.FileSystemObject")
' Input via Arguments
If WScript.Arguments.Count > 0 then
	For I = 0 to WScript.Arguments.Count - 1		
		If 	fso.FolderExists(WScript.Arguments.Item(I)) Then
			Call CreateFile(WScript.Arguments.Item(I))
		End if		
	Next
Else
	Wscript.Echo "Pass folders in the Arguments"
End If

Function CreateFile(strFolder)
	Set outFile = fso.CreateTextFile(strFolder & "\Shortcut to My Testing.html", True)
	outFile.WriteLine("<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">")
	outFile.WriteLine("<HTML><HEAD>")
	outFile.WriteLine("<meta http-equiv=""REFRESH"" content=""0;url=" & strFolder & """>")
	outFile.WriteLine("</HEAD><BODY>")
	outFile.WriteLine("<H2>Please open link with Internet Explorer</H2>")
	outFile.WriteLine("<a href=""" & strFolder & """>")
	outFile.WriteLine(strFolder & "</a>")
	outFile.WriteLine("</BODY></HTML>")
	outFile.Close
	Set outFile = Nothing
End Function
