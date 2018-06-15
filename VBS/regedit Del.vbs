Const HKEY_LOCAL_MACHINE = &H80000002

Set objReg = GetObject("winmgmts:\\.\root\default:StdRegProv")
 
strKeyPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
Call objReg.EnumValues(HKEY_LOCAL_MACHINE, strKeyPath,arrStrNames)

For Each Item in arrStrNames
    If Item <> "OfficeScanNT Monitor" then
        If (MsgBox("Value Found:" & VbCrLf & Item & VbCrLf & " Remove it?" _
                    , vbYesNo, " Delete Confirmation") = VbYes) then
            Call objReg.DeleteValue(HKEY_LOCAL_MACHINE,strKeyPath,Item)
        End If
    End IF
Next

