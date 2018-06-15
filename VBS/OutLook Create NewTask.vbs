Const olTaskItem = 3

Set objOutlook = CreateObject("Outlook.Application")

For I = 1 to 5
	Set objTask = objOutlook.CreateItem(olTaskItem)
	objTask.Subject = " My Script Master Plan #" & I
	'objTask.Company = "GMAC"
	'objTask.State   = "TX"
	objTask.Body    = "Body report for Script plan. #" & I
	objTask.DueDate = "10/15/07"
	objTask.Save
Next

'objOutlook.Quit
