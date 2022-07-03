'Check all Open Processes

call msgbox( "OutLook is running: " & isRunning("OUTLOOK.EXE"))
call msgbox( "OutLook is Active: " & isActive("Inbox - Microsoft Outlook"))

'strProcName -> Name of the Process as shown in theTask manager [Processes Tab]
Function isRunning(strProcName)
    Set objWMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
    Set cProc  = objWMI.ExecQuery("Select * from Win32_Process")
    strProcName = UCase(Trim(strProcName))

    For Each objProc in cProc
        If (strProcName = UCase(objProc.Name)) then
            isRunning = True
            Exit Function
        End If
    Next
    isRunning = False

    Set cProc = Nothing
    Set objWMI = Nothing
End Function

'strTaskName -> Name of the task as shown in theTask manager [Applications Tab]
Function isActive(strTaskName)
    Set objShell = CreateObject("WScript.Shell")
    intCount = 0
    Do Until ((Success = True) or (intCount > 5))
        Success = objShell.AppActivate(strTaskName)
        If not Success then
            Wscript.Sleep 1000
            intCount = intCount + 1
        End If
    Loop
    Set objShell = Nothing
    isActive = Success
End Function
