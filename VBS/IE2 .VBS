Option Explicit

Dim objIE, objShell, k,x,n,anim, strIETitle, blnFlag

' Set IE display box title. Dashes ("-") are to move the Microsoft title
' appended to the title we specify out of view.
' blnFlag is set to False when the user closes the IE display box.
strIETitle = "Test Program " & String(40, "-")
blnFlag = True
n = 0
x=""

Set objShell = CreateObject("WScript.Shell")

' Initialize display box with initial message
InitIE "Program Initializing"

' Display progress with counter.
' Program can be aborted by closing the display box.
Wscript.Sleep 1000
For k = 1 To 255
	x = x & k & "	" & chr(k) & vbCrLf
	MsgIE x
Next




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
    objIE.Resizable = true
    objIE.Navigate("about:blank")
    Do Until objIE.readyState = 4
        Wscript.Sleep 100
    Loop
    intWidth = objIE.document.ParentWindow.Screen.AvailWidth
    intHeight = objIE.document.ParentWindow.Screen.AvailHeight
    intWidthW = objIE.document.ParentWindow.Screen.AvailWidth * .1
    intHeightW = objIE.document.ParentWindow.Screen.AvailHeight * .5
    objIE.document.ParentWindow.resizeto intWidthW, intHeightW
    objIE.document.ParentWindow.moveto (intWidth - intWidthW)/2, (intHeight - intHeightW)/2
    objIE.document.Write "<body> " & strMsg & " </body></html>"
    objIE.document.ParentWindow.document.body.scroll="yes"
    objIE.document.ParentWindow.document.body.style.Font = "10pt 'Lucida Console'"
    'objIE.document.ParentWindow.document.body.style.borderStyle = "outset"
    'objIE.document.ParentWindow.document.body.style.borderWidth = "4px"
    objIE.document.Title = strIETitle
    objIE.Visible = True
    Wscript.Sleep 100
    objShell.AppActivate strIETitle
End Sub