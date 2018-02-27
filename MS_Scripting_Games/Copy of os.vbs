On Error Resume Next
strComputer = "rat"
Set objWMIService = GetObject("winmgmts:\\" & strComputer)
If Err.Number <> 0 Then
    WScript.Echo "Error: " & Err.Number
    WScript.Echo "Error (Hex): " & Hex(Err.Number)
    WScript.Echo "Source: " &  Err.Source
    WScript.Echo "Description: " &  Err.Description
    Err.Clear
End If