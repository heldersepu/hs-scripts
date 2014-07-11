'// Update Public directory will create a folder with the current Date < Ex: Dec04 >
'// 
'// UP [FL] [GA] [TX]
'//   
'//   FL	Update only Florida
'//   GA	Update only Georgia
'//   TX	Update only Texas
'//   All	"ALL" can be used to process all states  
'//   PAS      Update all .pas files from all states

'On Error Resume Next
Set objShell    = CreateObject("WScript.Shell")
iNum = WScript.Arguments.Count
If iNum > 0 Then
	If iNum >= 2 Then
		dRemin = WScript.Arguments.Item(1)
	Else
		dRemin = "YesRemi"
	End If
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	'//  Get Date in MMMDD format Ex: Feb29 :)
	a = Day(now)
	b = MonthName(Month(now), True)
	if a < 10 then a = "0"&a
	Select Case UCase(WScript.Arguments.Item(0)) '//  Declare all directory Variables
		Case "SVN", "/SVN"
			' Update the SubVercion files from the HEAD revision 
			strCommand = "TortoiseProc /command:update " & _
			             "/path:C:\newqq95*C:\qqfleng*C:\NEWQQGA*C:\qqenginems*C:\Quick95*C:\qqtxeng " & _
						 "/notempfile /closeonend"
			If iNum >= 2 then 'auto close if no errors, conflicts and merges
			  objShell.Run strCommand & ":3"
			else              'don't close the dialog 
			  objShell.Run strCommand 
			end if
			Wscript.Quit
		Case "ALL", "/ALL" 
			objShell.Run "up.vbs GA NoRemi"
			Wscript.Sleep 3000
			objShell.Run "up.vbs FL NoRemi"
			Wscript.Sleep 3000
			objShell.Run "up.vbs TX" 
			Wscript.Quit
		Case "GA", "/GA" 
			Pub    = "C:\Public\Georgia"
			Source = "C:\NEWQQGA\allcomp"
			Engine = "qqenginems.exe"
			InterF = "C:\QuickGA\qqga.mde"
			InterC = "C:\QuickGA\GA.mde"
			Dlls   = "GACompDll"
			Zips   = "GACompzips"
		Case "TX", "/TX"
			Pub    = "C:\Public\Texas"
			Source = "C:\QUICK95\allcomp"
			Engine = "QQTXEngine.exe"
			InterF = "C:\QuickTX\QQTX.mde"
			InterC = "C:\QuickTX\TX.MDE"
			Dlls   = "TXCompDll"
			Zips   = "TXCompzips"
		Case "FL", "/FL"
			Pub    = "C:\Public\Florida"
			Source = "C:\newqq95\allcomp"
			Engine = "qqengine.exe"
			InterF = "C:\QuickFL\qqfl.mde"
			InterC = "C:\QuickFL\FL.mde"
			Dlls   = "CompDll"
			Zips   = "Compzips"
		Case "PAS", "/PAS"
			PubSo  = "C:\Public\Georgia\Source\"
			Source = "C:\NEWQQGA\allcomp"
			Dlls   = "GACompDll"
			Call Sources
			PubSo  = "C:\Public\Texas\Source\"
			Source = "C:\QUICK95\allcomp"								
			Dlls   = "TXCompDll"
			Call Sources
			PubSo  = "C:\Public\Florida\Source\"
			Source = "C:\newqq95\allcomp"
			Dlls   = "CompDll"										  
			Call Sources
			Wscript.Sleep 1000
			Wscript.Quit
		Case "TESTVER", "/TESTVER", "TEST", "/TEST", "ACE", "/ACE"
			If objFSO.FolderExists("C:\WINDOWS\UpTestVer\") then 
				objShell.Run """C:\WINDOWS\UpTestVer\"""
			End If
			Wscript.Quit
		Case Else
			objShell.Run "notepad up.vbs"
			Wscript.Quit
	End Select
	
	'Create the folder if it does not exist
	If Not objFSO.FolderExists("C:\Public\") then objFSO.CreateFolder("C:\Public\")
	If Not objFSO.FolderExists(Pub) then objFSO.CreateFolder(Pub)
	PubSo  = Pub &"\Source\"
	If Not objFSO.FolderExists(PubSo) then objFSO.CreateFolder(PubSo)
	If Not objFSO.FolderExists(Pub &"\Common files\") then objFSO.CreateFolder(Pub &"\Common files\")
	PubCF  = Pub &"\Common files\"&b&a
	Common = "C:\Program Files\QuickQuote\Common Files\"

	'//  Delete the folder & Recreate
	On Error Resume Next
	if objFSO.FolderExists(PubCF)then objFSO.DeleteFolder(PubCF)
	objFSO.CreateFolder(PubCF)
	If Err.Number <> 0 Then 
		MsgBox "Unable to delete folder" & VbCrlf & PubCF & VbCrlf & _
		       "Make sure is not in use and try again."
		Wscript.Quit
	End If
	PubCF  = PubCF&"\"
    
	'//  Copy all Files & Folders
    if Engine = "QQTXEngine.exe" then 'Special Underwriting question OCX
        objFSO.CopyFile   Common & "TxClientIntfXControl.ocx" , PubCF , true
    end if
	objFSO.CopyFile   Common & Engine    	     , PubCF , true
	objFSO.CopyFile   Common & "WebxControl.ocx" , PubCF , true
	objFSO.CopyFile   InterF		, PubCF       , true
	objFSO.CopyFile   InterC		, PubCF       , true
	objFSO.CopyFolder Common &Dlls	, PubCF &Dlls , true
	Set Fldr = objFSO.GetFolder(Common &Zips)
	objFSO.CreateFolder(PubCF &Zips)	
	For Each File In Fldr.Files      
        if UCase(Right(File,4)) <> ".NDX" then 
		objFSO.CopyFile   File , PubCF &Zips&"\" , true
        end if
	Next
	
	Call TestVerReminder(dRemin)
	Call Sources

	'//  Delete all folders in Common files older than 2 days
	Set Foldr = objFSO.GetFolder(Pub&"\Common files")
	For Each Subfold in Foldr.Subfolders
		tempDiff = Now - Subfold.DateCreated
		If ( tempDiff > 2) or ( tempDiff < 0) Then
			Subfold.Delete
		End IF
	Next
Else
	objShell.Run "notepad up.vbs"		
End If

Sub Sources
'//  Copy all .PAS Files that have changed   "Sources"
	If Not objFSO.FolderExists(Source) then objFSO.CreateFolder(Source) 
	Set Fldr = objFSO.GetFolder(Source)
	If Not objFSO.FolderExists(PubSo &b &a) then objFSO.CreateFolder(PubSo &b &a) 
	Set appShell = CreateObject("Shell.Application")
	Set objFolder = appShell.NameSpace(PubSo &b &a)
	For Each File In Fldr.Files
		If ((File.attributes >= 32) and (UCase(objFSO.GetExtensionName(File)) = "PAS")) then
			objFolder.CopyHere  File.Path ,8
			File.attributes = 0
		End If
	Next
'//  Put all daily folders in the same folder named by the month
	Set Fldr = objFSO.GetFolder(PubSo)
	For Each Subfolder in Fldr.SubFolders
		If IsNumeric(Right(Subfolder ,2))  Then
			intFldr = Month(Subfolder.DateCreated)
			If intFldr <> Month(Now()) Then
				myFldr = PubSo & MonthName(intFldr)
				If Not objFSO.FolderExists(myFldr) then objFSO.CreateFolder(myFldr)
				Set objFolder = appShell.NameSpace(myFldr)
				'msgbox "Copy " & Subfolder & " to " & myFldr
				objFolder.MoveHere Subfolder.Path ,8
			End if
		End if
	Next
End Sub

Sub TestVerReminder(dFlag)
	If (UCase(dFlag) = "YESREMI") and (objFSO.FolderExists("C:\WINDOWS\UpTestVer\")) then
		dResp = MsgBox( " All files successfully updated in the Public folder." & VbCrLf & _
		      VbCrLf & "Do not forget to update the TestVer folder if needed!", vbYesNo, "Update TestVer Folder? ")
		If dResp = VbYes Then
			objShell.Run """C:\WINDOWS\UpTestVer\"""
		End if
	End If	
End Sub 
