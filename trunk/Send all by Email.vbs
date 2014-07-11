' Send by email all files in the folder using Outlook

dSendTo  = "observatoriosn@infomed.sld.cu"
dFolder  = "C:\Documents and Settings\Root\Desktop\NOD32"
dSubject = "NOD32 Antivirus "
dBody    = "Aqui va el NOD32 Antivirus (en .rar files)"


Set objShell = CreateObject("WScript.Shell")
Set objOutlook = CreateObject("Outlook.Application")
Set fso = CreateObject("Scripting.FileSystemObject")
Set Fldr = fso.GetFolder(dFolder)

Call createScript

' -- Get all files in the folder and put them on array
For Each dFile In Fldr.Files
    call objShell.Run("wscript " & Wscript.Path & "\sendKeys.vbs")
	call doSendMail(dSendTo, dFile.Name, dFile.Path, dSubject, strBody)
next

wscript.sleep 8000
call objShell.Run("outlook")

Set objShell = Nothing
Set objOutlook = Nothing
Set fso = Nothing

'Procedure to send the emails
Sub doSendMail(strSendTo, strName, strFile, strSubject, strBody)
	Set objOutlookMsg = objOutlook.CreateItem(0)
	With objOutlookMsg
	   .To = strSendTo
	   .Subject = strSubject & strName
	   .Body = strBody & VbCrLf & strName
	   .Attachments.Add (strFile)
	   .Send
	End With
	Set objOutlookMsg = Nothing
End Sub

'Procedure to create file(script) that will select YES & hit enter in the Outlook screen
Sub createScript
    Set outFile = fso.CreateTextFile( Wscript.Path & "\sendKeys.vbs", True)
    outFile.WriteLine("Set oShell  = CreateObject(""WScript.Shell"")")
    outFile.WriteLine("")
    outFile.WriteLine("'Create a delay")
    outFile.WriteLine("wscript.sleep 8000")
    outFile.WriteLine("intCount = 0")
    outFile.WriteLine("Do Until intCount > 2")
    outFile.WriteLine("    If isActive(""Microsoft Office Outlook"") Then")
    outFile.WriteLine("        oShell.SendKeys ""{TAB}""")
    outFile.WriteLine("        wscript.sleep 300")
    outFile.WriteLine("        oShell.SendKeys ""{TAB}""")
    outFile.WriteLine("        wscript.sleep 300")
    outFile.WriteLine("        oShell.SendKeys ""{ENTER}""")
    outFile.WriteLine("        Exit Do")
    outFile.WriteLine("    End IF")
    outFile.WriteLine("    intCount = intCount + 1")
    outFile.WriteLine("    wscript.sleep 8000")
    outFile.WriteLine("Loop " )
    outFile.WriteLine("")
    outFile.WriteLine("'strTaskName -> Name of the task as shown in theTask manager [Applications Tab]")
    outFile.WriteLine("Function isActive(strTaskName)")
    outFile.WriteLine("    Set objShell = CreateObject(""WScript.Shell"")")
    outFile.WriteLine("    intCount = 0")
    outFile.WriteLine("    Do Until ((Success = True) or (intCount > 5))")
    outFile.WriteLine("        Success = objShell.AppActivate(strTaskName)")
    outFile.WriteLine("        If not Success then")
    outFile.WriteLine("            Wscript.Sleep 1000")
    outFile.WriteLine("            intCount = intCount + 1")
    outFile.WriteLine("        End If")
    outFile.WriteLine("    Loop")
    outFile.WriteLine("    Set objShell = Nothing")
    outFile.WriteLine("    isActive = Success")
    outFile.WriteLine("End Function")
    outFile.WriteLine("")

    outFile.Close
    Set outFile = Nothing
End Sub
