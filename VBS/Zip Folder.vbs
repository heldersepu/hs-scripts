'// Add all the files to a ZIP

Set objShell = CreateObject("Shell.Application")
myFolder = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	myFolder = WScript.Arguments.Item(0)
End If
'Input via Explorer
If (myFolder = "") then
	Set f = objShell.BrowseForFolder(0, "Choose a folder", 0, "c:\")
	If (Not f Is Nothing) Then
		myFolder = f.Items.Item.Path
	End if
End If

If (myFolder <> "") then
	MyZip = myFolder & ".ZIP"
	Call CreateZip(MyZip)
	Set SrcFldr  = objShell.NameSpace(myFolder)
	Set DestFldr = objShell.NameSpace(MyZip)
	If (DestFldr is Nothing) then
		wscript.echo "Unzip Directory not found"
	Else
		For Each objItem in SrcFldr.Items
			DestFldr.CopyHere objItem, 8
		Next
		
		Do Until SrcFldr.Items.Count = DestFldr.Items.Count
			WScript.Sleep 200
		Loop
	End if
End If


Sub CreateZip(dFile)
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set outFile = fso.CreateTextFile(dFile, True)
	outFile.Write "PK" & Chr(5) & Chr(6) & String(18, Chr(0))
	outFile.Close
	Set outFile = Nothing
	Set fso = Nothing
End Sub
