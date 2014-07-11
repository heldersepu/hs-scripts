' This script will add a host header to an existing site in IIS6

siteName = "DistinctivePropertiesERA"
ip = "0"
port = "80"
serversList = "eraweb1,eraweb2,eraweb3,eraweb4,eraweb5"

For each server in Split(serversList, ",")
    host = "eradistinctiveproperties." & server & ".com"
    IISService = "IIS://" & server & "/w3svc"
    siteID = FindSite(siteName)

    If (siteID = "") Then
        WScript.Echo "cannot find site: " & server
    Else
        ' add the host header
        Call AddHostHeader(siteID, ip, port, host)
        WScript.Echo " - " & server & " done"
    End If
Next
WScript.Echo "All Done"


Function AddHostHeader(siteID, ip, port, host)
	Dim pathing, bindings, hostheader, a
	hostheader = ip & ":" & port & ":" & host
	pathing = IISService & "/" & siteID
	Set objWebsite = getObject(pathing)
	bindings = objWebsite.ServerBindings
	If (CheckForHost(host, bindings) = true) Then
		WScript.Echo "host header already exists"
	Else	
        a = UBound(bindings)
        a = a + 1
        ReDim Preserve bindings(a)
        bindings(a) = hostheader
        objWebSite.Put "ServerBindings", bindings
        objWebSite.SetInfo
	End If
End Function

Function GetDescription(SiteNumber)
	Dim pathing
	pathing = IISService & "/" & SiteNumber
	Set IISWebSite = getObject(pathing)
	Set IISWebSiteRoot = getObject(pathing & "/root")
	GetDescription = IISWebSite.ServerComment
	Set IISWebSiteRoot = nothing
	Set IISWebSite = Nothing
End Function

Function FindSite(SiteName)
	FindSite = ""
	Set IISOBJ = getObject(IISService)
	for each Web in IISOBJ
		if (Web.Class = "IIsWebServer") then
			If (GetDescription(Web.Name) = SiteName) Then
				FindSite = Web.name
			End If
		end if
	next
	Set IISOBj=Nothing
End Function

Function CheckForHost(host, bindings)
	Dim a, b
	CheckForHost = False
	' check to see if the host exists
	For Each a In bindings
		b = Split(a, ":")
		If (b(2) = host) Then
			CheckForHost = True
			Exit Function
		End If
	Next
End Function