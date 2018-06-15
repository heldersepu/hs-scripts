'// Extract the contents of a ZIP file

Set objShell = CreateObject("Shell.Application")
myZipFolder = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	If Ucase(Right(WScript.Arguments.Item(0),4)) = ".ZIP" then
		myZipFolder = WScript.Arguments.Item(0)
	End if
End If
'Input via Explorer
If (myZipFolder = "") then
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	ObjFSO.Filter = "Zip File|*.zip"
	ObjFSO.FilterIndex = 3
	ObjFSO.ShowOpen
	myZipFolder = ObjFSO.FileName
End If

unzipdir = "c:\temp\"

If (myZipFolder <> "") then
	Set SrcFldr  = objShell.NameSpace(myZipFolder)
	Set DestFldr = objShell.NameSpace(unzipdir)
	If DestFldr is nothing then
		wscript.echo "Unzip Directory not found"
	else
		Set FldrItems=SrcFldr.Items
		For Each objItem in FldrItems
			DestFldr.CopyHere objItem , 8
		Next
		wscript.echo "All Done "
	end if
End If



