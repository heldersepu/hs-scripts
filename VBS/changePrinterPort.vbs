' Script will change the port of the QuickQuote printer
' This was created to address issue in Vista 64 bit
' The Amyuni Printer needs to be on a "NUL:" port
'

Call ChangePrinterPort("QuickQuote DO NOT DELETE", "NUL:")


' Changes the port of a printer
Sub ChangePrinterPort(strPrinterName, strPortName)
    On Error Resume Next

    Call CreatePort(strPortName)

    If Err <> 0 then
        msgbox "There was an error creating the '" & strPortName & "' printer port."
    Else
        ' Change the port of the printer
        Set colPrinters = GetObject("winmgmts:\\.\root\cimv2").ExecQuery _
            ("Select * From Win32_Printer Where DeviceID='" & strPrinterName & "'")
        For Each objPrinter in colPrinters
            objPrinter.PortName = strPortName
            objPrinter.Put_
        Next
        Set colPrinters = Nothing
    End If
End Sub


' Creates a port with the given name
Sub CreatePort(strPortName)
    ' This registry key holds all local ports.
    strRegPorts = "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Ports\"

    Set objShell = CreateObject("WScript.Shell")

    ' Check if the port exists
    On Error Resume Next
    Call objShell.RegRead(strRegPorts & strPortName)
    ' Any error is because the port does not exists
    If Err <> 0 then
        Err = 0
        ' Stop the spooler service
        Call spooler_service("STOP")
        ' This line adds a subkey with the port name.
        Call objShell.RegWrite(strRegPorts & strPortName, 1, "REG_SZ")
        ' Create a config file in System32.
        Set fso = CreateObject("Scripting.FileSystemObject")
        Call fso.CreateTextFile(wscript.path & "\" & strPortName, True)
        Set fso = Nothing
        ' Start the spooler service
        Call spooler_service("START")
    End If

    Set objShell = Nothing
End Sub


' Start or stop the spooler service
Function spooler_service(strChange)
	Set colCompSys = GetObject("winmgmts:\\.\root\cimv2").ExecQuery  _
        ("Select * from Win32_Service where Name='spooler'")
	For Each objCompSys in colCompSys
		If UCase(strChange) = "START" then
			spooler_service = objCompSys.StartService()
		Else
			spooler_service = objCompSys.StopService()
		End If
	Next
    Set colCompSys = Nothing
End Function
