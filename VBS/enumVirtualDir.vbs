Set fso  = CreateObject("Scripting.FileSystemObject")
Set HtmlFile = fso.CreateTextFile("virtualDirectory.xml", True)

Set objWMIService = GetObject("winmgmts:{authenticationLevel=pktPrivacy}\\.\root\microsoftiisv2")
Set colItems = objWMIService.ExecQuery("Select * from IIsWebVirtualDirSetting")
strLast = ""
For Each objItem in colItems
	if strLast <> Left(objItem.Name,8) then
		HtmlFile.WriteLine("")
	end if
	strLast = Left(objItem.Name,8)
	HtmlFile.WriteLine("<virtualDirectory path=""" & objItem.Name & """ physicalPath=""" & objItem.Path & """ />")
Next

HtmlFile.Close

