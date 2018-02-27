'Output all Open Processes

Set objWMI   = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
Set cProc    = objWMI.ExecQuery("Select * from Win32_Process")
Set oShell   = CreateObject("WScript.Shell")


If WScript.Arguments.Count > 0  Then
    oShell.Run "Notepad " & Wscript.Path & "\DCC.vbs"
Else
    strMessage = ""
    For Each objProc in cProc
        strMessage = strMessage & objProc.Name & VbCrLf
    Next
    Wscript.Echo strMessage
End If 
