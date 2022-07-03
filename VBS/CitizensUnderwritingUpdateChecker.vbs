'um_personallines.cfm
'um_commerciallines.cfm
'um_wind_commercial.cfm
'um_wind_residential.cfm
'um_wind_residential_mobile.cfm


Set shell = createobject("WScript.shell")
Set objNet = CreateObject("WScript.NetWork")

dbLocation = "c:\CitizensUnderwritingUpdateChecker_db.txt"


checkScriptLocation()
Sub checkScriptLocation()
	Const START_MENU = &Hb&

	Set objShell = CreateObject("Shell.Application")
	set oShell = createobject("wscript.shell")
	Set objFolder = objShell.Namespace(START_MENU)
	Set objFolderItem = objFolder.Self
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFileCopy = objFSO.GetFile(Wscript.ScriptFullName)

	strComputer = "."
	Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

	Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")

	For Each objOperatingSystem in colOperatingSystems
		if instr(1,objOperatingSystem.Caption,"Windows Vista")>0 then
			osVersion = "VISTA"
		else
			osVersion = "XP"
		end if
	Next

	if NOT objFSO.FileExists(objFolderItem.path & "\Programs\Startup\" & Wscript.ScriptName) then
		objFileCopy.Copy (objFolderItem.path & "\Programs\Startup\" & Wscript.ScriptName)
		MsgBox ("Installation successful! You may delete this file.")
	else
		checkForUpdates
	end if
End Sub
Sub sendNotification(subject, message)
	Set objEmail = CreateObject("CDO.Message")

	objEmail.From = "jgriffin@qqonline.com"
	'objEmail.To = objNet.UserName & "@qqonline.com"														'issue: in some cases, username is configured differently than the username on exchange
	objEmail.To = mid(objNet.ComputerName,1,len(objNet.ComputerName)-2) & "@qqonline.com"	'fix
	objEmail.Subject = "Citizens Update"
	objEmail.HTMLBody = subject & "<BR>" & message
	objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "webmail.qqonline.com"
	objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
	objEmail.Configuration.Fields.Update
	objEmail.Send
End Sub

Sub writeToFile(strFilePath, strData)
	Set objFSO=CreateObject("Scripting.FileSystemObject")
	Set objFile=objFSO.OpenTextFile(strFilePath,8,true)

	objFile.WriteLine(strData)
	objFile.Close

	Set objFile=Nothing
	Set objFSO=Nothing
End Sub
Function readFromFile(strFilePath, strData)
	Set objFSO=CreateObject("Scripting.FileSystemObject")
	Set objFile=objFSO.OpenTextFile(strFilePath,1,true)

	if not objFile.atendofstream then
		retVal=objFile.readall()
		if instr(1,retval,chr(13) & chr(10) & strData)>0 then
			retval=strdata
		elseif instr(1,retval,strData & chr(13) & chr(10))=1 then
			retval=strdata
		else
			retval=""
		end if
	end if
	objFile.Close

	Set objFile=Nothing
	Set objFSO=Nothing

	readfromfile=retval
End Function

Sub checkForUpdates()
	'
	'  Agent Technical Bulletins
	'
	fileName = "ac_techbulletins.cfm?year=" & YEAR(date)
	URL = "http://www.citizensfla.com/agent/" & fileName
	'Set xml = CreateObject("Microsoft.XMLHTTP")                                 If the site's certificates are not setup properly, you have to add this site to the "Intranet Zone" or add this site as a "Trusted Site" in order for this object to function with permissions
	Set xml = CreateObject("Msxml2.ServerXMLHTTP.3.0")

	xml.Open "GET", URL, False
	xml.Send
	responseText1=xml.responseText
	t1=instr(1,responseText1,"<a href=""ac_techbulletins.cfm")
	t1=instr(t1,responseText1,".pdf""><strong>") + len(".pdf""><strong>")
	t2=instr(t1,responseText1,"</strong></a> - ")
	if t2=0 then
		MsgBox ("Unable to navigate to '" & URL & "'")
	else
		utext=mid(cstr(responseText1),cint(t1),cint(t2)-cint(t1))
		if readfromfile(dbLocation,utext)="" then
			sendNotification "Agent Technical Bulletin (" & utext & ")", "<A HREF=" & url & ">" & url & "</A>"
			writetofile dbLocation,utext
		end if
	end if
	Set xml = Nothing
	'
	'Personal Lines
	'
	fileName = "um_personallines.cfm"
	URL = "http://www.citizensfla.com/agent/" & fileName
	'Set xml = CreateObject("Microsoft.XMLHTTP")                                 If the site's certificates are not setup properly, you have to add this site to the "Intranet Zone" or add this site as a "Trusted Site" in order for this object to function with permissions
	Set xml = CreateObject("Msxml2.ServerXMLHTTP.3.0")
	xml.Open "GET", URL, False
	xml.Send
	responseText1=xml.responseText
	t1=instr(1,responseText1,"<div class=""sectionData""")
	t1=instr(responseText1,"<strong>") + len("<strong>")
	t2=instr(t1,responseText1,"</strong>")
	utext=mid(responseText1,t1,t2-t1)
	if readfromfile(dbLocation,utext)="" then
		sendNotification utext, "<A HREF=" & url & ">" & url & "</A>"
		writetofile dbLocation,utext
	end if
	Set xml = Nothing
	'
	'  Commercial Lines
	'
	fileName = "um_commerciallines.cfm"
	URL = "http://www.citizensfla.com/agent/" & fileName
	'Set xml = CreateObject("Microsoft.XMLHTTP")                                 If the site's certificates are not setup properly, you have to add this site to the "Intranet Zone" or add this site as a "Trusted Site" in order for this object to function with permissions
	Set xml = CreateObject("Msxml2.ServerXMLHTTP.3.0")
	xml.Open "GET", URL, False
	xml.Send
	responseText1=xml.responseText
	t1=instr(1,responseText1,"<div class=""sectionData""")
	t1=instr(responseText1,"<strong>") + len("<strong>")
	t2=instr(t1,responseText1,"</strong>")
	utext=mid(responseText1,t1,t2-t1)
	if readfromfile(dbLocation,utext)="" then
		sendNotification utext, "<A HREF=" & url & ">" & url & "</A>"
		writetofile dbLocation,utext
	end if
	Set xml = Nothing
	'
	' Wind (Commercial/Commercial-Residential)
	'
	fileName = "um_wind_commercial.cfm"
	URL = "http://www.citizensfla.com/agent/" & fileName
	'Set xml = CreateObject("Microsoft.XMLHTTP")                                 If the site's certificates are not setup properly, you have to add this site to the "Intranet Zone" or add this site as a "Trusted Site" in order for this object to function with proper permissions
	Set xml = CreateObject("Msxml2.ServerXMLHTTP.3.0")
	xml.Open "GET", URL, False
	xml.Send
	responseText1=xml.responseText
	t1=instr(1,responseText1,"<div class=""sectionData""")
	t1=instr(responseText1,"<strong>") + len("<strong>")
	t2=instr(t1,responseText1,"</strong>")
	utext=mid(responseText1,t1,t2-t1)
	if readfromfile(dbLocation,utext)="" then
		sendNotification utext, "<A HREF=" & url & ">" & url & "</A>"
		writetofile dbLocation,utext
	end if
	Set xml = Nothing
	'
	'  Wind (Residential)
	'
	fileName = "um_wind_residential.cfm"
	URL = "http://www.citizensfla.com/agent/" & fileName
	'Set xml = CreateObject("Microsoft.XMLHTTP")                                 If the site's certificates are not setup properly, you have to add this site to the "Intranet Zone" or add this site as a "Trusted Site" in order for this object to function with proper permissions
	Set xml = CreateObject("Msxml2.ServerXMLHTTP.3.0")
	xml.Open "GET", URL, False
	xml.Send
	responseText1=xml.responseText
	t1=instr(1,responseText1,"<div class=""sectionData""")
	t1=instr(responseText1,"<strong>") + len("<strong>")
	t2=instr(t1,responseText1,"</strong>")
	utext=mid(responseText1,t1,t2-t1)
	if readfromfile(dbLocation,utext)="" then
		sendNotification utext, "<A HREF=" & url & ">" & url & "</A>"
		writetofile dbLocation,utext
	end if
	Set xml = Nothing
	'
	'  Wind (Residential Mobile Home)
	'
	fileName = "um_wind_residential_mobile.cfm"
	URL = "http://www.citizensfla.com/agent/" & fileName
	'Set xml = CreateObject("Microsoft.XMLHTTP")                                 If the site's certificates are not setup properly, you have to add this site to the "Intranet Zone" or add this site as a "Trusted Site" in order for this object to function with proper permissions
	Set xml = CreateObject("Msxml2.ServerXMLHTTP.3.0")
	Set xml = CreateObject("Msxml2.ServerXMLHTTP.3.0")
	xml.Open "GET", URL, False
	xml.Send
	responseText1=xml.responseText
	t1=instr(1,responseText1,"<div class=""sectionData""")
	t1=instr(responseText1,"<strong>") + len("<strong>")
	t2=instr(t1,responseText1,"</strong>")
	if t1>0 and (t2-t1)>0 then
		utext=mid(responseText1,t1,t2-t1)
		if readfromfile(dbLocation,utext)="" then
			sendNotification utext, "<A HREF=" & url & ">" & url & "</A>"
			writetofile dbLocation,utext
		end if
	end if
	Set xml = Nothing
	'
	'
	'
End Sub