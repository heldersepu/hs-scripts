' BackUp "MainNt2" to keep a safe copy in case of a disaster

 'Storage Folder needs Write access
 myFldBackUp = "C:\BackUp\"
 'Array with the Folders to be Backed Up
 FldArray    = Array("H:\Newqq95", "H:\QUICK95")
 'Array with all the SubFolders needs Read access
 SubFldArray = Array("\allcomp", "\compzips")
 'Array with all needed extencions "Must be UPPERCASE" & 4 chars
 ExtArray = Array(".PAS", ".DBF", ".HTF")
 'File Separator Must be a char not allowed on file names
 strSepa = "|"

If WScript.Arguments.Count > 0  Then
	Set objShell = CreateObject("WScript.Shell")
	objShell.Run "notepad BackUp.vbs"
Else
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	With objFSO
		If Not .FolderExists(myFldBackUp) then .CreateFolder(myFldBackUp)
		'Create a new folder name it using current Date & Time
		FldBackUp = myFldBackUp & "Update " & Replace(Replace(NOW,"/","-"),":",".")
		.CreateFolder(FldBackUp)

		For Each FldItem In FldArray
			If .FolderExists(FldItem) then
				'Create the same folder on the local backup
				FldLocal = Mid(FldItem,InStr(FldItem,"\"),Len(FldItem))
				.CreateFolder(FldBackUp & FldLocal)
				'Loop through all subfolders
				For Each SubFldItem In SubFldArray
					If .FolderExists(FldItem & SubFldItem) then
						'Loop through all files
						For Each File in .GetFolder(FldItem & SubFldItem).Files
							ucFile = UCase(Right(File.Name,4))
							For Each ExtItem In ExtArray
								'Only Copy the given ext
								If (ExtItem = ucFile) then
									If Not .FolderExists(FldBackUp  & FldLocal & SubFldItem) then
										.CreateFolder(FldBackUp & FldLocal & SubFldItem)
									End if
									'Wscript.Echo File.Path & ", " & FldBackUp  & FldLocal & SubFldItem
									.CopyFile File.Path, FldBackUp  & FldLocal & SubFldItem & "\", true
									'.CopyFolder FldItem & SubFldItem, FldBackUp  & FldLocal & SubFldItem , true
								End if
							Next
						Next
					End If
				Next
			Else
				MsgBox "Folder not Found" & VbCrLf & FldItem
			End If
		Next
		MsgBox "     BackUp Completed!     "
		Call RemoveSVN(.GetFolder(FldBackUp))

	End With
	Set objFSO = Nothing
End If

'Remove all the SVN folders recursively
Sub RemoveSVN(dFolder)
	For Each Subfolder in dFolder.SubFolders
		dSubFolder = UCase(Subfolder.Name)
		If (dSubFolder = ".SVN") or (dSubFolder = "_SVN") then
			Subfolder.Delete(True)
		Else
			Call RemoveSVN(Subfolder)
		End If
    Next
End Sub
