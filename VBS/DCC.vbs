' Check all open Process for Notepad++ if exists open get the file & try to compile it

Set objWMI   = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
Set cProc    = objWMI.ExecQuery("Select * from Win32_Process")
Set fso  	 = CreateObject("Scripting.FileSystemObject")
Set oShell   = CreateObject("WScript.Shell")

If (Not fso.FileExists(Wscript.Path & "\DCC.vbs")) Then
    'Copy the file  to  "C:/WINDOWS/system32"
    fso.CopyFile wscript.ScriptName,  Wscript.Path & "\DCC.vbs", true
    'Create Shortcut
	Set oShLink = oShell.CreateShortcut(Wscript.Path & "\DCC.lnk")
	oShLink.TargetPath = Wscript.Path & "\DCC.vbs"
	oShLink.Save
End If

If WScript.Arguments.Count > 0  Then
    oShell.Run "Notepad " & Wscript.Path & "\DCC.vbs"
Else
    nFound = False
    For Each objProc in cProc
        If (LCase(objProc.Name) = "notepad++.exe") then
            nFound = True
            Sepa   = InStr(objProc.CommandLine, Chr(34) & " " & Chr(34))
            dFile  = Mid(objProc.CommandLine, Sepa + 2, len(objProc.CommandLine))
        End If
    Next

    If nFound Then
        If Ucase(Left( Right(dFile ,5) ,4 )) = ".PAS" Then
            ' DCC32 %%D -B -w- -h- >> c:\newqq95\allcomp\Compile.txt
            oShell.Run "%ComSpec% /k DCC32 " & dFile & " -B -w- -h-  & echo.  & pause & exit"
            'oShell.Run "%ComSpec% /k DCC32 " & dFile & " -B -w- -h- "
        End If
    End If
End If
