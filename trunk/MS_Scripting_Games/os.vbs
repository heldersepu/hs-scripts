'On Error Resume Next

Const WbemAuthenticationLevelPktPrivacy = 6

strComputer = "."
strNamespace = "root\cimv2"
strUser = "root"
strPassword = "2929"

Set objWbemLocator = CreateObject("WbemScripting.SWbemLocator")

Set objWMIService  = objwbemLocator.ConnectServer(strComputer, strNamespace, strUser, strPassword)

objWMIService.Security_.authenticationLevel = WbemAuthenticationLevelPktPrivacy
 
Set colItems = objWMIService.ExecQuery("Select * From Win32_OperatingSystem")
For Each objItem in colItems
  Wscript.Echo "Operating system: " & objItem.Caption
Next

