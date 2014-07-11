'Read the latest info from the What's new files

'On Error Resume Next
Set objWord = CreateObject("Word.Application")
myReport = ""
'objWord.Visible = true

If Err.Number <> 0 Then
   Wscript.Echo "You must have Word installed to perform this operation! " & _
                VbCrLF & "  Unable to create object (Word.Application)."
Else
    Set objShell = CreateObject("WScript.Shell")
    'Get fullPath to the desktop
    myReport = objShell.SpecialFolders("MyDocuments") & "\report.diff"

    ServerPath = "\\AppSrvA\QQData\QuickQuoteForWindows\"
    WhatsNew = "\Whats New\"
    'Array With the Paths to "What's New" Folders
    Dim ArrFolders(2)
    ArrFolders(0) = ServerPath & "Texas"   & WhatsNew
    ArrFolders(1) = ServerPath & "Florida" & WhatsNew
    ArrFolders(2) = ServerPath & "Georgia" & WhatsNew

    Set FSO = CreateObject("Scripting.FileSystemObject")
    Set outFile = FSO.CreateTextFile(myReport, True)

    For Each item In ArrFolders
    	If FSO.FolderExists(item) Then _
            Call ReadSubFolders(item)
    Next

    outFile.Close
    Set outFile = Nothing
    'Open the Reports
    objShell.Run "NOTEPAD++ " & myReport
    objShell.Run "NOTEPAD++ " & ReGroup(myReport)

    Set objShell = Nothing
    Set FSO = Nothing
End If

objWord.Quit
Set objWord = Nothing

Function ReGroup(strFilePath)
    Set myOutFile = FSO.CreateTextFile(strFilePath & ".py", True)
    Set myInFile  = fso.OpenTextFile(strFilePath, 1)
    strAllFile = myInFile.ReadAll
    myInFile.Close
    Set myInFile  = Nothing

    arrLines = Split(strAllFile, "@")
    For I = 0 to Ubound(arrLines) - 1
        If trim(arrLines(I)) <> "" and arrLines(I) <> VbCrLF Then
            strCurrent = GetFirst(arrLines(I))
            myOutFile.WriteLine("_" & VbCrLf & strCurrent)
            myOutFile.WriteLine(GetInfo(arrLines(I), False))

            For J = I + 1 to Ubound(arrLines)
                If trim(arrLines(J)) <> "" and arrLines(J) <> VbCrLF Then
                    strNext = GetFirst(arrLines(J))
                    strInfo = GetInfo(arrLines(J), True)
                    If strCurrent = strNext Then
                        If strInfo <> "-" then
                            myOutFile.WriteLine(strInfo)
                        End If
                        arrLines(J) = ""
                    End If
                End If
            Next
        End If
    Next

    myOutFile.Close
    Set myOutFile = Nothing
    ReGroup = strFilePath & ".py"
End Function

Function GetFirst(strToSplit)
    arrSplit = Split(strToSplit, VbTab)
    If Ubound(arrSplit) > 0 Then
        GetFirst = Trim(arrSplit(0))
    Else
        GetFirst = Trim(strToSplit)
    End If
End Function

Function GetInfo(strToSplit, blnDoRemove)
    strUPPER = Ucase(strToSplit)
    If (InStr(strUPPER, "NO CHANGES") > 0 or _
        InStr(strUPPER, "NO FIXES") > 0) and blnDoRemove then
        GetInfo = "-"
    Else
        dPos = InStr(strToSplit, VbCrLF) + 2
        If dPos > 2 Then
            GetInfo = " " & Trim(Mid(strToSplit, dPos, len(strToSplit) - dPos - 2))
        Else
            GetInfo = " " & Trim(strToSplit)
        End If
    End If
End Function

'Check the subFolders in the given folder
Sub ReadSubFolders(dFolder)
    ArrSubFolders = Array("Beta", "Regular")

    For Each subItem In ArrSubFolders
    	If FSO.FolderExists(dFolder & subItem) Then _
            Call ReadFolder(dFolder & subItem)
    Next
End Sub

'Check for the files in the given folder
Sub ReadFolder(strFolder)
    ArrFiles = Array("CM", "FL", "GA", "TX")

    strFolder = strFolder & "\New"
    For Each strItem In ArrFiles
        strItem = strItem & ".rtf"

        If FSO.FileExists(strFolder & strItem) Then _
            Call ReadFile(strFolder & strItem )

        If FSO.FileExists(strFolder & "Fix" & strItem) Then _
            Call ReadFile(strFolder & "Fix" & strItem)

        'If FSO.FileExists(strFolder & "CO" &  strItem) Then _
        '    Call ReadFile(strFolder & "CO" &  strItem)
    Next
End Sub

'Read the latest version from the given file
Sub ReadFile(strFile)
    strTxt = RtfToTXT(strFile)
    If FSO.FileExists(strTxt) then
        'File was suceesfully converted
        Set inFile  = fso.OpenTextFile(strTxt, 1)
        strReadAll = inFile.ReadAll
        dPos = inStr(strReadAll, VbCrLf & "QuickQuote") - 1
        If dPos > 0 then
            srtHead = Replace(strFile, ServerPath, "@ ")
            srtHead = Replace(srtHead, WhatsNew, " ")
            srtHead = Replace(srtHead, "\", VbTab & VbTab)
            srtHead = Ucase(srtHead)

            strInfo = Trim(Left(strReadAll, dPos))
            strInfo = Replace(strInfo, VbTab, " ")
            strInfo = Replace(strInfo, "*", " ")

            outFile.WriteLine(srtHead)
            outFile.WriteLine(strInfo)
        End If
        inFile.Close
        Set inFile  = Nothing
    End If
End Sub

'Convert an rft file to txt
Function RtfToTXT(strFileSource)
    strFileDestin = Wscript.Path & "\temp.rtf.txt"
    'delete the file if it exists
    If FSO.FileExists(strFileDestin) Then _
        Call FSO.DeleteFile(strFileDestin)

    If UCase(Right(strFileSource, 4)) = ".RTF" and _
       FSO.FileExists(strFileSource) Then
        'Read the source
        Set objDoc = objWord.Documents.Open(strFileSource)
        'Save the source as text
        Call objDoc.SaveAs(strFileDestin, 2)
        objDoc.Close
        Set objDoc =  Nothing
    Else
        strFileDestin = ""
    End If
    RtfToTXT = strFileDestin
End Function

