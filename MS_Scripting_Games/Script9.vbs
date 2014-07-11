'Correction!  Multiply by 1000 both 
myFile = "C:\Scripts\Pool.mdb"
myTable = "SwimmingPool"
'Call the Calculate Procedure
If myFile <> "" Then
    Call doCalculate(myFile,myTable)
End If     

Sub doCalculate(dFile, dTable)
    'Create an ADO object
    Set objADO = CreateObject( "ADODB.Connection" )
    'Connection String
    strConnect = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= " _
                 & dFile & ";" 
    'SQL query to execute
    mySQL = "SELECT * FROM " & dTable
    'Open the Connection
    objADO.Open strConnect
    'Execute the  query
    Set objResults = objADO.Execute( mySQL )
    'Loop until the End Of File
    Do Until objResults.EOF
        'Display the results
        dCustomer  = objResults.Fields( 1 ).Value
        dLength    = objResults.Fields( 2 ).Value
        dWidth     = objResults.Fields( 3 ).Value
        dDepth     = objResults.Fields( 4 ).Value
        hasSlope   = objResults.Fields( 5 ).Value
        dSStart    = objResults.Fields( 6 ).Value
        dSEnd      = objResults.Fields( 7 ).Value
        If hasSlope then
            'Slope: Length x Width x ((Deep End Depth + Shallow End Depth) / 2)
            WScript.Echo "Name: " & dCustomer & VbCrLf & _
                "    Volume of Water: " & _
                dLength * dWidth * ((dSEnd + dSStart) / 2)*1000 & VbCrLf
        else
            'Correction!  Multiply by 1000
            'Uniform depth: Length x Width x Depth
            WScript.Echo "Name: " & dCustomer & VbCrLf & _
                "    Volume of Water: " & _ 
                dLength * dWidth * dDepth *1000 & VbCrLf
        End IF
        'Move to the Next Element on the List
        objResults.MoveNext
    Loop
    'Close the Query
    objADO.Close
    
End Sub
