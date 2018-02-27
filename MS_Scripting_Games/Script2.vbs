const HKEY_LOCAL_MACHINE = &H80000002
 
Set oReg=GetObject("winmgmts:\\.\root\default:StdRegProv")
 'string with the path of the reg
strKeyPath = "Software\Microsoft\Windows NT\CurrentVersion\Fonts"
oReg.EnumValues HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys

TrueType = 0
Total = 0
'loop trough all  subkeys
For Each subkey In arrSubKeys
    'check  if the name contains trueType and count them
    if instr(subkey, "TrueType") <> 0 then
      WScript.Echo subkey
      TrueType = TrueType +1 
    End if
   Total = Total +1
Next
Wscript.Echo "TrueType: "  & TrueType
Wscript.Echo "Total:    "   & Total
