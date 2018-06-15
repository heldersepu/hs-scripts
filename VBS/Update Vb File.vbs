' Update the VB files - formating the varibles & adding some comments

Set fso = CreateObject("Scripting.FileSystemObject")
myFile = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	If fso.FileExists(WScript.Arguments.Item(0)) Then 
		myFile = WScript.Arguments.Item(0)
	End If
End if
'Input via Explorer
If myFile = "" Then 
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	ObjFSO.FilterIndex = 3
	ObjFSO.ShowOpen
	myFile = ObjFSO.FileName
End If

If myFile <> "" Then 
    Call UpdateFile(myFile) 
End If 

'Function MyTrim(strVar)
'  This function takes as a parameter a String 
'  and it trim some items(Arrray -> toTrim)  from the begining
Function MyTrim(strVar)
    ' Add more elements to the Array as needed  *ORDER MATTERS*
    toTrim = Array("Private Const ", "Private ", "Dim ")
    Temp = strVar
    For Each Elem In toTrim
    	myPos = InStr(strVar, Elem)
        If myPos = 1 Then 
            Temp = Right(strVar, Len(strVar) - Len(Elem)) 
            Exit For
        End If
    Next
    MyTrim = Temp
End Function

'Sub UpdateFile(dFile) 
'  This is the main procedure of this script
'  it takes the full path to a file & transform it
Sub UpdateFile(dFile) 
    Set InFile 	= fso.OpenTextFile(dFile, 1)
	Set outFile = fso.CreateTextFile(dFile & ". Up.txt", True)
    'Array with the elements that divide the line  *ORDER MATTERS*
    dPatt = Array(" As ", " = ")
    'Loop line by line 
	Do until inFile.atEndofStream
        isConst = False
		dLine   = Trim(inFile.ReadLine)

        For Each item in dPatt
    		dPos = InStr(dLine,item)
            If dPos > 0 Then
                If item = " = " then isConst = True
                Exit For
            End If
        Next

		If dPos > 0 Then
			dLeft = MyTrim( Left(dLine, dPos) )
            'If the left part is longer that 55 chars cut it at 55
			If Len(dLeft) > 55 then
				dLeft = Left(dLeft, 55)
			End if
            'Small difference bettwen constants & all oter Variables
            If isConst Then
                dLine = (dLeft & string(60-Len(dLeft)," ") & _
                     "'Constant " & Right(dLine, Len(dLine) - dPos) )
            Else
                dLine = (dLeft & string(60-Len(dLeft)," ") & _
                         "'" &  Right(dLine, Len(dLine) - dPos - 3) )
            End If
		End If
        'At this point the line is formated properly & ready to wite to new file
        outFile.WriteLine(dLine)
	Loop
	InFile.Close
	OutFile.Close
End Sub


'
'
'SAMPLE  INTUP FILE:
'
'Private m_intPreviousTag        As Integer
'Private m_blnUpdateShown        As Boolean
'Dim lockflag                    As Boolean
'Private m_blnLoading            As Boolean
'Private m_blnWorking            As Boolean
'Private m_formname              As New QHData.FormNames
'Private m_Company               As New QHData.CompanyData
''LABELS
'Private Const LBL_AGENTNAME = 63
'Private Const LBL_AGENCYADDRESS2 = 66
'Private Const LBL_AGENTPHONE = 67
'Public mcolLM As Collection
''cmj 062304
'Private fungi_prem_i As Long
'Private fungi_prem_ii As Long
'
'
'SAMPLE  OUTUP FILE:
'
'm_intPreviousTag                                            	'Integer
'm_blnUpdateShown                                            	'Boolean
'lockflag                                                    		'Boolean
'm_blnLoading                                                		'Boolean
'm_blnWorking                                                	'Boolean
'm_formname                                                  		'New QHData.FormNames
'm_Company                                                   		'New QHData.CompanyData
''LABELS
'LBL_AGENTNAME                                               	'Constant = 63
'LBL_AGENCYADDRESS2                                        'Constant = 66
'LBL_AGENTPHONE                                              	'Constant = 67
'Public mcolLM                                               		'Collection
'cmj 062304
'fungi_prem_i                                                		'Long
'fungi_prem_ii                                               		'Long
'
