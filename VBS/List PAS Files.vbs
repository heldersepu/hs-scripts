' Open Notepad and paste all .pas files in given folder

On Error Resume Next
Dim objShell, success, i, t
cnt = 0

Set objShell = CreateObject("WScript.Shell")

directory = inputbox("Enter Directory")

' -- Open Notepad & wait until is active
objShell.Run "notepad"
Do Until Success = True
    Success = objShell.AppActivate("Notepad")
    Wscript.Sleep 100
Loop

Set fso  = CreateObject("Scripting.FileSystemObject")
Set Fldr = fso.GetFolder(directory)

' -- Get all files in the folder and put them on array
For Each File In Fldr.Files
   cnt = cnt + 1
   Redim Preserve arFiles(cnt)
   arFiles(cnt) = File
next

objShell.SendKeys directory
objShell.SendKeys "{ENTER}"
objShell.SendKeys now
objShell.SendKeys "{ENTER}"

' -- Output the array
For i = 1 to cnt
   Set f = fso.GetFile(arFiles(i))
   If ((UCase(fso.GetExtensionName(f)) = "PAS") and (f.attributes = 32)) then
       If (now - f.DateLastModified < 5) then
          objShell.SendKeys arFiles(i)
          objShell.SendKeys "{ENTER}"
       End If
     '  f.attributes = f.attributes - 32
   End If
Next
