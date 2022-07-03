'Create a Batch file that will remove all the DBF files not used in TX.DBF

directory = "C:\Quick95\ALLCOMP"
Set fso  = CreateObject("Scripting.FileSystemObject")
FileArray = Array("ALO4.DBF", "GGO2.DBF", "HMO3.DBF", "ILO4.DBF", "INO2.dbf", "INT3.DBF", "IVO4.DBF", "NGO2.DBF", "SUO3.DBF", "Uga2.DBF")

IF fso.FolderExists(directory) then
	dFile = dFile & ".TXT"
	Set objShell = CreateObject("WScript.Shell")
	Set outFile = fso.CreateTextFile(directory & "\found.log", True)


	Set Fldr = fso.GetFolder(directory)
	For Each File In Fldr.Files
        dbFile = Ucase(File.Name)
        If (Right(dbFile, 4) = ".PAS") then
            Set inFile = fso.OpenTextFile(File, 1)
            txtFile = InFile.ReadAll : inFile.Close
            Set inFile = Nothing

            For Each present In FileArray
                dItem = UCASE(Left(present,4))
        		If InStr(txtFile, dItem) <> 0  then
        			outFile.writeLine(" " & File & VBCrLf & present & VBCrLf)
        		End If
            Next
    	End If
	Next

	outFile.Close

	objShell.Run "notepad " & directory & "\found.log"
Else
	MsgBox "Required objects not found"
End If
