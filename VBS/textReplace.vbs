Set oFSO = CreateObject("Scripting.FileSystemObject")

Call doReplace("C:\wwwroot\site-HC\web.config" , "compilation defaultLanguage", "compilation optimizeCompilations=""true"" defaultLanguage")
Call doReplace("C:\wwwroot\site-ERA\web.config", "<customErrors mode=""Off""/>", "<customErrors mode=""RemoteOnly""/>")


Sub doReplace(strFile, strSearch, strReplace)
    If Not oFSO.FileExists(strFile) Then
        WScript.Echo "Specified file does not exist."
    Else
        Set oFile = oFSO.OpenTextFile(strFile, 1)
        strText = oFile.ReadAll
        oFile.Close
        strText = Replace(strText, strSearch, strReplace, 1, -1, 1)
        Set oFile = oFSO.OpenTextFile(strFile, 2)
        oFile.WriteLine strText
        oFile.Close
    End If
End Sub
