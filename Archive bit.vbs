' Check to see if a file has the Archive bit set(represents one of two states: "changed" and "not changed")

Set fs = CreateObject("Scripting.FileSystemObject")
Set f = fs.GetFile("C:\WINDOWS\system32\cdm.dll")

MsgBox f.attributes

If f.attributes = 32 Then
  r = MsgBox("The Archive bit is set, do you want to clear it?", vbYesNo, "Set/Clear Archive Bit")
  If r = vbNo Then
      f.attributes = f.attributes - 32
      MsgBox "Archive bit is cleared."
  Else
      MsgBox "Archive bit remains set."
  End If  
End if