'Create HTML report from GNU Diff file

Set fso = CreateObject("Scripting.FileSystemObject")
myTxtFile = ""
' Input via Arguments
If WScript.Arguments.Count > 0 then
	If fso.FileExists(WScript.Arguments.Item(0)) Then
		myTxtFile = WScript.Arguments.Item(0)
	End If
End If
'Input via Explorer
If myTxtFile = "" Then
	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
	ObjFSO.Filter = "GNU Diff File|*.*"
	ObjFSO.ShowOpen
	myTxtFile = ObjFSO.FileName
End If
'Call the Write Procedure
If myTxtFile <> "" Then
	Call DoWrite(myTxtFile)
End If

Sub DoWrite(txtFile)
	'Create a template HTML file with all the Style
	Call WriteStyle(txtFile & ".html")

	'InFile is the GNU diff file (input file)
	Set inFile  = fso.OpenTextFile(txtFile, 1)
	'Append the rest of the info to the HTML file
	'OutFile HTML file (OutPut File)
	Set outFile = fso.OpenTextFile(txtFile & ".html", 8)

	'Write the Summary
	' First line contains the file & date
	dLine  = inFile.ReadLine
	IntPos = inStr(dLine,"	")
    outFile.WriteLine("<td>" &   Mid(dLine,4,IntPos-4)      & "</td>")
    outFile.WriteLine("<td>" & Mid(dLine,IntPos,Len(dLine)) & "</td>")
	outFile.WriteLine("</tr>")
	outFile.WriteLine("<tr>")
	' Second line contains the file & date
	dLine  = inFile.ReadLine
	IntPos = inStr(dLine,"	")
    outFile.WriteLine("<td>" & Mid(dLine,4,IntPos-4) & "</td>")
    outFile.WriteLine("<td>" & Mid(dLine,IntPos,Len(dLine)) & "</td>")
	outFile.WriteLine("</tr>")
	outFile.WriteLine("</table>")

	'Write the Comparison details
	outFile.WriteLine("<h2>Comparison details</h2>")
	outFile.WriteLine("<a name=" & chr(34) & "report00000000" & chr(34) & ">")
	outFile.WriteLine("<table class=" & chr(34) & "report" & chr(34) & " border=1>")
	outFile.WriteLine("<tr><td>Line #</td><td><span>Contents</span></td></tr>")
	'Counters needed for the Statistics
	IntLine  = 0
	IntPlus  = 0
	IntMinus = 0
	IntModif = 0
	'Loop lines  Count + and - & Write all the Comparison Details
	Do until inFile.AtEndOfStream
		dLine = inFile.ReadLine
		dChar = Left(dLine,1)
		If dChar = "@" Then
			IntPosS = inStr(5,dLine," ")
			IntPosC = inStr(5,dLine,",")
			If IntPosC = 0 then
				IntPos = IntPosS
			Else
				If IntPosC > IntPosS then
					IntPos = IntPosS
				Else
					IntPos = IntPosc
				End IF
			End If

			IntLine = Mid(dLine,5,IntPos-5)
			'outFile.WriteLine("<tr><td class="&chr(34)&"lineNo"&chr(34)&"></td><td><PRE>Year, Vin        , Make  , Model & Symbols</td></tr>")
		Else
			If dChar = "+" Then
				IntPlus = IntPlus + 1
				outFile.WriteLine("<tr><td class=" & chr(34) & "lineNo" & chr(34) & ">" & IntLine & _
								  "</td><td class=" & chr(34) & "lineadd" & chr(34) & "><span>" & _
								  Mid(dLine,2,len(dline)) & "</span></td></tr>")
			Else
				If dChar = "-" Then
					IntMinus = IntMinus + 1
					outFile.WriteLine("<tr><td class=" & chr(34) & "lineNo" & chr(34) & ">" & IntLine & _
									  "</td><td class=" & chr(34) & "linedel" & chr(34) & "><span>" & _
									  Mid(dLine,2,len(dline)) & "</span></td></tr>")
				Else
					outFile.WriteLine("<tr><td class=" & chr(34) & "lineNo" & chr(34) & ">" & IntLine & _
									  "</td><td class=" & chr(34) & "line" & chr(34) & "><span>" & _
									  dLine & "</span></td></tr>")
				End If
			End If

			IntLine = IntLine + 1
		End If
	Loop

	outFile.Close
	inFile.Close
	'Write the end of the file with the Statistics & Legend
	Call AppendFinal(txtFile & ".html" , IntPlus, IntMinus, IntModif)

End Sub

'Create a template HTML file with all the Style
' takes as a parameter the name of the file
Sub WriteStyle(dFile)
	Set outFile = fso.CreateTextFile(dFile, True)
	outFile.WriteLine("<HTML> ")
	outFile.WriteLine("<HEAD> ")
	outFile.WriteLine("<TITLE> ")
	'The title is the name of the file
	outFile.WriteLine("File comparison report: " & dFile)
	outFile.WriteLine("</TITLE> ")
	outFile.WriteLine("<style type=" & chr(34) & "text/css" & chr(34) & "> ")
	outFile.WriteLine("  body ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  color: black; ")
	outFile.WriteLine("  font-family: Verdana, Geneva, Arial, Helvetica, sans-serif; ")
	outFile.WriteLine("  font-size: 10pt; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.summary ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  min-width: 15%; ")
	outFile.WriteLine("  border-collapse: collapse; ")
	outFile.WriteLine("  font-size: 10pt; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.summary tr th ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background-color: #e0e0e0; ")
	outFile.WriteLine("  border: 1px solid #a0a0a0; ")
	outFile.WriteLine("  font-weight: bolder; ")
	outFile.WriteLine("  padding-left: 0.3em; ")
	outFile.WriteLine("  padding-right: 0.3em; ")
	outFile.WriteLine("  vertical-align: middle; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.summary tr td ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  border: 1px solid #a0a0a0; ")
	outFile.WriteLine("  padding-left: 0.5em; ")
	outFile.WriteLine("  padding-right: 0.5em; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.summary tr td.val ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  text-align: center; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.report ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("	font-family: " & chr(34) & "Courier New" & chr(34) & ", Courier, monospace; ")
	outFile.WriteLine("  font-size: 10pt; ")
	outFile.WriteLine("  background: White; ")
	outFile.WriteLine("  color: black; ")
	outFile.WriteLine("  border-right-color: Black; ")
	outFile.WriteLine("  border-right-style: solid; ")
	outFile.WriteLine("  border-right-width: 2px; ")
	outFile.WriteLine("  border-bottom-color: Black; ")
	outFile.WriteLine("  border-bottom-style: outset; ")
	outFile.WriteLine("  border-bottom-width: 2px; ")
	outFile.WriteLine("  border: 1px solid #CCCCCC; ")
	outFile.WriteLine("  border-collapse: collapse; ")
	outFile.WriteLine("  max-width: 100%; ")
	outFile.WriteLine("  min-width: 20%; ")
	outFile.WriteLine("  width: auto; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.report td ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  padding-left: 0.3em; ")
	outFile.WriteLine("  padding-right: 0.3em; ")
	outFile.WriteLine("   ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.report tr th ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background-color: #e0e0e0;  ")
	outFile.WriteLine("  border: 1px solid #a0a0a0; ")
	outFile.WriteLine("  font-weight: bolder;   ")
	outFile.WriteLine("  padding-left: 0.3em; ")
	outFile.WriteLine("  padding-right: 0.3em; ")
	outFile.WriteLine("  vertical-align: middle; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.report td.nostyle ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background-color: #FAFAD2; ")
	outFile.WriteLine("  padding-left: 0.5em; ")
	outFile.WriteLine("  padding-right: 0.5em; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.report td.lineNo ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: yellow; ")
	outFile.WriteLine("  text-align: right; ")
	outFile.WriteLine("  padding-right: 0.3em; ")
	outFile.WriteLine("  padding-left: 0.3em; ")
	outFile.WriteLine("  border-right: 1px solid #CCCCCC; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("h1 ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  font-size: 16pt; ")
	outFile.WriteLine("  text-align: center; ")
	outFile.WriteLine("  color: black; ")
	outFile.WriteLine("  background-color: #D3D3D3; ")
	outFile.WriteLine("  padding-bottom: 0.1em; ")
	outFile.WriteLine("  padding-top: 0.1em; ")
	outFile.WriteLine("  padding-left: 0.5em; ")
	outFile.WriteLine("  padding-right: 0.5em; ")
	outFile.WriteLine("  border-bottom: 2px solid #A9A9A9; ")
	outFile.WriteLine("  border-right: 2px solid #A9A9A9; ")
	outFile.WriteLine("  border-top: 2px solid #CCCCCC; ")
	outFile.WriteLine("  border-left: 2px solid #CCCCCC; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("h2 ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  font-size: 14pt; ")
	outFile.WriteLine("  padding-left: 0.5em; ")
	outFile.WriteLine("  border-bottom: 1px Black solid ; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("h3 ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  font-size: 12pt;  ")
	outFile.WriteLine("  padding-left: 1em;    ")
	outFile.WriteLine("} ")
	outFile.WriteLine("h4 ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  font-size: 10pt;  ")
	outFile.WriteLine("  padding-left: 1em; ")
	outFile.WriteLine("  font-weight: bolder;   ")
	outFile.WriteLine("} ")
	outFile.WriteLine("hr  ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  width: 90%; ")
	outFile.WriteLine("  height: 1px; ")
	outFile.WriteLine("  color: #CCCCCC; ")
	outFile.WriteLine("} ")
	outFile.WriteLine(" ")
	outFile.WriteLine("  table.report td.lineadd ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #00FFFF; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.report td.linedel ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #FF0000; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.report td.linemod ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #00FF00; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("} ")
	outFile.WriteLine("table.report td.line ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #FFFFFF; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("} ")
	outFile.WriteLine(".charadd ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #00FFFF; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("} ")
	outFile.WriteLine(".chardel ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #FF0000; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("  text-decoration: line-through; ")
	outFile.WriteLine("} ")
	outFile.WriteLine(".charmod ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #00FF00; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("  font-weight: bolder; ")
	outFile.WriteLine("} ")
	outFile.WriteLine(".wordunique ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #00FFFF; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("} ")
	outFile.WriteLine(".wordcommon ")
	outFile.WriteLine("{ ")
	outFile.WriteLine("  background: #00FF00; ")
	outFile.WriteLine("  color: #000000; ")
	outFile.WriteLine("} ")
	outFile.WriteLine(" ")
	outFile.WriteLine("</style> ")
	outFile.WriteLine("</HEAD> ")
	outFile.WriteLine("<BODY>")
    outFile.WriteLine("<h1>File comparison report</h1>")
	outFile.WriteLine("<hr>")
	outFile.WriteLine("<h2>Summary</h2>")
	outFile.WriteLine("<table class=" & chr(34) & "summary" & chr(34) & ">")
	outFile.WriteLine("<tr>")
    outFile.WriteLine("<th>File</th>")
    outFile.WriteLine("<th>Last modified</th>")
	outFile.WriteLine("</tr>")
	outFile.WriteLine("<tr>")
	outFile.Close
End Sub

'Write the end of the file with the Statistics & Legend
'
Sub AppendFinal(dFile,dAdded,dRemov,dModif)
	Set outFile = fso.OpenTextFile(dFile, 8)

	outFile.WriteLine("</table>")
	outFile.WriteLine("<h2>Comparison statistics</h2>")
	outFile.WriteLine("<table class=" & chr(34) & "summary" & chr(34) & ">")
	outFile.WriteLine("<tbody><tr>")
    outFile.WriteLine("<th>Description</th>")
    outFile.WriteLine("<th>Amount</th>")
	outFile.WriteLine("</tr>")
	outFile.WriteLine("<tr>")
    outFile.WriteLine("<td>Lines added</td>")
    outFile.WriteLine("<td class=" & chr(34) & "val" & chr(34) & ">" & dAdded & "</td>")
	outFile.WriteLine("</tr>")
	outFile.WriteLine("<tr>")
    outFile.WriteLine("<td>Lines deleted</td>")
    outFile.WriteLine("<td class=" & chr(34) & "val" & chr(34) & ">" & dRemov & "</td>")
	outFile.WriteLine("</tr>")
	outFile.WriteLine("<tr>")
    outFile.WriteLine("<td>Lines modified</td>")
    outFile.WriteLine("<td class=" & chr(34) & "val" & chr(34) & ">" & dModif & "</td>")
	outFile.WriteLine("</tr>")
	outFile.WriteLine("</tbody>")
	outFile.WriteLine("</table>")

	outFile.WriteLine("<h2>Legend</h2>")
	outFile.WriteLine("<TABLE class=" & chr(34) & "report" & chr(34) & " border=1>")
	outFile.WriteLine("<tr>")
	outFile.WriteLine("<TH colspan=" & chr(34) & "2" & chr(34) & ">Line changes</TH>")
	outFile.WriteLine("</TR>")
	outFile.WriteLine("<tr>")
	outFile.WriteLine("<TD class=" & chr(34) & "nostyle" & chr(34) & ">Added line</TD><TD class=" & chr(34) & "lineadd" & chr(34) & ">Example of added line</TD>")
	outFile.WriteLine("</TR>")
	outFile.WriteLine("<tr>")
	outFile.WriteLine("<TD class=" & chr(34) & "nostyle" & chr(34) & ">Deleted line</TD><TD class=" & chr(34) & "linedel" & chr(34) & ">Example of deleted line</TD>")
	outFile.WriteLine("</TR>")
	outFile.WriteLine("<tr>")
	outFile.WriteLine("<TD class=" & chr(34) & "nostyle" & chr(34) & ">Modified line</TD><TD class=" & chr(34) & "linemod" & chr(34) & ">Example of modified line</TD>")
	outFile.WriteLine("</TR>")
	outFile.WriteLine("</TABLE>")
	outFile.WriteLine("<BR>")
	outFile.WriteLine("<TABLE class=" & chr(34) & "report" & chr(34) & " border=1>")
	outFile.WriteLine("<tr>")
	outFile.WriteLine("<TH colspan=" & chr(34) & "2" & chr(34) & ">Character (inline) changes</TH>")
	outFile.WriteLine("</TR>")
	outFile.WriteLine("<tr>")
	outFile.WriteLine("<TD class=" & chr(34) & "nostyle" & chr(34) & ">Added characters</TD><TD class=" & chr(34) & "linemod" & chr(34) & ">Some <span class=" & chr(34) & "charadd" & chr(34) & ">added</SPAN> characters</TD>")
	outFile.WriteLine("</TR>")
	outFile.WriteLine("<tr>")
	outFile.WriteLine("<TD class=" & chr(34) & "nostyle" & chr(34) & ">Deleted characters</TD><TD class=" & chr(34) & "linemod" & chr(34) & ">Some <span class=" & chr(34) & "chardel" & chr(34) & ">deleted</SPAN> characters</TD>")
	outFile.WriteLine("</TR>")
	outFile.WriteLine("</TABLE>")
	outFile.WriteLine("</BODY>")
	outFile.WriteLine("</HTML>")

	outFile.Close
End Sub
