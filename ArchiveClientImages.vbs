Const RCERR_OKCOPY_XTRA = 3 'Files in Source but Not Destination Plus Extra files in destination
Const RCERR_XTRA = 2 'Extra files in destination
Const RCERR_OKCOPY = 1 'Files in Source but Not Destination
Const RCERR_NOCHANGE = 0 'No differences in files
Const ForReading = 1

Const srcClientFoldersPath = "C:\archiveImageProg\Src\"
Const dstClientFoldersPath = "C:\archiveImageProg\dst\"

'Call the Main Routine
Set objFSO = CreateObject("Scripting.FileSystemObject")
CALL CheckClientsInFileRC("C:\archiveImageProg\folders.txt")
Set objFSO = Nothing


'Main Routine
Function CheckClientsInFileRC(ByVal filePath)
    logFileName = "MainLogFile_"& Replace((Replace((Replace(now,"/","")),":",""))," ","")& ".txt"
    logFilePath = "C:\archiveImageProg\" & logFileName
     
    Set objFile = objFSO.OpenTextFile(filePath, ForReading)
    Set objFileLog = objFSO.CreateTextFile(logFilePath)
    Do Until objFile.AtEndOfStream
        objFileLog.WriteLine("********************************************")
        strClientID = objFile.ReadLine
        objfileLog.WriteLine(strClientID)
        
        'call RoboCopyImages function and set intRoboCopyErr
        intRoboCopyErr = RoboCopyImages(strClientID)
        
        Select Case intRoboCopyErr
            Case RCERR_NOCHANGE, RCERR_OKCOPY, RCERR_XTRA, RCERR_OKCOPY_XTRA
                objFileLog.WriteLine("RoboCopy Returned " & intRoboCopyErr & " Rename The Directory")
                CALL RenameClientDirectory(strClientID)
            Case Else
                objFileLog.WriteLine("___Error: RoboCopy Returned " & intRoboCopyErr & " Do Nothing for this client")
        End Select
    Loop
    objFileLog.WriteLine("********************************************")
    objFile.Close
    objFileLog.Close
End Function

Function RoboCopyImages(ByVal strClient)
    If strClient = "" Then
        RoboCopyImages = 17
    Else
        strLog = "/Log:c:\archiveImageProg\RoboCopyLog_" & strClient & "_" & DateNow &  ".log"
        strOptions = "/COPY:DAT /Z /E /FFT /V"
        strSrcPath = objFSO.BuildPath(srcClientFoldersPath, strClient)
        strDstPath = objFSO.BuildPath(dstClientFoldersPath, strClient)
        strRCCommand = "robocopy.exe " & strSrcPath & " " & strDstPath & " " & strLog & " " & strOptions
        set WshShell = WScript.createobject("WScript.Shell")
        set oExec = WshShell.Exec(strRCCommand)
        Do While oExec.Status = 0
             WScript.Sleep 1000
        Loop
        RoboCopyImages = oExec.ExitCode
    End If
End Function

Function DateNow()
    DateNow = Replace((Replace((Replace(now, "/", "")), ":", "")), " ", "")
End Function

Function RenameClientDirectory(ByVal FolderName)
    If FolderName = "" Then
        RenameClientDirectory = 0
    Else
        newFolderName = "archived_" & Foldername
        srcDirectoryFullPath = objFSO.BuildPath(srcClientFoldersPath, FolderName)
        dstDirectoryFullPath = objFSO.BuildPath(srcClientFoldersPath, newFolderName)
        CALL objFSO.MoveFolder(srcDirectoryFullPath , dstDirectoryFullPath)
        RenameClientDirectory = 1
    End If
End Function
