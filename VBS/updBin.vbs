'Check directories for new files (created in the last 30 seconds)
arrDir = Array("C:\SecretAgent\WWWRoot\common\bin\", _
    "C:\SecretAgent\WWWRoot\ERACorporate\bin\", _
    "C:\SecretAgent\WWWRoot\Century21Site\bin\", _
    "C:\SecretAgent\WWWRoot\WebServices\ListingDataService\BIN", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\MasterSite\Bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIAdmin\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIeNCRM\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIListings\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UISetup\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIReports\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIListingWidgets\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UINewsletterWidgets\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIWebsiteSetup\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIInfoCenter\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIHelpDesk\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UIEngage\bin", _
    "C:\SecretAgent\WWWRoot\IncludeDirectories\UITemplateSites\bin", _
    "C:\SecretAgent\WWWRoot\rciNETComponents\eNDeliveryMessageUtils\obj\Debug", _
    "C:\SecretAgent\WWWRoot\rciNETComponents\eNPointsOfInterestData\bin\Release", _
    "C:\SecretAgent\WWWRoot\RemaxCanadaMobile\bin\", _
    "C:\SecretAgent\wwwroot\WebServices\CRMAccessServices\bin", _
    "C:\SecretAgent\WWWRoot\ColdWellBankerSite_2010\bin\")


On Error Resume Next
strFiles = ""
Set FSO = CreateObject("Scripting.FileSystemObject")
If FSO.FileExists("updBin.vbs.lock") Then
    Call Wscript.Sleep(3000)
Else
    Set lockFile =  FSO.CreateTextFile("updBin.vbs.lock", True)
    If (Err.Number = 0) Then
        For Each strDir In arrDir
            For Each File In FSO.GetFolder(strDir).Files
                If LCase(Right(File.Name,4)) <> ".tmp" Then
                    If File.DateLastModified > DateAdd("s",-30,Now) Then
                        strFiles = strFiles & File.Path & " "
                        If LCase(Right(File.Name,4)) = ".dll" Then
                            strFiles = strFiles & File.Path & ".config "
                        End If
                    End If
                End If
            Next
        Next

        Set objShell = CreateObject("WScript.Shell")
        objShell.Run "C:\hs-scripts\Batch\CopyDLL.bat " & strFiles
        Set objShell = Nothing
    End If
    lockFile.close
End If

Call Wscript.Sleep(500)
Call FSO.DeleteFile("updBin.vbs.lock")
Set FSO = Nothing
