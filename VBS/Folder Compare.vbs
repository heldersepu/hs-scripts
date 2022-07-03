' Compare the Contents of 2 Folders
On Error Resume Next
directory1 = ""
directory2 = ""
iNum = WScript.Arguments.Count
If iNum >= 2  Then
	' -- Get the Directories via Arguments
	directory1 = WScript.Arguments.Item(0)
	directory2 = WScript.Arguments.Item(1)
Else
	' -- Get the Directories via Explorer
	set WshShell = WScript.CreateObject("WScript.Shell")
	strDesktop = WshShell.SpecialFolders("Desktop")

	Set SA = CreateObject("Shell.Application")
	Set d1 = SA.BrowseForFolder(0, "Choose folder #1", 0, strDesktop)
	If  (d1 Is Nothing) Then Wscript.Quit
	directory1 = d1.Items.Item.Path

	Set d2 = SA.BrowseForFolder(0, "Choose folder #2", 0, strDesktop)
	If  (d2 Is Nothing) Then Wscript.Quit
	directory2 = d2.Items.Item.Path
End If

If directory1 <> "" and directory2 <> "" then
	' -- Initialize the Folder Var containing the files collection
	Set fso  = CreateObject("Scripting.FileSystemObject")
	Set Fldr1 = fso.GetFolder(directory1)
	Set Fldr2 = fso.GetFolder(directory2)

	' -- Get all files in the folder1 and put them on array
	cnt1 = 0
	For Each File In Fldr1.Files
	   If UCase(Right(File,4)) <> ".UNK" and _
		  UCase(Right(File,4)) <> ".LNK" Then ' Get the all the files but the .UNK and .LNK
			cnt1 = cnt1 + 1
			Redim Preserve arFiles1(cnt1)
			arFiles1(cnt1) = File.Name
	   End if
	next

	' -- Get all files in the folder2 and put them on array
	cnt2 = 0
	For Each File In Fldr2.Files
		If UCase(Right(File,4)) <> ".UNK" and _
		   UCase(Right(File,4)) <> ".LNK" Then ' Get the all the files but the ...
			cnt2 = cnt2 + 1
			Redim Preserve arFiles2(cnt2)
			arFiles2(cnt2) = File.Name
		End If
	next

	' -- Create OutPut File
	Set objExcel = createobject("Excel.application")
	objexcel.Visible = False
	objexcel.Workbooks.add
	objexcel.Cells(1, 1).Value = "Difference in folders "
	objExcel.Cells(1, 1).Font.Bold = TRUE
	objExcel.Cells(1, 1).Font.Size = 12
	objexcel.Cells(2, 1).Value = directory1
	objexcel.Cells(3, 1).Value = directory2

	objexcel.Cells(5, 1).Value = "Removed"
	objExcel.Columns(1).columnwidth=20
	objexcel.Cells(5, 2).Value = "Modified"
	objExcel.Columns(2).columnwidth=20
	objexcel.Cells(5, 3).Value = "Added"
	objExcel.Columns(3).columnwidth=20
	objExcel.Range("A5:C5").Interior.ColorIndex = 15
	objExcel.Range("A5:C5").HorizontalAlignment = 3
	objExcel.Range("A5:C5").Font.Bold = TRUE
	'objExcel.Cells(5, 3).BorderLineStyle(sabpLeft) = 5


	' -- Compare Files in Folder1 with Files in Folder2
	iRemov = 6
	iModif = 6
	For I = 1 to cnt1
		Exist  = False
		Modif = False
		For J = 1 to cnt2
			' -- Compare the file names
			If Ucase(arFiles1(I)) = Ucase(arFiles2(J)) Then
				Exist = True
				Set f1 = fso.GetFile(Fldr1 & "\" & arFiles1(I))
				Set f2 = fso.GetFile(Fldr2 & "\" & arFiles2(J))
				' -- Compare the date
				If f1.DateLastModified <> f2.DateLastModified then
					Modif = True
				End if
			End if
		Next
		If Exist = False Then
			objexcel.Cells(iRemov, 1).Value = arFiles1(I) '"<- Removed"
			iRemov = iRemov + 1
		Else
			If Modif = True then
				objexcel.Cells(iModif, 2).Value = arFiles1(I) '"<- Modified"
				iModif = iModif + 1
			End If
		End If
	Next

	' -- Compare Files in Folder2 with Files in Folder1
	iAdded = 6
	For I = 1 to cnt2
		Exist  = False
		For J = 1 to cnt1
			' -- Compare the file names
			If Ucase(arFiles2(I)) = Ucase(arFiles1(J)) Then
				Exist = True
			End if
		Next
		If Exist = False Then
			objexcel.Cells(iAdded, 3).Value = arFiles2(I) '" <- Added "
			iAdded = iAdded + 1
		End If
	Next

	If iAdded > iRemov then
		If iAdded > iModif then
			max = iAdded
		else
			max = iModif
		End If
	Else
		If iRemov > iModif then
			max = iRemov
		Else
			max = iModif
		End If
	End If

	set dRange = objexcel.Range("A5:C" & max-1)

	dRange.Borders(1).Weight=2
	dRange.Borders(2).Weight=2
	dRange.Borders(3).Weight=2
	dRange.Borders(4).Weight=2

	If fso.FileExists(strDesktop & "\diff.xls") Then
		fso.DeleteFile(strDesktop & "\diff.xls")
	End If
	objexcel.ActiveWorkbook.SaveAs (strDesktop & "\diff.xls") ', 3,"abc"  ' FileName , Property, Password
	objexcel.Quit
End if
