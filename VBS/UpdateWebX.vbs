'//Update WebXControl
'//

On Error Resume Next
Set filesys = CreateObject("Scripting.FileSystemObject")
If filesys.FolderExists("\\jazaretpc\public\QQFL\WebxControl\") then  '// Check if Network folder exist
	Set sFolder = filesys.GetFolder("\\jazaretpc\public\QQFL\WebxControl\")
	set SubFold = sFolder.Subfolders
	first = true
	For Each SubF in SubFold	'//Loop Loop through all folders
		If first then
			set sFolder = SubF
		else
			If (now - SubF.DateCreated) < (now - sFolder.DateCreated) then set sFolder = SubF  '//Get the latest folder
		End if
		first = false
	Next
	LocStr = "C:\Program Files\QuickQuote\Common Files\WebxControl.ocx"
	SvrStr = "\\jazaretpc\public\QQFL\WebxControl\" & sFolder.Name & "\WebxControl.ocx"
	If filesys.FileExists(SvrStr) Then  '//Check if File exist
		R = MsgBox ("Make sure that you exit all versions of           "& vbcrlf &_
					"Quick Quote prior to pressing any key.            "& vbcrlf &_
					"If you are NOT ready, click Cancel           ",49, "  Update WebxControl ?")
		If R = 1 then
			Set objShell    = CreateObject("WScript.Shell")
			If filesys.FileExists(LocStr) then
				set LocFile = filesys.GetFile(LocStr)
				set SvrFile = filesys.GetFile(SvrStr)
				If LocFile.DateLastModified = SvrFile.DateLastModified then
					R = MsgBox ("    The WebxControl.ocx on your pc is the latest           "& vbcrlf &_
								"             No further action is required.         ",64, "  No Action Required !")
				else
					objShell.Run "regsvr32 /s """ & LocStr & """ -u"
					LocFile.delete
					If filesys.FileExists(LocStr) then    '// if File exist deletion was not successful
						R = MsgBox ("       Unable to delete file WebxControl.ocx              "& vbcrlf &_
									" Make sure that the file is not in use and try again.              ",16, "  Can not delete File !")
					End if
				End if
			End if
			If not filesys.FileExists(LocStr) then  '// check again to make sure that it was deleted
				filesys.CopyFile SvrStr, LocStr, true
				objShell.Run "regsvr32 """ & LocStr & """"
			End if
		End if
	else
		R = MsgBox ("    The file WebxControl.ocx was not found on:              "& vbcrlf &_
					"\\jazaretpc\public\QQFL\WebxControl\" & sFolder.Name &"\" & vbcrlf & vbcrlf &_
	    		    "     Make sure that the file exists and try again.              ",16, "  File not Found !")
	End if
else
	R = MsgBox ("  The Folder WebxControl was not found on:          "& vbcrlf &_
				"               \\jazaretpc\public\QQFL       "& vbcrlf & vbcrlf &_
	    	    "      Check the network path and try again   ",16,"  Folder not Found !")
End if
'	msgbox sFolder.Name &" ** "& SFolder.DateCreated