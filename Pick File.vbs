' Show a file seletion dialog box

Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
'ObjFSO.Filter = "Delphi Sources|s*.pas;v*.pas"
'ObjFSO.Flags = &H0200
ObjFSO.FilterIndex = 3
ObjFSO.InitialDir = "c:\newqq95\allcomp"
InitFSO = ObjFSO.ShowOpen

Wscript.Echo "You selected the file: " & ObjFSO.FileName
