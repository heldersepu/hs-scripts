'Self replicate to the "\temp" directory 

Set objFSO = CreateObject("Scripting.FileSystemObject")
objFSO.CopyFile wscript.ScriptName, "C:\temp\" & wscript.ScriptName, true
