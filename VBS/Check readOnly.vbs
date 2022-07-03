'// Check a Directory for read only files
'//
'// CASE [+] [-] [!] source
'//
'//   +   Sets Read-only file attribute.
'//   -   Clears Read-only file attribute.
'//   !   Information about Current directory
'//   source	Specifies the directory to be inspected


Set objShell    = CreateObject("WScript.Shell")
Set fso  	= CreateObject("Scripting.FileSystemObject")
iNum = WScript.Arguments.Count
If iNum >= 2 Then
	if fso.FolderExists(WScript.Arguments.Item(1)) then
		checkFolder WScript.Arguments.Item(0), WScript.Arguments.Item(1)
	else
		checkFolder WScript.Arguments.Item(0), "."
	end if
else
	objShell.Run "notepad readOnly.vbs"
end if


Sub checkFolder(Param, directory)
	Set Fldr = fso.GetFolder(directory)
	if Param = "!" then
		Set outFile 	= fso.CreateTextFile(directory & "\Attrib.ini", True)
		For Each File In Fldr.Files
			outFile.WriteLine(File.attributes & "	" & File)
		next

		outFile.WriteLine(" ")
		outFile.WriteLine("  Value		Description                                               ")
		outFile.WriteLine("     0		Normal file. No attributes are set.                           ")
		outFile.WriteLine("     1		Read-only file. Attribute is read/write.                      ")
		outFile.WriteLine("     2		Hidden file. Attribute is read/write.                         ")
		outFile.WriteLine("     4		System file. Attribute is read/write.                         ")
        outFile.WriteLine("    16		Folder or directory. Attribute is read-only.                  ")
        outFile.WriteLine("    32		File has changed since last backup. Attribute is read/write.  ")
        outFile.WriteLine("    64		Link or shortcut. Attribute is read-only.                     ")
        outFile.WriteLine("   128		Compressed file. Attribute is read-only.                      ")
		outFile.Close
		objShell.Run "notepad.exe " & directory & "\Attrib.ini"

	   else
		For Each File In Fldr.Files
			if Param = "+" then
				if (File.attributes Mod 2 = 0) and (fso.GetFileName(File)<>"Attrib.ini") then File.attributes = File.attributes + 1
			else
				if Param = "-" then
					if File.attributes Mod 2 <> 0 then File.attributes = File.attributes - 1
				end if
			end if
		next
	   end if

End Sub












