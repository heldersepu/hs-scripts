'On Error Resume Next
Set fso = CreateObject("Scripting.FileSystemObject")
Redim arrFiles(0)
Redim arrSFiles(0)
myFile = ""
jsCount = 0

' Input via Arguments
If WScript.Arguments.Count > 0 Then
	If fso.FileExists(WScript.Arguments.Item(0)) Then
		myFile = WScript.Arguments.Item(0)
	End If
End If

'Call the Convert Procedure
If myFile <> "" Then
	Set batFile = fso.OpenTextFile("C:\SecretAgent\TOOLS\Build\BUILD.bat", 1)
    strBatFile = batFile.ReadAll
    batFile.Close
    If validStruct(myFile) Then
        Call DoConvert(myFile, strBatFile)
    Else
        Call MsgBox("Invalid File structure!!", 16, "Error")
    End If
Else
    Call add2SendTo(wscript.ScriptName)
End If

Function validStruct(dFile)
    Set inFile  = fso.OpenTextFile(dFile, 1)
	dLine = inFile.ReadLine
    inFile.Close
	validStruct = (UCase(dLine) = """ID"",""FILES CHANGED"",")
End Function

Sub add2SendTo(ScriptName)
    Set oShell = CreateObject("WScript.Shell")
    strHomeFolder = oShell.ExpandEnvironmentStrings("%APPDATA%")
    fso.CopyFile ScriptName, strHomeFolder &"\Microsoft\Windows\SendTo\" & ScriptName, true
End Sub


Sub DoConvert(dFile, strBatFile)
	Set inFile  = fso.OpenTextFile(dFile, 1)
	Set ObjFile = fso.GetFile(dFile)
    newFile = ObjFile.ParentFolder  & "\tf_" & DatePart("m", Now) & "-" & DatePart("d", Now) & "_" & ObjFile.Name & ".bat"
	Set ObjFile = Nothing
	Set outFile = fso.CreateTextFile(newFile, True)
    outFile.WriteLine(getHeaders())
	

	'Loop file & copy info to new file
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
        strId = Left(dLine, 12)
		intPos = InStr(strId, ",")
        If (intPos > 0) Then
            'Determine element ID, Files Changed
            strId = CleanHTML(Left(strId, intPos))
            If (strId <> "ID") Then
                outFile.WriteLine(":: " & strId)
                'Splitting of files change
                strFilesChanged = Replace(dLine, strId, "")
                outFile.WriteLine(getFilesChanged(strFilesChanged))
                outFile.WriteLine("")
            End If
        End If
	Loop
	inFile.Close

    'Write the build
    If (UBound(arrFiles) > 0) Then
        outFile.WriteLine(vbCrLf & vbCrLf & ": BUILD" & vbCrLf)
        outFile.WriteLine(getBuildHeaders(strBatFile))
        outFile.WriteLine(getBuildFiles(arrFiles, strBatFile))
    End If

    'Write the build
    If (UBound(arrSFiles) > 0) Then
        outFile.WriteLine(vbCrLf & vbCrLf & ": COPY_FILES" & vbCrLf)
        outFile.WriteLine(getSimpleFiles(arrSFiles))
    End If

	'Show JS Warning
	If (jsCount > 0) Then
		outFile.WriteLine(getJSWarning())
	End If
    
    outFile.WriteLine(getFooter())
	outFile.Close
End Sub

Function getFooter()
    getFooter = vbCrLF & "@ECHO.&PAUSE" & vbCrLF
End Function

Function getBuildHeaders(strBatFile)
    intRDPos = inStr(strBatFile, ":START_BUILDING")
    If intRDPos > 0 Then
        getBuildHeaders = Left(strBatFile, intRDPos -1)
    Else
        getBuildHeaders = ""
    End If
End Function

Function getHeaders()
    getHeaders = "@ECHO.&ECHO.&ECHO.&COLOR 0C" & vbCrLF & _
	    "@ECHO ******************************************************************************" & vbCrLF & _
	    "@ECHO.&ECHO." & vbCrLF & _
	    "@ECHO    This script will get the latest of files, build them and then copy to QA" & vbCrLF & _
	    "@ECHO." & vbCrLF & _
	    "@ECHO             CHECK THE FILE'S DESTINATION BEFORE PROCEEDING!!" & vbCrLF & _
	    "@ECHO.&ECHO." & vbCrLF & _
	    "@ECHO ******************************************************************************" & vbCrLF & _
	    "@ECHO.&ECHO.&@PAUSE" & vbCrLF & _
	    "@CLS" & vbCrLF & _
        "@SET TFDIR=""%ProgramFiles(x86)%\Microsoft Visual Studio 11.0\Common7\IDE""" & vbCrLF & _
        "@IF NOT EXIST %TFDIR% SET TFDIR=""%ProgramFiles%\Microsoft Visual Studio 11.0\Common7\IDE""" & vbCrLF & _
        "@IF NOT EXIST %TFDIR% SET TFDIR=""C:\TFS""" & vbCrLF & _
        "@SET PATH=%PATH%;%TFDIR%" & vbCrLF & _
        "@C:" & vbCrLF & _
        "@CD %TFDIR%" & vbCrLF & _
        "@COLOR 0A" & vbCrLF & _
        "@PROMPT $S" & vbCrLF &  vbCrLF

End Function

Function getJSWarning()
    getJSWarning = "@ECHO." & vbCrLF & "@ECHO." & vbCrLF & "@ECHO." & vbCrLF & _
		"@ECHO   This build contains js files" & vbCrLF & _
		"@ECHO Run the build scripts for js files" & vbCrLF & _
		"@ECHO." & vbCrLF & "@ECHO." & vbCrLF & "@PAUSE"
End Function

Function getSimpleFiles(arrSFiles)
    strSimpleFiles = "@SET DESTIN=NFQA01" & vbCrLf & vbCrLf
    'Sort Files
    For J = 1 To Max-1
        For K = J + 1 To Max
            If (UCase(arrSFiles(J)) > UCase(arrSFiles(K))) Then
                temp = arrSFiles(J)
                arrSFiles(J) = arrSFiles(K)
                arrSFiles(K) = temp
            End If
        Next
    Next
    'Output the files
    For Each strFile in arrSFiles
        If Trim(strFile) <> "" Then
            strSimpleFiles =  strSimpleFiles & "XCOPY /R /Y  " & strFile & "   \\%DESTIN%\" & Replace(strFile, "C:", "C$") & vbCrLf
        End If
    Next
    getSimpleFiles = strSimpleFiles
End Function

Function getBuildFiles(arrFiles, strBatFile)
    cleanFilesChanged = vbCrLf
    Max = UBound(arrFiles)

    'Extract projects from files
    Redim arrProjects(0)
    For J = 0 To Max
        If Trim(arrFiles(J)) <> "" Then
            strProject = getProject(arrFiles(J))
            'Avoid Duplicates
            isUnique = True
            For Each strFile in arrProjects
                If strProject = strFile Then
                    isUnique = False
                    Exit For
                End If
            Next
            If isUnique Then
                I = UBound(arrProjects) + 1
                Redim Preserve arrProjects(I)
                arrProjects(I) = strProject
            End If
        End If
    Next

    'Get the build order from the bat
    Max = UBound(arrProjects)
    arrBatFile = Split(strBatFile, vbCrLf)
    batMax = UBound(arrBatFile)
    For J = 1 To Max
        strProj = ""
        For K = 1 To batMax
            If InStr(Ucase(arrBatFile(K)), arrProjects(J)) > 0 Then
                strProj = Replace(Ucase(arrBatFile(K)), "START ", "")
                If LEFT(Ucase(arrBatFile(K + 1)), 4) = "COPY" Then
                    strProj = strProj & " & " & arrBatFile(K + 1)
                End If
                Exit For
            End If
        Next
        If (strProj <> "") Then
            arrProjects(J) = strProj
        End If
    Next

    'Sort projects
    For J = 1 To Max-1
        For K = J + 1 To Max
            If (arrProjects(J) > arrProjects(K)) Then
                temp = arrProjects(J)
                arrProjects(J) = arrProjects(K)
                arrProjects(K) = temp
            End If
        Next
    Next

    'Output the projects
    cleanFilesChanged = cleanFilesChanged & "@COLOR 0A" & vbCrLf & ":VS_2003" & vbCrLf & _
        "CD ""C:\Program Files (x86)\Microsoft Visual Studio .NET 2003\Common7\IDE""" & vbCrLf
    Count2012 = 0
    For Each strFile in arrProjects
        If Trim(strFile) <> "" Then
            If getProjectBuild(strFile) > 599 Then
                Count2012 = Count2012 + 1
            End If
            If Count2012 = 1 Then
                cleanFilesChanged = cleanFilesChanged & vbCrLf &  "@COLOR 0E" & vbCrLf & ":VS_2012" & vbCrLf & _
                    "CD ""C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE""" & vbCrLf
            End If
            cleanFilesChanged = cleanFilesChanged & strFile & vbCrLf
        End If
    Next
    getBuildFiles = Replace(cleanFilesChanged, " & ", vbCrLf)  & vbCrLf
End Function

Function getProjectBuild(strFile)
    intProjectBuild = 0
    dPos = inStr(strFile, "C:\BUILD\BLD")
    If dPos > 0 Then
        intProjectBuild = cInt(Mid(strFile, dPos + 12, 4))
    End If
    getProjectBuild = intProjectBuild
End Function

Function getProject(strFile)
    strProject = strFile
    intSPos = 0
    For K = 0 To 4
        intSPos = InStr(intSPos + 1, strFile, "\")
    Next
    If (intSPos > 0) Then
        strProject = getProjFile(Left(strFile, intSPos))
        If strProject = "" Then
            intSPos = InStr(intSPos + 1, strFile, "\")
            If (intSPos > 0) Then
                strProject = getProjFile(Left(strFile, intSPos))
            End If
        End If
        If strProject = "" Then
            strProject = strFile
        End If
    End If
    getProject = UCase(strProject)
End Function

Function getProjFile(strFolder)
    strProjFile = ""
    If FSO.FolderExists(strFolder) Then
        For Each File In FSO.GetFolder(strFolder).Files
            strExt = UCase(Right(File, 6))
            If (strExt = "VBPROJ" OR strExt = "CSPROJ") Then
                strProjFile = File
                Exit For
            End If
        Next
    End If
    getProjFile = strProjFile
End Function

Function getFilesChanged(strRawFilesChanged)
    cleanFilesChanged = ""
    For Each item in Split(strRawFilesChanged, ">")
        item = CleanHTML(Trim(item))
        If UCase(Left(item,2)) = "C:" Then
            If checkForJS(item) Then
                jsCount = jsCount + 1
            End If
            If haveToBuild(item) Then
                I = UBound(arrFiles) + 1
                Redim Preserve arrFiles(I)
                arrFiles(I) = item
            Else
                I = UBound(arrSFiles) + 1
                Redim Preserve arrSFiles(I)
                arrSFiles(I) = item
            End If
            cleanFilesChanged = cleanFilesChanged + "CALL TF GET  " & item & "  /overwrite /force" & vbCrLf
        End If
    Next
    getFilesChanged = cleanFilesChanged
End Function

Function haveToBuild(strFile)
    haveToBuild = False
    srtItems = ".VB,.CS,.VBPROJ,.CSPROJ"
    For each item in Split(srtItems, ",")
        If (item = UCase(Right(strFile, Len(item)))) Then
            haveToBuild = True
            Exit For
        End If
    Next
End Function

Function CleanHTML(dLine)
	srtItems = "<div,"",</div,<strong,</strong,<br /,&nbsp;,</span,<span,</li,<li"
    For each item in Split(srtItems, ",")
        dLine = Replace(dLine, item, "")
    Next
    dLine = Replace(dLine, "/", "\")
    srtItems = "\\enstaging01,\\enstaging02,\\enstaging03"
    For each item in Split(srtItems, ",")
        dLine = Replace(dLine, item, "C:")
    Next
	srtItems = "$\SecretAgent\SecretAgent,C:\SecretAgent\SecretAgent,c:"
    For each item in Split(srtItems, ",")
        dLine = Replace(dLine, item, "C:\SecretAgent")
    Next
	
    intPos = InStr(dLine, "  ")
    If (intPos > 0) Then
        dLine = Trim(Left(dLine, intPos))
    End If
	intPos = InStr(LCase(dLine), "changeset")
    If (intPos > 0) Then
        dLine = Trim(Left(dLine, intPos-1))
    End If
    srtItems = "[,(,{"
    For each item in Split(srtItems, ",")
        intPos = InStr(dLine, item)
        If (intPos > 0) Then
            dLine = Trim(Left(dLine, intPos-1))
        End If
    Next
    CleanHTML = Trim(Replace(dLine, ",", ""))
End Function

Function checkForJS(strFile)
    checkForJS = False
    If (UCase(Right(strFile,3)) = ".JS") Then
        checkForJS = True
    End If
End Function
