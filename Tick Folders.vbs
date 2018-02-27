'// Tick all folders 

Set fso = CreateObject("Scripting.FileSystemObject")
' Input via Arguments
If WScript.Arguments.Count > 0 then
	For I = 0 to WScript.Arguments.Count - 1		
		If 	fso.FolderExists(WScript.Arguments.Item(I)) Then
			fso.CreateFolder(WScript.Arguments.Item(I) & "\tick")
			fso.DeleteFolder(WScript.Arguments.Item(I) & "\tick")
		End if		
	Next
Else
	Wscript.Echo "Pass folders in the Arguments"
End If
