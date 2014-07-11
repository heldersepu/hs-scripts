'Show the version of the Windows installer
Set objInstaller = CreateObject("WindowsInstaller.Installer") 
MsgBox("Installer version is: " & objInstaller.Version)
