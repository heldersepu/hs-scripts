'Tool to revert all files in a folder
Set objShell = CreateObject("WScript.Shell")

If WScript.Arguments.Count > 0 Then
    dFolder = ""
    dComment = "Revert to previous release"
	Select Case UCase(WScript.Arguments.Item(0)) '//  Declare all directory Variables
		Case "GA", "/GA" 
			dFolder = "C:\NEWQQGA"
		Case "TX", "/TX"
			dFolder = "C:\QUICK95"
		Case "FL", "/FL"
			dFolder = "C:\newqq95"
		Case Else
			'CALL objShell.Run("notepad doRevert.vbs")
	End Select
    if dFolder <> "" then 
        'Open the Update to Revison dialog
        strCommand = "TortoiseProc /command:update /rev /path:" & dFolder & " /notempfile /closeonend"
        CALL objShell.Run(strCommand ,1,true)
        
        strCommand = "TortoiseProc /command:commit /path:" & dFolder & " /logmsg:" & chr(34) & dComment & chr(34) & " /notempfile /closeonend"
        CALL objShell.Run(strCommand)
    end if
else
  'CALL objShell.Run("notepad doRevert.vbs")
end if

Set objShell = Nothing

