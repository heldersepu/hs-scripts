'Create new Excel file fom lbArgs or
' Add info in "\QuickTX\lbArgs.txt" to Excel file (Input of Batch rater)

On Error Resume Next
Set ObjExcel = CreateObject("Excel.Application")
If Err.Number <> 0 Then
  Wscript.Echo "You must have Excel installed to perform this operation."
Else
  Set fso = CreateObject("Scripting.FileSystemObject")
  strDesktop = CreateObject("WScript.Shell").SpecialFolders("Desktop")
  myTxtFile = ""
  myXlsFile = ""
  ' Input via Arguments
  For I = 0 to WScript.Arguments.Count - 1
    If fso.FileExists(WScript.Arguments.Item(I)) Then
      Select Case UCase(Right(WScript.Arguments.Item(I),4))
        Case ".TXT"
          myTxtFile = WScript.Arguments.Item(I)
        Case ".XLS"
          myXlsFile = WScript.Arguments.Item(I)
      End Select
    End If
  Next
  'Input via Explorer
  If myTxtFile = "" Then
    Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
    ObjFSO.Filter = "Text File|*.txt"
    ObjFSO.FilterIndex = 3
    ObjFSO.ShowOpen
    myTxtFile = ObjFSO.FileName
    Set ObjFSO = Nothing
  End If
  If (myTxtFile <> "") and (myXlsFile = "") Then
    dResp = MsgBox("Whould you like to create a new Excel file?", VbYesNo, "lbArgs to Excel.")
    If dResp = vbNo then
        If myXlsFile = "" Then
          Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
          ObjFSO.Filter = "Excel File|*.xls"
          ObjFSO.FilterIndex = 3
          ObjFSO.ShowOpen
          myXlsFile = ObjFSO.FileName
          Set ObjFSO = Nothing
        End If
    End If
  End If
  'Call the Convert Procedure
  If myTxtFile <> "" Then
    If myXlsFile = "" Then myXlsFile = strDesktop & "\inputTest.xls"
    Call DoConvert(myTxtFile,myXlsFile)
    MsgBox("File Created:" & VBCrLf & myXlsFile)
  End If
  Set fso = Nothing
End If
Set ObjExcel = Nothing

'Procedure converting the txt File to Excells
Sub DoConvert(txtFile,xlsFile)
    Dim vCtm(4), vVioDate(4)
    Set inFile = fso.OpenTextFile(txtFile, 1)
    col = 1
    row = 1
    'If the Excel file does not exist Creare it
    ObjExcel.Visible = False
    If not fso.FileExists(xlsFile) Then
        'first row
        srtFirstRow = "QuoteID,NumD,NumC,Homeowner,DBirthdate_1,DSex_1,DEmployed_1,Dmiles_1,DRel_1,Duse_1,DInfo_1," & _
                "Zip_Driver_1,Drv_City1,Drv_County1,DMthTexas_1,DMthLic_1,DMVR_1,DPriorMths_1,DPriorLapse_1," & _
                "Liab_Renew_1,Phys_Renew_1,DINAgency_1,Drecord_1,DVDate1,DBirthdate_2,DSex_2,DEmployed_2,Dmiles_2," & _
                "DRel_2,Duse_2,DInfo_2,Zip_Driver_2,Drv_City2,Drv_County2,DMthTexas_2,DMthLic_2,DMVR_2," & _
                "DPriorMths_2,DPriorLapse_2,Liab_Renew_2,Phys_Renew_2,DINAgency_2,Drecord_2,DVDate2,DBirthdate_3," & _
                "DSex_3,DEmployed_3,Dmiles_3,DRel_3,Duse_3,DInfo_3,Zip_Driver_3,Drv_City3,Drv_County3,DMthTexas_3," & _
                "DMthLic_3,DMVR_3,DPriorMths_3,DPriorLapse_3,Liab_Renew_3,Phys_Renew_3,DINAgency_3,Drecord_3," & _
                "DVDate3,DBirthdate_4,DSex_4,DEmployed_4,Dmiles_4,DRel_4,Duse_4,DInfo_4,Zip_Driver_4,Drv_City4," & _
                "Drv_County4,DMthTexas_4,DMthLic_4,DMVR_4,DPriorMths_4,DPriorLapse_4,Liab_Renew_4,Phys_Renew_4," & _
                "DINAgency_4,Drecord_4,DVDate4,VBI_Lim,VPD_Lim,VPIP_Lim,VMed_Lim,VUM_Lim,VUMPD_lim,Vin_Number1," & _
                "VOptions_1,AlarmAttributes1,VCustom_1,Vcustom_Type1,Vcoll_Lim_1,Vcomp_Lim_1,VRent_Lim_1," & _
                "VTOW_Lim_1,VMSRP_1,VACV_1,Vin_Number2,VOptions_2,AlarmAttributes2,VCustom_2,Vcustom_Type2," & _
                "Vcoll_Lim_2,Vcomp_Lim_2,VRent_Lim_2,VTOW_Lim_2,VMSRP_2,VACV_2,Vin_Number3,VOptions_3," & _
                "AlarmAttributes3,VCustom_3,Vcustom_Type3,Vcoll_Lim_3,Vcomp_Lim_3,VRent_Lim_3,VTOW_Lim_3,VMSRP_3," & _
                "VACV_3,Vin_Number4,VOptions_4,AlarmAttributes4,VCustom_4,Vcustom_Type4,Vcoll_Lim_4,Vcomp_Lim_4," & _
                "VRent_Lim_4,VTOW_Lim_4,VMSRP_4,VACV_4,_BILIMIT25,_CREDITCARD,_CREDITSCR2,_MTHSRENCHA,_BADCREDIT," & _
                "_BANKRUPT,LiabCredit_1,PaidInFull,PolPer,_LowDown,_AIGDIRBILL,_EFTPLAN,_EMAIL"
        dHead = Split(UCase(srtFirstRow), ",")
        'Add all the items to the first row
        objexcel.Workbooks.add
        For each item in Split(srtFirstRow, ",")
            'Wscript.Echo col & " - " & item
            ObjExcel.Cells(1,col).Value = item
            col = col + 1
        Next
        row = 2
        ObjExcel.Cells(row,1).Value = "Quote" & Row-1

        objexcel.ActiveWorkbook.SaveAs(xlsFile)
        'Set objWorkbook  = ObjExcel.Workbooks.Open(xlsFile)
    else
        'Open Excel file & Workbooks
        Set objWorkbook  = ObjExcel.Workbooks.Open(xlsFile)
        'Get the last Row
        Do Until ObjExcel.Cells(row,1).Value = ""
          row = row + 1
        Loop
        ObjExcel.Cells(row,1).Value = "Quote" & Row-1
        'Get all the info in Row 1
        Do Until ObjExcel.Cells(1,col).Value = ""
          Redim Preserve dHead(col)
          dHead(col-1) = Ucase(ObjExcel.Cells(1,col).Value)
          col = col + 1
        Loop
    End If

    'Loop file & copy info to Excel
    Do until inFile.AtEndOfStream
      dLine = inFile.ReadLine
      'Get info from line, Separator is the =
      EqualPos = InStr(dLine,"=")
      dIni = Ucase(Mid(dLine, 1, EqualPos-1))
      dEnd = Mid(dLine, EqualPos+1, Len(dLine) - EqualPos + 1)
      'Handle Special Cases
      If Left(dIni,6) = "DVDATE" Then
        vVioDate(CInt(Right(dIni,1))) = vVioDate(CInt(Right(dIni,1))) & ValidStrDate(dEnd) & ";"
      End If

      If Left(dIni,5) = "VCTM_" Then
        If CInt(dEnd) > 0 then
          Select Case Left(dIni,7)
            Case "VCTM_ST"
              vCtm(CInt(Right(dIni,1))) = vCtm(CInt(Right(dIni,1))) & "S=" & dEnd & ";"
            Case "VCTM_CO"
              vCtm(CInt(Right(dIni,1))) = vCtm(CInt(Right(dIni,1))) & "C=" & dEnd & ";"
            Case "VCTM_EX"
              vCtm(CInt(Right(dIni,1))) = vCtm(CInt(Right(dIni,1))) & "E=" & dEnd & ";"
            Case "VCTM_IN"
              vCtm(CInt(Right(dIni,1))) = vCtm(CInt(Right(dIni,1))) & "I=" & dEnd & ";"
            Case "VCTM_PA"
              vCtm(CInt(Right(dIni,1))) = vCtm(CInt(Right(dIni,1))) & "P=" & dEnd & ";"
            Case "VCTM_PR"
              vCtm(CInt(Right(dIni,1))) = vCtm(CInt(Right(dIni,1))) & "F=" & dEnd & ";"
            Case "VCTM_TO"
              vCtm(CInt(Right(dIni,1))) = vCtm(CInt(Right(dIni,1))) & "T=" & dEnd & ";"
          End Select
        End If
      else
        Select Case Left(dIni,7)
          Case "DPRIORL" 'Add and "A"
            dIni = Left(dIni,7) & "A" & Mid(dIni,8,Len(dIni))
          Case "VIN_NUM" 'Remove the "_1"
            dIni = Left(dIni,10) & Right(dIni,1)
          Case "VBI_LIM" 'Remove the "_1"
            dIni = Left(dIni,7)
          Case "VPD_LIM" 'Remove the "_1"
            dIni = Left(dIni,7)
          Case "VPIP_LI" 'Remove the "_1"
            dIni = Left(dIni,8)
          Case "VUM_LIM" 'Remove the "_1"
            dIni = Left(dIni,7)
          Case "VUMPD_L" 'Remove the "_1"
            dIni = Left(dIni,9)
          Case "VMED_LI" 'Remove the "_1"
            dIni = Left(dIni,8)
          Case "VFAKEOP" 'Remove the "_1"
            dIni = "VOPTIONS_" & right(dIni,1)
          Case "VOPTION" 'Remove the "_1"
            dIni = ""
        End Select
        If InStr(dEnd, " ") then
          dEnd = chr(34) & dEnd & chr(34)
        End If
        'Check if it exists in the headers
        For I = 0 to UBound(dHead)
          If dIni = dHead(I) Then
            ObjExcel.Cells(row,I+1).Value = dEnd
            Exit For
          End If
        Next
      End If
    Loop
    inFile.Close
    Set inFile = Nothing

    'Check if Custom_Type exists in the headers
    For J = 1 to 4
      dLabel1 = "VCUSTOM_TYPE" & J
      dLabel2 = "DVDATE" & J
      For I = 1 to col - 1
        if I <= Ubound(dHead) then
            If dLabel1 = dHead(I) Then
              ObjExcel.Cells(row,I).Value = vCtm(J)
            End If
            If dLabel2 = dHead(I) Then
              ObjExcel.Cells(row,I).Value = vVioDate(J)
            End If
        End If
      Next
    Next
    'AutoFit all columns
    With ObjExcel
      .Cells.Select
      .Cells.EntireColumn.AutoFit
      .Range("A1").Select
      'Save Excel File & Close Excel Object
      '.ActiveWorkbook.SaveAs(txtFile & ".xls")
      .ActiveWorkbook.Save
      .Workbooks(1).Close
      .Quit
    End With
    Set objWorkbook  = Nothing
End Sub

Function ValidStrDate(sStr)
    sMM = Left(sStr, (InStr(sStr, "/") - 1))
    sMM = String((2 - Len(sMM)), "0") & sMM
    sStr = Mid(sStr, (InStr(sStr, "/") + 1), (Len(sStr) - InStr(sStr, "/")))
    sDD = Left(sStr, (InStr(sStr, "/") - 1))
    sDD = String((2 - Len(sDD)), "0") & sDD
    sStr = Mid(sStr, (InStr(sStr, "/") + 1), (Len(sStr) - InStr(sStr, "/")))
    sYY = String((4 - Len(sStr)), "0") & sStr
    ValidStrDate = sMM & "/" & sDD & "/" & sYY
End Function
