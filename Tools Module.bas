Attribute VB_Name = "Module1"
' Function used to read info from LBanswer File
' Takes 2 parameters
'    strFile - Path to the LBanswer file
'    strSepa - Separator of the Info
'
''
Function GetInfo(strFile, strSepa)
    'Default States
    Select Case UCase(strFile)
        Case "FL"
            strFile = "C:\QuickFL\LBanswer.txt"
        Case "GA"
            strFile = "C:\QuickGA\LBanswer.txt"
        Case "TX"
            strFile = "C:\QuickTX\LBanswer.txt"
    End Select
    
    Set fso = CreateObject("Scripting.FileSystemObject")
    'Check if the file exists
    If fso.FileExists(strFile) Then
        'End of Line {Carriage Return & Line Feed}
        strEndL = Chr(13) & Chr(10)
        'Open the File as a text file & read contents
        Set inFile = fso.OpenTextFile(strFile, 1)
        strInfo = inFile.ReadAll
        inFile.Close
        'Look for the separator & get the Info
        intPos = InStr(strInfo, strSepa)
        If intPos > 0 Then
            strInfo = Mid(strInfo, intPos + Len(strSepa), 50)
            intPos = InStr(strInfo, strEndL)
    
            If intPos > 0 Then
                GetInfo = Left(strInfo, intPos - 1)
            Else
                GetInfo = strInfo
            End If
        Else
            ' Separator not found in file
            ' GetInfo = dSepa & " not found in " & LBans
            GetInfo = ""
        End If
    Else
        GetInfo = "File not Found"
    End If
    
    Set fso = Nothing
End Function

Sub MyPrint()
Attribute MyPrint.VB_ProcData.VB_Invoke_Func = "p\n14"
    'MsgBox Cells(5, 7).Value
    ActiveWindow.SelectedSheets.PrintOut From:=1, To:=Cells(5, 7).Value, Copies:=1, Collate:=True
End Sub

Sub SelectCells()
Attribute SelectCells.VB_Description = "Macro recorded 12/29/2006 by Martin Toro"
Attribute SelectCells.VB_ProcData.VB_Invoke_Func = "l\n14"
' Macro recorded 12/29/2006 by Martin Toro
' Keyboard Shortcut: Ctrl+l

    ActiveSheet.Unprotect
    Range("C27,E27,G27,I27,K27,M27,O27,P28,P29,P30,C54,E54,G54,I54,K54,M54,O54,P55,P56,P57,C81,E81,G81,I81,K81,M81,O81,P82,P83,P84,C108,E108,G108,I108,K108,M108,O108,P109,P110,P111").Select

End Sub

Sub UpdateFLCells()

    ActiveSheet.Unprotect
    'Range("C27,E27,G27,I27,K27,M27,O27,P28,P29,P30,C54,E54,G54,I54,K54,M54,O54,P55,P56,P57,C81,E81,G81,I81,K81,M81,O81,P82,P83,P84,C108,E108,G108,I108,K108,M108,O108,P109,P110,P111").Select
    
    Cells(27, 3).Value = GetInfo("FL", "Bi1=")      'C27
    Cells(27, 5).Value = GetInfo("FL", "Pd1=")      'E27
    Cells(27, 7).Value = GetInfo("FL", "Pip1=")     'G27
    Cells(27, 9).Value = GetInfo("FL", "Med1=")     'I27
    Cells(27, 11).Value = GetInfo("FL", "Um1=")     'K27
    Cells(27, 13).Value = GetInfo("FL", "Comp1=")   'M27
    Cells(27, 15).Value = GetInfo("FL", "Coll1=")   'O27
    Cells(28, 16).Value = GetInfo("FL", "Rent1=")   'P28
    Cells(29, 16).Value = GetInfo("FL", "Tow1=")    'P29
    Cells(30, 16).Value = GetInfo("FL", "Tow1=")    'P30
    
    Cells(54, 3).Value = GetInfo("FL", "Bi2=")      'C54
    Cells(54, 5).Value = GetInfo("FL", "Pd2=")      'E54
    Cells(54, 7).Value = GetInfo("FL", "Pip2=")     'G54
    Cells(54, 9).Value = GetInfo("FL", "Med2=")     'I54
    Cells(54, 11).Value = GetInfo("FL", "Um2=")     'K54
    Cells(54, 13).Value = GetInfo("FL", "Comp2=")   'M54
    Cells(54, 15).Value = GetInfo("FL", "Coll2=")   'O54
    Cells(55, 16).Value = GetInfo("FL", "Rent2=")   'P55
    Cells(56, 16).Value = GetInfo("FL", "Tow2=")    'P56
    Cells(57, 16).Value = GetInfo("FL", "Tow2=")    'P57
    
    Cells(81, 3).Value = GetInfo("FL", "Bi3=")      'C81
    Cells(81, 5).Value = GetInfo("FL", "Pd3=")      'E81
    Cells(81, 7).Value = GetInfo("FL", "Pip3=")     'G81
    Cells(81, 9).Value = GetInfo("FL", "Med=")      'I81
    Cells(81, 11).Value = GetInfo("FL", "Um3=")     'K81
    Cells(81, 13).Value = GetInfo("FL", "Comp3=")   'M81
    Cells(81, 15).Value = GetInfo("FL", "Coll3=")   'O81
    Cells(82, 16).Value = GetInfo("FL", "Rent3=")   'P82
    Cells(83, 16).Value = GetInfo("FL", "Tow3=")    'P83
    Cells(84, 16).Value = GetInfo("FL", "Tow3=")    'P84
    
    Cells(108, 3).Value = GetInfo("FL", "Bi4=")     'C108
    Cells(108, 5).Value = GetInfo("FL", "Pd4=")     'E108
    Cells(108, 7).Value = GetInfo("FL", "Pip4=")    'G108
    Cells(108, 9).Value = GetInfo("FL", "Med4=")    'I108
    Cells(108, 11).Value = GetInfo("FL", "Um4=")    'K108
    Cells(108, 13).Value = GetInfo("FL", "Comp4=")  'M108
    Cells(108, 15).Value = GetInfo("FL", "Coll4=")  'O108
    Cells(109, 16).Value = GetInfo("FL", "Rent4=")  'P109
    Cells(110, 16).Value = GetInfo("FL", "Tow4=")   'P110
    Cells(111, 16).Value = GetInfo("FL", "Tow4=")   'P111
    
    'ActiveSheet.Protect

End Sub

Sub UpdateTXCells()
Attribute UpdateTXCells.VB_ProcData.VB_Invoke_Func = "t\n14"

    ActiveSheet.Unprotect
    'Range("C27,E27,G27,I27,K27,M27,O27,P28,P29,P30,C54,E54,G54,I54,K54,M54,O54,P55,P56,P57,C81,E81,G81,I81,K81,M81,O81,P82,P83,P84,C108,E108,G108,I108,K108,M108,O108,P109,P110,P111").Select
    
    'Array with actual Driver info Row
    Dim Drv_Pos(3)
        Drv_Pos(0) = 8
        Drv_Pos(1) = 36
        Drv_Pos(2) = 64
        Drv_Pos(3) = 92
    Dim DAGE_1, Marital, ZipCode
    DAGE_1 = 8
    Marital = 7
    ZipCode = 3
    
        
    'Sorting Info
    Drv_1 = Drv_Pos(GetInfo("TX", "SORTED_POS_1=") - 1)
    Drv_2 = Drv_Pos(GetInfo("TX", "SORTED_POS_2=") - 1)
    Drv_3 = Drv_Pos(GetInfo("TX", "SORTED_POS_3=") - 1)
    Drv_4 = Drv_Pos(GetInfo("TX", "SORTED_POS_4=") - 1)
    
    NumCars = GetInfo("TX", "NUMC=")
    Cells(5, 7).Value = NumCars                             '# Veh
    
    Cells(Drv_1, DAGE_1).Value = GetInfo("TX", "DAGE_1=")            'DAGE_1
    Cells(Drv_1, Marital).Value = GetInfo("TX", "DSEX_1=")            'Marital
    Cells(Drv_1, ZipCode).Value = GetInfo("TX", "ClientZip=")         'ZipCode
    If NumCars >= 2 Then
        Cells(Drv_2, DAGE_1).Value = GetInfo("TX", "DAGE_2=")            'DAGE_1
        Cells(Drv_2, Marital).Value = GetInfo("TX", "DSEX_2=")            'Marital
        Cells(Drv_2, ZipCode).Value = GetInfo("TX", "ClientZip=")         'ZipCode
    Else
        Cells(Drv_2, ZipCode).Value = ""
    End If
    If NumCars >= 3 Then
        Cells(Drv_3, DAGE_1).Value = GetInfo("TX", "DAGE_3=")            'DAGE_1
        Cells(Drv_3, Marital).Value = GetInfo("TX", "DSEX_3=")            'Marital
        Cells(Drv_3, ZipCode).Value = GetInfo("TX", "ClientZip=")         'ZipCode
    Else
        Cells(Drv_3, ZipCode).Value = ""
    End If
    If NumCars >= 4 Then
        Cells(Drv_4, DAGE_1).Value = GetInfo("TX", "DAGE_4=")            'DAGE_1
        Cells(Drv_4, Marital).Value = GetInfo("TX", "DSEX_4=")            'Marital
        Cells(Drv_4, ZipCode).Value = GetInfo("TX", "ClientZip=")         'ZipCode
    Else
        Cells(Drv_4, ZipCode).Value = ""
    End If
    
    Cells(Drv_Pos(0), 12).Value = GetInfo("TX", "Vyear_1=")           'Veh Year
    Cells(Drv_Pos(1), 12).Value = GetInfo("TX", "Vyear_2=")         'Veh Year
    Cells(Drv_Pos(2), 12).Value = GetInfo("TX", "Vyear_3=")         'Veh Year
    Cells(Drv_Pos(3), 12).Value = GetInfo("TX", "Vyear_4=")         'Veh Year
           
    Cells(Drv_Pos(0), 13).Value = GetInfo("TX", "ISO_SYM_1=")         'Symbol
    Cells(Drv_Pos(1), 13).Value = GetInfo("TX", "ISO_SYM_2=")       'Symbol
    Cells(Drv_Pos(2), 13).Value = GetInfo("TX", "ISO_SYM_3=")       'Symbol
    Cells(Drv_Pos(3), 13).Value = GetInfo("TX", "ISO_SYM_4=")       'Symbol
          
    Cells(15, 13).Value = GetInfo("TX", "VCOLL_LIM_1=")     'COLL Limit
    Cells(43, 13).Value = GetInfo("TX", "VCOLL_LIM_2=")     'COLL Limit
    Cells(71, 13).Value = GetInfo("TX", "VCOLL_LIM_3=")     'COLL Limit
    Cells(99, 13).Value = GetInfo("TX", "VCOLL_LIM_4=")     'COLL Limit
             
    Cells(15, 15).Value = GetInfo("TX", "VCOMP_LIM_1=")     'COMP_Limit
    Cells(43, 15).Value = GetInfo("TX", "VCOMP_LIM_2=")     'COMP_Limit
    Cells(71, 15).Value = GetInfo("TX", "VCOMP_LIM_3=")     'COMP_Limit
    Cells(99, 15).Value = GetInfo("TX", "VCOMP_LIM_4=")     'COMP_Limit

    Cells(28, 4).Value = GetInfo("TX", "BI_PRICE_1=")        'C27
    Cells(28, 6).Value = GetInfo("TX", "PD_PRICE_1=")        'E27
    Cells(28, 8).Value = GetInfo("TX", "MED_PRICE_1=")       'G27
    Cells(28, 10).Value = GetInfo("TX", "UM_PRICE_1=")        'I27
    Cells(28, 12).Value = GetInfo("TX", "UMPD_PRICE_1=")    'K27
    Cells(28, 14).Value = GetInfo("TX", "COMP_PRICE_1=")    'M27
    Cells(28, 16).Value = GetInfo("TX", "COLL_PRICE_1=")    'O27
    Cells(29, 17).Value = GetInfo("TX", "TOWINGPRIC_1=")    'P28
    Cells(30, 17).Value = GetInfo("TX", "RENTALPRIC_1=")    'P29
    Cells(31, 17).Value = GetInfo("TX", "CUSTOMPRIC_1=")    'P30

    Cells(56, 4).Value = GetInfo("TX", "BI_PRICE_2=")        'C54
    Cells(56, 6).Value = GetInfo("TX", "PD_PRICE_2=")        'E54
    Cells(56, 8).Value = GetInfo("TX", "MED_PRICE_2=")        'G54
    Cells(56, 10).Value = GetInfo("TX", "UM_PRICE_2=")       'I54
    Cells(56, 12).Value = GetInfo("TX", "UMPD_PRICE_2=")    'K54
    Cells(56, 14).Value = GetInfo("TX", "COMP_PRICE_2=")    'M54
    Cells(56, 16).Value = GetInfo("TX", "COLL_PRICE_2=")    'O54
    Cells(57, 17).Value = GetInfo("TX", "TOWINGPRIC_2=")    'P55
    Cells(57, 17).Value = GetInfo("TX", "RENTALPRIC_2=")    'P56
    Cells(59, 17).Value = GetInfo("TX", "CUSTOMPRIC_2=")    'P57
             
    Cells(84, 4).Value = GetInfo("TX", "BI_PRICE_3=")        'C81
    Cells(84, 6).Value = GetInfo("TX", "PD_PRICE_3=")        'E81
    Cells(84, 8).Value = GetInfo("TX", "MED_PRICE_3=")       'G81
    Cells(84, 10).Value = GetInfo("TX", "UM_PRICE_3=")       'I81
    Cells(84, 12).Value = GetInfo("TX", "UMPD_PRICE_3=")    'K81
    Cells(84, 14).Value = GetInfo("TX", "COMP_PRICE_3=")    'M81
    Cells(84, 16).Value = GetInfo("TX", "COLL_PRICE_3=")    'O81
    Cells(85, 17).Value = GetInfo("TX", "TOWINGPRIC_3=")    'P82
    Cells(86, 17).Value = GetInfo("TX", "RENTALPRIC_3=")    'P83
    Cells(87, 17).Value = GetInfo("TX", "CUSTOMPRIC_3=")    'P84
             
    Cells(112, 4).Value = GetInfo("TX", "BI_PRICE_4=")       'C108
    Cells(112, 6).Value = GetInfo("TX", "PD_PRICE_4=")       'E108
    Cells(112, 8).Value = GetInfo("TX", "MED_PRICE_4=")      'G108
    Cells(112, 10).Value = GetInfo("TX", "UM_PRICE_4=")      'I108
    Cells(112, 12).Value = GetInfo("TX", "UMPD_PRICE_4=")   'K108
    Cells(112, 14).Value = GetInfo("TX", "COMP_PRICE_4=")   'M108
    Cells(112, 16).Value = GetInfo("TX", "COLL_PRICE_4=")   'O108
    Cells(113, 17).Value = GetInfo("TX", "TOWINGPRIC_4=")   'P109
    Cells(114, 17).Value = GetInfo("TX", "RENTALPRIC_4=")   'P110
    Cells(115, 17).Value = GetInfo("TX", "CUSTOMPRIC_4=")   'P111
              

    'Update the City & County
    Cells(8, 4).Value = Sheets("zip codes").Range("B2").Value
    'MsgBox Sheets("zip codes").Range("B2").Value & " - " & Sheets("zip codes").Range("C2").Value
    Cells(8, 5).Value = Sheets("zip codes").Range("C2").Value
    
    'ActiveSheet.Protect

End Sub

Sub DelCredit()
    
    'Loop through all Worksheets
    For I = 1 To Worksheets.Count
        'If the last word in the name is Credit
        intPos = InStr(UCase(Worksheets(I).Name), " - CR")
        If intPos > 0 Then
            'Remove " - Credit" from the name
            Worksheets(I).Name = Left(Worksheets(I).Name, intPos)
        End If
    Next
    
End Sub

Sub DelParentesis()
    
    'Loop through all Worksheets
    For I = 1 To Worksheets.Count
        'If the first letter is "("
        If (Left(Worksheets(I).Name, 1)) = "(" Then
            intPos = InStr(2, Worksheets(I).Name, ")")
            If intPos > 0 Then
                'Remove "(1.1)" from the name
                Worksheets(I).Name = Mid(Worksheets(I).Name, intPos + 1, Len(Worksheets(I).Name))
            End If
        End If
    Next
    
End Sub

Sub TrimWorksheets()
    
    'Loop through all Worksheets
    For I = 1 To Worksheets.Count
        'Trim the Name
        Worksheets(I).Name = Trim(Worksheets(I).Name)
    Next
    
End Sub

Sub SetNormalView()
    
    'Loop through all Worksheets
    For I = 1 To Worksheets.Count
        Sheets(Worksheets(I).Name).Select
        ActiveWindow.View = xlNormalView
    Next
    
End Sub

Sub AddName()

    'Add the name the of the file to the G column
    Range("G1").FormulaR1C1 = "YEAR"
    'Need last
    dRow = 1
    Do Until Cells(dRow, 4).Value = ""
      dRow = dRow + 1
    Loop
    dRow = dRow - 1
    
    Range("G2:G" & dRow).Select
    Range("G" & dRow).Activate
    'Need Name of File
    Selection.FormulaR1C1 = Mid(ActiveWorkbook.Name, 5, 2)
    ActiveWorkbook.Save

End Sub

Sub CreateLinks()
'
    Set fso = CreateObject("Scripting.FileSystemObject")
    I = 1
    'Loop through all Abbreviations
    Do
        I = I + 1
        Range("b" & I).Select
        dComp = ActiveCell.Value
        dFile = "C:\Quick95\allcomp\" & dComp & ".PAS"
        'Check the file and Create the link if it exists
        If fso.FileExists(dFile) Then
            ActiveSheet.Hyperlinks.Add Anchor:=Selection, Address:=dFile, TextToDisplay:=dComp
        Else
            If dComp <> "" Then
                Range("F" & I).Select
                ActiveCell.Value = "File not found."
            End If
        End If
    Loop While (dComp <> "")
    
    I = 1
    'Loop through all Abbreviations
    Do
        I = I + 1
        Range("B" & I).Select
        dComp = ActiveCell.Value
        dFile = "C:\Quick95\allcomp\" & dComp
        'Check the file and Create the link if it exists
        If fso.FileExists(dFile) Then
            ActiveSheet.Hyperlinks.Add Anchor:=Selection, Address:=dFile, TextToDisplay:=dComp
        Else
            If dComp <> "" Then
                Range("F" & I).Select
                ActiveCell.Value = "File not found."
            End If
        End If
    Loop While (dComp <> "")
    Range("B2").Select
    
End Sub


Sub OpenAll()
'
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set objShell = CreateObject("WScript.Shell")
    I = 1
    'Loop through all Abbreviations
    Do
        I = I + 1
        Range("B" & I).Select
        dComp = ActiveCell.Value
        dFile = "C:\Quick95\allcomp\" & dComp
        'Check the file and Open it if exists
        If fso.FileExists(dFile) Then
            Range("B" & I).Select
            If ActiveCell.Value <> "" Then
                objShell.Run dFile
            End If
        End If
    Loop While (dComp <> "")
    
    I = 1
    'Loop through all Abbreviations
    Do
        I = I + 1
        Range("C" & I).Select
        dComp = ActiveCell.Value
        dFile = "C:\Quick95\allcomp\" & dComp
        'Check the file and Open it if exists
        If fso.FileExists(dFile) Then
            Range("C" & I).Select
            If ActiveCell.Value <> "" Then
                objShell.Run dFile
            End If
        End If
    Loop While (dComp <> "")
    Range("B2").Select
    
End Sub


Sub concat()
    myCols = Array("C", "D", "E", "F", "G")
    I = 1
    J = 0
    strTemp = ""
    Do
        I = I + 1
        dVIO = Range("A" & I).Value
        If Trim(dVIO) <> "" Then
            J = J + 1
            strTemp = strTemp & "V" & dVIO
            If getVio(myCols, I) = getVio(myCols, I + 1) Then
                If Trim(Range("A" & I + 1).Value) <> "" Then
                    strTemp = strTemp & ", "
                End If
                If (J Mod 5) = 0 Then
                    strTemp = strTemp & vbCrLf
                End If
            Else
                Range("I" & I).Value = strTemp
                J = 0
                strTemp = ""
            End If
        End If
    Loop While (dVIO <> "")
    'MsgBox strTemp
    
End Sub

'Get the first non empty string from an array
Function getVio(arrCol, intRow)
    For Each Col In arrCol
        strTMP = Trim(Range(Col & intRow).Value)
        If strTMP <> "" Then
            getVio = strTMP
            Exit For
        End If
    Next
End Function

'Apply a color to the given row
Sub applyColor(num)
    With Range("A" & CStr(num) & ":L" & CStr(num)).Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .ThemeColor = xlThemeColorAccent1
        .TintAndShade = 0.799981688894314
        .PatternTintAndShade = 0
    End With
End Sub

'Apply alternate colors to rows that have different colors
Sub AlternateColors()
    num = 4
    doColor = True
    Do
        If LCase(Range("C" & CStr(num)).Text) = LCase(Range("C" & CStr(num + 1)).Text) Then
            If doColor Then
                Call applyColor(num)
                Call applyColor(num + 1)
            End If
        Else
            doColor = Not doColor
        End If
        num = num + 1
    Loop Until (Range("A" & CStr(num)).Text = "")
End Sub

