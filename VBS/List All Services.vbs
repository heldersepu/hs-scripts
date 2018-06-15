' Create a File in the Desktop with all the services

Set objWMISrv = GetObject("winmgmts:!\\.\root\cimv2")
Set colServ   = objWMISrv.ExecQuery("SELECT * FROM Win32_Service")

set WshShell  = WScript.CreateObject("WScript.Shell") 
strDesktop    = WshShell.SpecialFolders("Desktop")

Set fso  	  = CreateObject("Scripting.FileSystemObject")
Set outFile   = fso.CreateTextFile(strDesktop & "\Services.csv", True)

outFile.WriteLine("Windows Services" & VbCrLf)
outFile.WriteLine("DisplayName,RealName,Status,StartupType,Description")
For Each objServ in colServ
	outFile.WriteLine( 	objServ.DisplayName & "," & objServ.Name & "," & _
	objServ.State & "," & objServ.StartMode & ",""" & Left(objServ.Description,80) & """") 
Next
outFile.Close
