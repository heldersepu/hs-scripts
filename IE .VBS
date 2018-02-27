Option Explicit

Dim objIE, objShell, k,x,n,anim, strIETitle, blnFlag

' Set IE display box title. Dashes ("-") are to move the Microsoft title
' appended to the title we specify out of view.
' blnFlag is set to False when the user closes the IE display box.
strIETitle = "Test Program " & String(40, "-")
blnFlag = True
n = 0

Set objShell = CreateObject("WScript.Shell")

' Initialize display box with initial message
InitIE "Program Initializing"

' Display progress with counter.
' Program can be aborted by closing the display box.
Wscript.Sleep 1000
For k = 4 To 120
	x = k mod 4 
	Select case x
		case 0
			anim = "0"
			n = n + 1
		case 1
			anim = "o"
		case 2
			anim = "_"
		case 3
			anim = "."	
	End select
	'String(n, ".") &
    MsgIE 	"Iteration  " & String(n, ".")  & anim & vbCrLf &_
			"To abort, close this box"
    Wscript.Sleep 10
    If (blnFlag = False) Then
        'Wscript.Echo "Program Aborted after " & k & " iterations"
        Wscript.Quit
    End If
Next
MsgIE "Loop complete"

' Display final message
Wscript.Sleep 1000
MsgIE "Program Finished"

If (blnFlag = False) Then
    Wscript.Echo "Program Aborted after iterations complete"
    Wscript.Quit
End If

' Close display box
Wscript.Sleep 1000
MsgIE "IE_Quit"

' Clean Up.
Set objIE = Nothing
Set objShell = Nothing


Sub MsgIE(strMsg)
    ' Subroutine to display message in IE box and detect when the
    ' box is closed by the program or the user.
    On Error Resume Next
    If (strMsg = "IE_Quit") Then
        blnFlag = False
        objIE.Quit
    Else
        objIE.Document.Body.InnerText = strMsg
        If (Err.Number <> 0) Then
            Err.Clear
            blnFlag = False
            Exit Sub
        End If
        objShell.AppActivate strIETitle
    End If
End Sub

Sub InitIE(strMsg)
    ' Subroutine to initialize the IE display box.
    Dim intWidth, intHeight, intWidthW, intHeightW
    Set objIE = CreateObject("InternetExplorer.Application")
    objIE.ToolBar = False
    objIE.StatusBar = False
    objIE.Resizable = False
    objIE.Navigate("about:blank")
    Do Until objIE.readyState = 4
        Wscript.Sleep 100
    Loop
    intWidth = objIE.document.ParentWindow.Screen.AvailWidth
    intHeight = objIE.document.ParentWindow.Screen.AvailHeight
    intWidthW = objIE.document.ParentWindow.Screen.AvailWidth * .30
    intHeightW = objIE.document.ParentWindow.Screen.AvailHeight * .05
    objIE.document.ParentWindow.resizeto intWidthW, intHeightW
    objIE.document.ParentWindow.moveto (intWidth - intWidthW)/2, (intHeight - intHeightW)/2
    objIE.document.Write "<body> " & strMsg & " </body></html>"
    objIE.document.ParentWindow.document.body.scroll="no"
    objIE.document.ParentWindow.document.body.style.Font = "10pt 'Lucida Console'"
    'objIE.document.ParentWindow.document.body.style.borderStyle = "outset"
    'objIE.document.ParentWindow.document.body.style.borderWidth = "4px"
    objIE.document.Title = strIETitle
    objIE.Visible = True
    Wscript.Sleep 100
    objShell.AppActivate strIETitle
End Sub