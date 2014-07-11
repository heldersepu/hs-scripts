
Const olFolderTasks = 13

Set objOutlook = CreateObject("Outlook.Application")
Set objNamespace = objOutlook.GetNamespace("MAPI")
Set objFolder = objNamespace.GetDefaultFolder(olFolderTasks)


For Each Task In objFolder.Items
	Wscript.echo Task.Subject
	'Wscript.echo Task.Body
	Wscript.echo Task.DueDate
Next          


'objOutlook.Quit
