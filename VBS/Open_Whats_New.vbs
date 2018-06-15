'Open all the What's new files

'On Error Resume Next
Set objShell = CreateObject("WScript.Shell")

ServerPath = "\\AppSrvA\QQData\QuickQuoteForWindows\"
WhatsNew = "\Whats New\"
'Array With the Paths to "What's New" Folders
Dim ArrFolders(2)
ArrFolders(0) = ServerPath & "Texas"   & WhatsNew
ArrFolders(1) = ServerPath & "Florida" & WhatsNew
ArrFolders(2) = ServerPath & "Georgia" & WhatsNew

Set FSO = CreateObject("Scripting.FileSystemObject")

For Each item In ArrFolders
    If FSO.FolderExists(item) Then _
        Call ReadSubFolders(item)
Next

Set objShell = Nothing
Set FSO = Nothing



'Check the subFolders in the given folder
Sub ReadSubFolders(dFolder)
    ArrSubFolders = Array("Beta", "Regular")

    For Each subItem In ArrSubFolders
    	If FSO.FolderExists(dFolder & subItem) Then _
            Call ReadFolder(dFolder & subItem)
    Next
End Sub

'Check for the files in the given folder
Sub ReadFolder(strFolder)
    ArrFiles = Array("CM", "FL", "GA", "TX")

    strFolder = strFolder & "\New"
    For Each strItem In ArrFiles
        strItem = strItem & ".rtf"

        If FSO.FileExists(strFolder & strItem) Then _
            Call objShell.Run(chr(34) & strFolder & strItem & chr(34))

        If FSO.FileExists(strFolder & "Fix" & strItem) Then _
            Call objShell.Run(chr(34) & strFolder & "Fix" & strItem & chr(34))

        'If FSO.FileExists(strFolder & "CO" &  strItem) Then _
        '    Call objShell.Run(strFolder & "CO" &  strItem)
    Next
End Sub


