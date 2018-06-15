' Will add a right click funtion to the windows shell
' to copy the default letters to the current folder

Set objShell = CreateObject("Shell.Application")
Set objFSO  = CreateObject("Scripting.FileSystemObject")

If WScript.Arguments.Count > 0  Then
    argFolder = WScript.Arguments.Item(0)
    If UCASE(RIGHT(argFolder, 7)) = "QUICKFL" Then
        call doAction(argFolder)
    End IF
Else
    call doRegist(wscript.ScriptFullName)
    msgBox "No arguments given!"
End IF


Sub doAction(argFolder)
    If objFSO.FolderExists(argFolder) Then
        'Copy the DefaultLetters if needed
        defaultFolder   = "E:\Conversion\DefaultLetters"
        If not objFSO.FolderExists(argFolder & "\English") Then
            Call objFSO.CopyFolder(defaultFolder & "\English" , argFolder & "\" , true)
        End If
        If not objFSO.FolderExists(argFolder & "\French") Then
            Call objFSO.CopyFolder(defaultFolder & "\French" , argFolder & "\" , true)
        End If
        If not objFSO.FolderExists(argFolder & "\Spanish") Then
            Call objFSO.CopyFolder(defaultFolder & "\Spanish" , argFolder & "\" , true)
        End If

        'Create the name of the zip file
        MyZip = objFSO.GetParentFolderName(argFolder) & "\Zipit_"
        intPos = inStr(MyZip, "QQ0")
        If (intPos > 0) Then
            MyZip = MyZip & Mid(MyZip, intPos, 8) & "_Data_"
        Else
            MyZip = MyZip & "QQ000000_Data_"
        End IF
        MyZip = MyZip & MonthName(Month(now))
        MyZip = MyZip & "_" & Day(now)
        MyZip = MyZip & "_" & Year(now)
        MyZip = MyZip & "_" & Hour(time)
        MyZip = MyZip & "_" & Minute(time) & ".zip"

        'Create a blank Zip file
        Set outFile = objFSO.CreateTextFile(MyZip, True)
        outFile.Write "PK" & Chr(5) & Chr(6) & String(18, Chr(0))
        outFile.Close
        Set outFile = Nothing

        'Zip the folder
        Set destFldr = objShell.NameSpace(MyZip)
        call destFldr.CopyHere(argFolder, 8)
        Wscript.Echo "Zip file created!"
    Else
        Wscript.Echo "Folder not Found! " & vbcrlf & argFolder
    End If
End Sub


Sub doRegist(myFile)
    'Get the SendTo folder
    Set objFolder = objShell.Namespace(&H9&).self
    If objFSO.FolderExists(objFolder.path) Then
        'Create Shortcut 
        Set wsShell    = CreateObject("WScript.Shell")
        Set oShLink  = wsShell.CreateShortcut(objFolder.path & "\ZipIt (add letters and create zip).lnk")
        oShLink.TargetPath = myFile
        oShLink.Save
    else
        Wscript.Echo "Can not Create Shortcut in SendTo" & VBCRLF & objFolder.path
    End If
End Sub
