'Check files for SVN conflicts or Delphi compiling Errors
'  [cscript] CHECKIT.VBS [SVN] [drive:][path]
' SVN - can be used to check SVN log file for conflicts
'

Set filesys = CreateObject("Scripting.FileSystemObject")
ErrorLog = ".\Error.txt"
Set outFile	= filesys.CreateTextFile(ErrorLog, True)
strSVNout = ""

'Check all the files in the Args
If WScript.Arguments.Count > 1 then
    For I = 1 to WScript.Arguments.Count - 1
        if UCase(WScript.Arguments.Item(0)) = "SVN" then
            strSVNout = CheckSVN(WScript.Arguments.Item(I))
        else
            CheckDebug(WScript.Arguments.Item(I))
        end if
    Next
else
    'if no Args then Check all text files in the current foder
    Set Fldr = filesys.GetFolder(".")
    For Each File In Fldr.Files
    	If UCase(Right(File,4)) = ".TXT" then
    		CheckDebug(File)
    	End If
    	'wscript.echo File
    Next
end if
outFile.Close

'Check the Error Log file
set DiffFile = filesys.GetFile(ErrorLog)
If  ( DiffFile.size > 0 ) then
    On Error Resume Next
	Set objShell = CreateObject("WScript.Shell")
	objShell.Run "notepad.exe " & ErrorLog
    If strSVNout <> "" then
        Wscript.echo vbcrlf & vbcrlf & _
                " ==[  CONFLICTS FOUND IN THE SVN UPDATE!  ]== " & _
                vbcrlf & vbcrlf & strSVNout & vbcrlf & vbcrlf & _
                "Press ENTER to continue . . ."
        Wscript.StdIn.Read(1)
    End If
Else
    '// If the file is Size = 0 delete it!!!
    DiffFile.Delete true

	If strSVNout <> "" then
        'Show OK message
    	Wscript.echo vbcrlf & vbcrlf & _
    		"       **************************************       " & vbcrlf & _
    		"          All Files Updated Successfully!           " & vbcrlf & _
    		"       **************************************       " & _
    		vbcrlf & vbcrlf & vbcrlf & vbcrlf
    else
    	'Show OK message
    	Wscript.echo vbcrlf & vbcrlf & _
    		"       **************************************       " & vbcrlf & _
    		"          All Files Compiled Successfully!          " & vbcrlf & _
    		"       **************************************       " & _
    		vbcrlf & vbcrlf & vbcrlf & vbcrlf
        'Wscript.Sleep 5000
    end if
End If

'Check the Log file for errors - (SVN update CONFLICTS) -
Function CheckSVN(strFile)
	dFile = Trim(strFile)
    strAllText = ""
	If filesys.FileExists(dFile) Then
		Set db = filesys.OpenTextFile(dFile, 1)
        strAllText = db.ReadAll : db.Close
        'in case of conflicts the first letter will be "C" - more info in SVN manual
        For Each ThisLine in Split(strAllText, VbCrLF)
			If UCase(Left(ThisLine,2)) = "C " Then
				outFile.WriteLine(dFile & VbCrLf & ThisLine & VbCrLf)
			End If
		Next
	End If
    CheckSVN = strAllText
End Function

'Check the Log file for errors -(Compiling ERRORS or FATAL operations) -
Sub CheckDebug(strFile)
	dFile = Trim(strFile)
	If filesys.FileExists(dFile) Then
		'Open the file in read mode
        Set db = filesys.OpenTextFile(dFile, 1)
		Do until db.AtEndOfStream
			'Read line by line
            ThisLine = db.ReadLine
			'Look for "Error:" - add to outfile if found
            If InStr(ThisLine, "Error:") > 0 Then
				outFile.WriteLine(dFile & VbCrLf & ThisLine & VbCrLf)
			Else 'Look for "Fatal:" - add to outfile if found
				If InStr(ThisLine, "Fatal:") > 0 Then
					outFile.WriteLine(dFile & VbCrLf & ThisLine & VbCrLf)
				End If
			End If
		Loop
		db.Close
	End If
End Sub

