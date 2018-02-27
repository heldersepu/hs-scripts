' Show a Multi file seletion dialog box

Const cdlOFNAllowMultiselect = 512

Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
ObjFSO.Filter = "VBScripts|*.vbs|Text Documents|*.txt|All Files|*.*"
ObjFSO.FilterIndex = 3
ObjFSO.InitialDir = "c:\myscripts"
ObjFSO.Flags = cdlOFNAllowMultiselect
InitFSO = ObjFSO.ShowOpen

If InitFSO = False Then
    Wscript.Echo "Script Error: Please select a file!"
    Wscript.Quit
Else
    Wscript.Echo "You selected the file: " & ObjFSO.FileName
End If 