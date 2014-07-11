' Show a file seletion dialog box

Set SA = CreateObject("Shell.Application")
Set f = SA.BrowseForFolder(0, "Choose a folder", 0, "c:\")
If (Not f Is Nothing) Then
    Wscript.Echo "You selected " & f.Items.Item.Path
End If
