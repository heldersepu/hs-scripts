' Create a new entry on the right Click New for VBScript files

Set objShell = WScript.CreateObject ("WScript.Shell")
Set fso  	 = CreateObject("Scripting.FileSystemObject")
'Registry change
objShell.RegWrite "HKCR\.VBS\ShellNew\FileName","template.vbs"
'Create the file "C:\WINDOWS\system32\ShellExt\template.vbs"
If Not fso.FolderExists("C:\WINDOWS\system32\ShellExt") then
	fso.CreateFolder("C:\WINDOWS\system32\ShellExt")
End If
If Not fso.FileExists("C:\WINDOWS\system32\ShellExt\template.vbs") then
	fso.CreateTextFile("C:\WINDOWS\system32\ShellExt\template.vbs")
End If

'Command Window will Stay Open When:
' Right-Click and Choose Open With Command Prompt
Const HKEY_CLASSES_ROOT = &H80000000

Set objRegistry=GetObject("winmgmts:\\.\root\default:StdRegProv")
 
strKeyPath = "VBSFile\Shell\Open2\Command"
strValueName = ""
strValue = "cmd.exe /K cscript.exe " & Chr(34) & "%1" & Chr(34) & " %*" 

Call objRegistry.SetExpandedStringValue(HKEY_CLASSES_ROOT, strKeyPath, strValueName, strValue)
 