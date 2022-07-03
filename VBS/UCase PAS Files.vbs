'\\ Rename all ".PAS" to Upper case in a given directory

directory = inputbox("Enter Directory")
Set fso  = CreateObject("Scripting.FileSystemObject")
if fso.FolderExists(directory) then
  Set Fldr = fso.GetFolder(directory)
  For Each File In Fldr.Files
	If (UCase(Right(File,4)) = ".PAS") then
		File.Move UCase(File.Path)
	end if
  next
end if
