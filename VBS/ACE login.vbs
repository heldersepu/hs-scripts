'//  Auto Login to ACE using Login.html then go to "My Tasks"
'// Script will self replicate to the "roaming" folder and will create a Login page
'// Can also create a Desktop Shortcut

Set fso  = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")
strDesktop   = objShell.SpecialFolders("Desktop")

strFolderPath = objShell.SpecialFolders(5) 'Per user folder
strLoginHtml = strFolderPath & "\Login.html"
strLoginVbs = strFolderPath & "\Login.vbs"

If WScript.Arguments.Count > 0  Then
	' // Work with the Arguments
	Select Case UCase(WScript.Arguments.Item(0))
		Case "/C", "C"
			' Create a new HTML file in specified folder or in "C:/WINDOWS"
			If (WScript.Arguments.Count > 1)  Then 
				If (fso.FolderExists(WScript.Arguments.Item(1))) Then
					Call CreateLogin(WScript.Arguments.Item(1) & "\Login.html")
				End If
			Else
				Call CreateLogin(strLoginHtml)
			End If
		Case "/S", "S"
			' Create a Shortcut
			If (WScript.Arguments.Count > 1) Then 
				If (fso.FolderExists(WScript.Arguments.Item(1))) then
					Call CreateLink(WScript.Arguments.Item(1), False)
				End If
			Else
				Call CreateLink(strDesktop, True)
			End If
		Case "/R", "R" 
			'Remove all the files
			If fso.FileExists(strLoginHtml) then 
				fso.DeleteFile strLoginHtml
			End If
			'Remove the script
			If fso.FileExists(strLoginVbs) then 
				fso.DeleteFile strLoginVbs
			End If
			'Remove the Link
			If fso.FileExists(strDesktop & "\A.C.E..lnk") then 
				fso.DeleteFile strDesktop & "\A.C.E..lnk"
			End If
			'Remove any link that has the script in the TargetPath
			Set Fldr = fso.GetFolder(strDesktop)
			For Each File In Fldr.Files
				If UCase(Right(File,4))= ".LNK"  then	
					Set oShLink  = objShell.CreateShortcut(File)
					dPath = oShLink.TargetPath
					If (inStr(dPath,"login.vbs" ) > 0) Then
						fso.DeleteFile File
					End If
				End If
			Next
		Case Else
			objShell.Run "notepad " & strLoginVbs
	End Select
Else
	dFile = strLoginHtml
	If (Not fso.FileExists(dFile)) Then
		fso.CopyFile wscript.ScriptName,  strLoginVbs, true
		CreateLogin(dFile)
	End If
	Set objIE = CreateObject("InternetExplorer.Application")
	
	dPage = "file://127.0.0.1/" & replace( replace(strLoginHtml,":","$" ),"\","/" )
	objIE.Navigate(dPage)
	objIE.ToolBar   = False
	objIE.StatusBar = False
	objIE.Resizable = True
	objIE.document.ParentWindow.ResizeTo 1200, 500
	
	Do Until objIE.readyState = 4
		Wscript.Sleep 500
	Loop
	Wscript.Sleep 1000
	objIE.Navigate("http://qqprojects.com/server01/UserTasks.asp")
	Wscript.Sleep 1000
	objIE.document.Title = "Quick Quote Projects"
	objIE.Visible = True
End If

' Create the HTML file that will Auto login 
Sub CreateLogin(dFile)
	UserName = InputBox ("Enter Username","Username")
	If UserName <> "" then 
		PassWord = InputBox ("Enter Password","Password")
		If PassWord <> "" then 
			Set HtmlFile = fso.CreateTextFile(dFile, True)
			HtmlFile.WriteLine("<html> ")
			HtmlFile.WriteLine("<head> ")
			HtmlFile.WriteLine("<title>Login Page</title> ")
			HtmlFile.WriteLine("</head> ")
			HtmlFile.WriteLine("<body OnLoad=""document.login.submit()""> ")
			HtmlFile.WriteLine("<table border=""0"" width=""100%"" height=""100%""> ")
			HtmlFile.WriteLine("<tr> ")
			HtmlFile.WriteLine("  <td valign=""center"" align=""middle""> ")
			HtmlFile.WriteLine("	<div class=""loginbox""> ")
			HtmlFile.WriteLine("	  <form action=""http://qqprojects.com/server01/Login.asp"" method=""post"" name=""login"" target=""_top""> ")
			HtmlFile.WriteLine("		<table border=""0"" width=""240"" > ")
			HtmlFile.WriteLine("		  <tr> ")
			HtmlFile.WriteLine("			<td class=""login_form_txt"" nowrap>Company</td> ")
			HtmlFile.WriteLine("			<td class=""login_form_td""> ")
			HtmlFile.WriteLine("			  <input type=""hidden"" name=""ret_page"" value=""""> <input type=""hidden"" name=""querystring"" value=""""> ")
			HtmlFile.WriteLine("			  <input type=""hidden"" name=""FormName"" value=""LoginForm""> <input type=""text"" name=""Company"" value=""QuickQuote"" maxlength=""50"" size=""20""></td> ")
			HtmlFile.WriteLine("		  </tr> ")
			HtmlFile.WriteLine("		  <tr> ")
			HtmlFile.WriteLine("			<td class=""login_form_txt"">Username</td> ")
			HtmlFile.WriteLine("			<td class=""login_form_td""> ")
			HtmlFile.WriteLine("			  <input type=""text"" name=""Login"" value=""" & UserName & """ maxlength=""50"" size=""20""></td> ")
			HtmlFile.WriteLine("		  </tr> ")
			HtmlFile.WriteLine("		  <tr> ")
			HtmlFile.WriteLine("			<td class=""login_form_txt"" >Password</td> ")
			HtmlFile.WriteLine("			<td class=""login_form_td""> ")
			HtmlFile.WriteLine("			  <input type=""password"" name=""Password"" maxlength=""50"" size=""20"" value=""" & PassWord & """></td> ")
			HtmlFile.WriteLine("		  </tr> ")
			HtmlFile.WriteLine("		  <tr> ")
			HtmlFile.WriteLine("			<td class=""login_form_td"" colspan=""2"" align=""middle""> ")
			HtmlFile.WriteLine("			  <input type=""hidden"" name=""FormAction"" value=""login""> <input type=""hidden"" name=""TASK_ID"" value=""""> ")
			HtmlFile.WriteLine("			  <input type=""hidden"" name=""GANTT"" value=""""> ")
			HtmlFile.WriteLine("			  <input type=""hidden"" name=""PROJECT_ID"" value="""">  ")
			HtmlFile.WriteLine("			  <input class=""login_submit"" id=""loginBtn"" name=""loginBtn"" type=""submit"" value=""Connect"" > ")
			HtmlFile.WriteLine("		    </td> ")
			HtmlFile.WriteLine("		  </tr> ")
			HtmlFile.WriteLine("		</table> ")
			HtmlFile.WriteLine("	  </form> ")
			HtmlFile.WriteLine("	</div> ")
			HtmlFile.WriteLine("  </td> ")
			HtmlFile.WriteLine("</tr> ")
			HtmlFile.WriteLine("</table> ")
			HtmlFile.WriteLine("</body> ")
			HtmlFile.WriteLine("</html> ")
			HtmlFile.Close
			Call CreateLink(strDesktop, True)
		Else
			'Empty password or user press Cancel
			Wscript.Quit
		End If
	Else
		'Empty UserName or user press Cancel
		Wscript.Quit
	End If
End Sub
 
Sub CreateLink(Folder, Prompt)
	'Create Shortcut
	If Prompt then 
		mShort = Msgbox (" Do you want a shortcut in the Desktop ? ", 52 ,"  Create Shortcut")
	Else
		mShort = vbYes
	End If
	If mShort = vbYes then
		Set oShLink  = objShell.CreateShortcut(Folder & "\A.C.E..lnk")
		oShLink.IconLocation = "%SystemRoot%\system32\SHELL32.dll, 220"  
		oShLink.TargetPath = strLoginVbs
		oShLink.Save
	End If
End Sub 