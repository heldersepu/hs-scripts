' Will add a right click funtion to the windows shell
' to copy the default letters to the current folder

Set objShell    = CreateObject("WScript.Shell")
Set objFSO      = CreateObject("Scripting.FileSystemObject")
fileName        = "CopyDefaultLetters"
scriptFile      = Wscript.Path & "\" & fileName & ".vbs"
defaultFolder   = "E:\Conversion\DefaultLetters"

If (Not objFSO.FileExists(scriptFile)) Then
    '// Register the file
    doRegist(scriptFile)
    msgBox " Right click funtion Added! "
Else
    If WScript.Arguments.Count > 0  Then
        Select Case UCase(WScript.Arguments.Item(0))
            Case "/DO"
                tempFile = ""
                For I = 1 to WScript.Arguments.Count -1
                    tempFile = tempFile & " " & WScript.Arguments.Item(I)
                Next
                doAction(Trim(tempFile))
            Case "/REG"
                doRegist(scriptFile)
            Case "/DEL"
                doDelet(scriptFile)
            Case Else
                objShell.Run "notepad " & scriptFile
        End Select
    Else
        objShell.Run "notepad " & scriptFile
    End If
End If

Sub doAction(argFile)
    strFile = Trim(argFile)
    If objFSO.FileExists(strFile) Then
        If UCase(Right(strFile, 13)) = "QFWINDATA.MDB" then
            folderName = Left(strFile, len(strFile) - 13)
            Call objFSO.CopyFolder(defaultFolder & "\English" , folderName , true)
            Call objFSO.CopyFolder(defaultFolder & "\French" , folderName , true)
            Call objFSO.CopyFolder(defaultFolder & "\Spanish" , folderName , true)
        End If
    Else
        Wscript.Echo "File not Found! " & vbcrlf & argFile
    End If
End Sub

Sub doRegist(myFile)
    ' Copy the file to "C:/WINDOWS/system32"
    objFSO.CopyFile wscript.ScriptName,  myFile, true
    'Create Shortcut
    Set oShLink  = objShell.CreateShortcut(Wscript.Path & "\" & fileName & ".lnk")
    oShLink.TargetPath = myFile
    oShLink.Save
    ' Create the Regedit keys
    DllReg  = "HKCR\*\shell\" & fileName & "\command\"
    RegProg = "wscript " & myFile & " /DO %1"
    objShell.RegWrite DllReg , RegProg
End Sub

Sub doDelet(myFile)
    'Delete all the files
    If objFSO.FileExists(myFile) then
        call objFSO.DeleteFile(myFile)
    End If
    If objFSO.FileExists(Wscript.Path & "\" & fileName & ".lnk") then
        call objFSO.DeleteFile(Wscript.Path & "\" & fileName & ".lnk")
    End If
    ' Delete the Regedit keys
    call objShell.RegDelete("HKCR\*\shell\" & fileName & "\command\")
    call objShell.RegDelete("HKCR\*\shell\" & fileName & "\")
End Sub
