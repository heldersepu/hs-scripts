'Get the info from a tex file & display it in Excel

Set objExcel = CreateObject("Excel.Application")
objExcel.Visible = True
objExcel.Workbooks.Add

Set fso  	= CreateObject("Scripting.FileSystemObject")
Set inFile 	= fso.OpenTextFile("c:\case.ini", 1)

i = 0
Do until (inFile.AtEndOfStream)
	ThisLine = inFile.ReadLine
	i = i +1
    objExcel.Cells(i, 3).Value = ThisLine
Loop
