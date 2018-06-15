Function BrowseForFile(pstrPath, pstrFilter)     
    Set objDialog = CreateObject("MSComDlg.CommonDialog")     
    objDialog.Filter = pstrFilter     
    objDialog.InitDir = pstrPath     
    objDialog.MaxFileSize = 256     
    objDialog.Flags = &H80000 + &H4 + &H8     
    intResult = objDialog.ShowOpen()     
    BrowseForFile = objDialog.FileName
End Function

BrowseForFile "c:","*.vbs"