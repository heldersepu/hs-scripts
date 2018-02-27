'// Update Public directory will create a folder with the current Date < Ex: Dec04 >
'// 
'// UP [FL] [GA] [TX]
'//   
'//   FL	Update Florida
'//   GA	Update Georgia
'//   TX	Update Texas

'On Error Resume Next
Set objShell = CreateObject("WScript.Shell")
If WScript.Arguments.Count > 0 Then
	Select Case UCase(WScript.Arguments.Item(0)) 
		Case "GA", "/GA" 
			Call DoCopy("C:\Public\Georgia", "C:\QuickGA")
		Case "TX", "/TX"
			Call DoCopy("C:\Public\Texas", "C:\QuickTX")
		Case "FL", "/FL"
			Call DoCopy("C:\Public\Florida", "C:\QuickFL")
		Case Else
			objShell.Run "NOTEPAD++ up.vbs"
	End Select    
Else
	objShell.Run "NOTEPAD++ up.vbs"		
End If
Set objShell = Nothing


Sub DoCopy(strPub, strFolder)
	'//  Get Date in MMMDD format Ex: Feb29 :)
	a = Day(now)
	if (a < 10) then a = "0" & a
	PubCF  = strPub & "\" & MonthName(Month(now), True) & a 
	
	'Create the folders if they do not exist
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	If Not objFSO.FolderExists(strPub) then objFSO.CreateFolder(strPub)
	if Not objFSO.FolderExists(PubCF) then objFSO.CreateFolder(PubCF)
	
	'Copy the Files
	Set Fldr = objFSO.GetFolder(strFolder)
	Set appShell = CreateObject("Shell.Application")
	Set objFolder = appShell.NameSpace(PubSo &b &a)
	For Each File In Fldr.Files
		dExt = UCase(Right(File.Name,3)) 
		If (dExt = "MDB") or (dExt = "MDE") then
			objFolder.CopyHere  File.Path ,8
		End If
	Next
	
	Set appShell = Nothing
	Set objFSO = Nothing
End Sub
