Attribute VB_Name = "Module1"
Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

' --------------------------------------
'  ********* SCRIPT 4 RULES  **********

Sub CleanUp(Item As Outlook.MailItem)
    On Error GoTo CleanUp_Error
    If Item.UnRead Then
        arrImportantKeywords = Array("New Status: To Verify", "New Task #")
        strEmail = Item.Subject & vbCrLf & Item.Body

        For Each strKeyw In arrImportantKeywords
            If InStr(1, strEmail, strKeyw, vbTextCompare) > 0 Then
                Item.Display
            End If
        Next

        For Each subFolder In ThisOutlookSession.GetNamespace("MAPI").GetDefaultFolder(olFolderInbox).Folders
            If (subFolder.Name = "QuickFile Conversions") Then
                Call DeleteOldEmails(subFolder.Items, 30)
            ElseIf (subFolder.Name = "Post conversion reports") Then
                Call DeleteOldEmails(subFolder.Items, 15)
            End If
        Next

        If InStr(1, Item.Subject, "Post conversion report", vbTextCompare) > 0 Then
            strFileName = SaveEmail(Item)
            If strFileName <> "" Then
                Call AttachFileToACE(strFileName)
            End If
        End If
    End If

    On Error GoTo 0
    Exit Sub

CleanUp_Error:
    MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure CleanUp of Module Module1"
End Sub

' --------------------------------------
'  ******** Private Functions *********

Private Function CleanFileName(ByVal strName) As String
    For Each strChar In Array("\", "/", ":", "*", "?", Chr(34), "<", ">", "|")
        strName = Replace(strName, strChar, "")
    Next
    CleanFileName = strName
End Function

Private Function SaveEmail(email) As String
    On Error GoTo SaveEmail_Error

    If InStr(Right(email.Body, 80), "hsepulveda") = 0 Then
        SaveEmail = ""
    Else
        FolderPath = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\Post conversion report\"
        If Dir(FolderPath) = "" Then
            Call MkDir(FolderPath)
        End If
        FileName = FolderPath & CleanFileName(email.Subject) & ".msg"
        i = 1
        Do Until (Dir(FileName) = "")
            FileName = FolderPath & CleanFileName(email.Subject) & "_" & i & ".msg"
            i = i + 1
        Loop
        Call email.SaveAs(FileName)
        SaveEmail = FileName
    End If

    On Error GoTo 0
    Exit Function

SaveEmail_Error:
    SaveEmail = ""
End Function

Private Sub DeleteOldEmails(arrEmails, intDays)
    For Each objEmail In arrEmails
        If DateDiff("d", objEmail.CreationTime, Now) > intDays Then
            Call objEmail.Delete
        End If
    Next
End Sub

Private Sub AttachFileToACE(FileName)
    strQQID = extract_qqid(FileName)
    strName = Dir(FileName)
    If (strQQID <> "") And (strName <> "") Then
        Set objIE = CreateObject("InternetExplorer.Application")
        objIE.Visible = False
        Call objIE.Navigate("C:\Users\hsepulveda\AppData\Roaming\Login.html")
        Call PauseIE(objIE)
        objIE.Document.All.Item("loginBtn").Click
        Call PauseIE(objIE)
        Call objIE.Navigate("http://qqprojects.com/server01/UserTasks.asp")
        Call PauseIE(objIE)
        Set objLinks = objIE.Document.getElementsByTagName("A")
        For Each objLink In objLinks
            If InStr(1, CStr(objLink.outerHTML), strQQID, vbTextCompare) > 0 Then
                strVer = ""
                RefURL = Replace(objLink.href, "EditTask.asp", "EditTaskDocument.asp")
                Call objIE.Navigate(RefURL)
                Call PauseIE(objIE)
                Set objInputs = objIE.Document.getElementsByTagName("FONT")
                For Each objInput In objInputs
                    If InStr(1, CStr(objInput.outerHTML), strName, vbTextCompare) > 0 Then
                        strVer = CStr(Val(strVer) + 1)
                    End If
                Next
                Set objInputs = Nothing

                Call UploadFile(objIE, "http://qqprojects.com/server01/Common-uploadfile.asp", _
                                FileName, "FILE_TO_UPLOAD", RefURL, strVer, "Post conversion report")
                Exit For
            End If
        Next
        Set objLinks = Nothing
        objIE.Top = 50
        objIE.Left = 50
        objIE.TheaterMode = False
        objIE.Visible = True
    End If
End Sub

Private Sub PauseIE(objIE)
    Sleep 250
    Do Until objIE.readyState = 4
        DoEvents
    Loop
End Sub

Private Function extract_qqid(strName)
    extract_qqid = ""
    intPos = InStr(1, strName, "QQ", vbTextCompare)
    If (intPos > 0) Then
        If IsNumeric(Mid(strName, intPos + 2, 6)) Then
            extract_qqid = Mid(strName, intPos, 8)
        End If
    End If
End Function

Private Function extract_ID(strName, strID)
    extract_TASK_ID = ""
    intPos = InStr(1, strName, "?", vbTextCompare)
    If (intPos > 0) Then
        arrItems = Split(Mid(strName, intPos + 1), "&")
        For Each Item In arrItems
            intPos = InStr(1, Item, strID, vbTextCompare)
            If (intPos > 0) Then
                extract_ID = Mid(Item, Len(strID) + 1)
            End If
        Next
    End If
End Function

'Upload file using input type=file
Private Sub UploadFile(WebBrowser, DestURL, FileName, FieldName, RefURL, strVer, strDesc)

    Dim sFormData As String, d As String
    Const Boundary As String = "-----------------------------7db718250b1c"
    sFormData = GetFile(FileName)

    'Build source form with file contents
    d = Boundary + cDisp("chkDontSendNotif", "", Boundary)

    d = d + vbCrLf + "Content-Disposition: form-data;"
    d = d + " name=""" + FieldName + """;"
    d = d + " filename=""" + Dir(FileName) + """" + vbCrLf
    d = d + "Content-Type: text/plain" + vbCrLf + vbCrLf
    d = d + sFormData + vbCrLf + Boundary

    d = d + cDisp("DESCRIPTION", strDesc, Boundary)
    d = d + cDisp("DOC_VERSION", strVer, Boundary)
    d = d + cDisp("LOCK_USER_ID0", "", Boundary)
    d = d + cDisp("FormName", "Document", Boundary)
    d = d + cDisp("PROJECT_ID", extract_ID(RefURL, "PROJECT_ID="), Boundary)
    d = d + cDisp("TASK_ID", extract_ID(RefURL, "TASK_ID="), Boundary)
    d = d + cDisp("FormAction", "insert", Boundary)
    d = d + cDisp("NB_FORM", "", Boundary) + "--"

    'Post the data To the destination URL
    Call PostStringRequest(WebBrowser, DestURL, d, Boundary, RefURL)
End Sub

Private Function GetFile(ByVal FileName As String) As String
    Dim FileContents() As Byte, FileNumber As Integer
    ReDim FileContents(FileLen(FileName) - 1)
    FileNumber = FreeFile
    Open FileName For Binary As FileNumber
    Get FileNumber, , FileContents
    Close FileNumber
    GetFile = StrConv(FileContents, vbUnicode)
End Function

Private Function cDisp(strName, strValue, Boundary As String) As String
    cDisp = vbCrLf + "Content-Disposition: form-data;" + _
          " name=""" + strName + """" + vbCrLf + _
            vbCrLf + strValue + vbCrLf + Boundary
End Function

'sends URL encoded form data To the URL using IE
Private Sub PostStringRequest(WebBrowser, URL, FormData, Boundary, RefURL)
    Dim bFormData() As Byte
    ReDim bFormData(Len(FormData) - 1)
    bFormData = StrConv(FormData, vbFromUnicode)

    WebBrowser.Navigate URL, PostData:=bFormData, _
                        Headers:="Referer: " + RefURL + vbCrLf + _
                                 "Content-Type: multipart/form-data; boundary=" + Mid(Boundary, 3) + vbCrLf + _
                                 "Pragma: no-cache" + vbCrLf

    Call PauseIE(WebBrowser)
End Sub

' --------------------------------------
'  **********     MACROS     **********

Sub DoCleanUp()
    For Each subFolder In ThisOutlookSession.GetNamespace("MAPI").GetDefaultFolder(olFolderInbox).Folders
        If (subFolder.Name = "QuickFile Conversions") Then
            Call DeleteOldEmails(subFolder.Items, 30)
        ElseIf (subFolder.Name = "Post conversion reports") Then
            Call DeleteOldEmails(subFolder.Items, 15)
            
            For Each Item In subFolder.Items
                If Item.UnRead Then
                    strFileName = SaveEmail(Item)
                    If strFileName <> "" Then
                        Call AttachFileToACE(strFileName)
                    End If
                End If
            Next
        End If
    Next
End Sub

Sub OpenImportantUnread()
    For Each subFolder In ThisOutlookSession.GetNamespace("MAPI").GetDefaultFolder(olFolderInbox).Folders
        If (subFolder.Name = "QuickFile Conversions") Then
            For Each Item In subFolder.Items
                If Item.UnRead Then
                    If InStr(1, Item.Body, "New Status: To Verify", vbTextCompare) > 0 Then
                        Item.Display
                    End If
                End If
            Next
        End If
    Next
End Sub

Sub enableAllRules()
    On Error Resume Next
    Set colRules = Application.Session.DefaultStore.GetRules()
    For Each currentRule In colRules
        currentRule.Enabled = True
    Next
    colRules.Save
End Sub
