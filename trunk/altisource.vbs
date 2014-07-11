strUserName = "myUSR"
strPassWord = "myPASS"
strAlertPath = "C:\Windows\Media\Notify.wav"
strPage = "https://ava.altisource.com/webtop"
stopTime = "1145"

'Test the sound make sure it works OK
Call PlaySound(strAlertPath, 1)
On Error Resume Next

Do
    Set objIE = CreateObject("InternetExplorer.Application")
    Call setIE(objIE, 0, 0, 900, 700, true)
    Call OpenPage(objIE, strPage + "/default.asp")

    Set objBrowser = objIE.Document.parentWindow.frames(0)
    Call DoLogin(objBrowser, strUserName, strPassWord)

    Set objBrowser = objIE.Document.parentWindow.frames(1)
    Call DoAcknowledge(objBrowser)

    Wscript.Sleep 500
    Set objBrowser = objIE.Document.parentWindow.frames(0).frames(0).frames(1)
    Call DoClickLink(objBrowser, "offer_order_viewInfo.asp")
    Wscript.Sleep 500

    I = 0
    Do 'Try to get a page that shows something different than "No offers found."
        I = I + 1
        Call setIE(objIE, (I mod 3)*20, 50, 1024, 768, true)
        Call OpenPage(objIE, strPage + "/orders/offers/offer_order_viewInfo.asp")
        'Call OpenPage(objIE, "http://127.0.0.1/alti/offers.html")
        Call ChangeTitle(objIE, "Attempt #: " + cStr(I))
        strIdMsg = ""
        strIdMsg = cStr(objIE.Document.getElementById("idMsg").innerHTML)
        If strIdMsg = "No offers found." Then
            IF Hour(time)&Minute(time) = stopTime Then
                Call SaveToFile("EXIT BECAUSE TIME")
                objIE.Quit
            End If
            Call DoTimeDelay(objIE, strIdMsg, (((Timer*Rnd) Mod 10) + 1))
        End If
    Loop While (strIdMsg = "No offers found.")

    Err.Number = 0
    Call waitUntilReady(objIE)
    Call SaveToFile(objIE.Document.Body.innerHTML)
    Set btnSubmit = objIE.Document.getElementsByName("btnSubmit")

    If Err.Number = 0 Then
        If isNull(btnSubmit(0)) Then
            Call setIE(objIE, 50, 50, 800, 600, true)
        Else
            Call PlaySound(strAlertPath, 1)
            Call setIE(objIE, 0, 0, 1024, 768, true)
            Call DoAcceptOffer(objIE)
            Call PlaySound(strAlertPath, 5)
        End If
    End If

    Set objBrowser = Nothing
Loop While (objIE.Visible)
Set objIE = Nothing




' ~*********  PROCEDURES USED TO NAVIGATE THE PAGE  *********~

'Accept the offers
Sub DoAcceptOffer(objBrowser)
    On Error Resume Next
    With objBrowser
        'Check all the offers
        Set chkOffers = .Document.getElementsByName("chkOffer")
        For Each obj In chkOffers
            obj.Click
            obj.Checked = True
            Wscript.Sleep 100
        Next
        Set chkOffers = Nothing

        'Show the Respond to Offer box
        Wscript.Sleep 100
        .Document.getElementById("dvRespond").style.display = "block"
        'Click on the btnSubmit
        Wscript.Sleep 100
        Set btnSubmit = .Document.getElementsByName("btnSubmit")
        For Each obj In btnSubmit
            obj.click
        Next
        Set btnSubmit = Nothing

    End With
End Sub

'Enter the username, passw and click on login button
Sub DoLogin(objBrowser, strUser, strPassw)
    On Error Resume Next
    With objBrowser
        .Document.All.Item("UserID1").Value = strUser
        Wscript.Sleep 100
        .Document.All.Item("UserID").Value = strUser
        Wscript.Sleep 100
        .Document.All.Item("password_one").Value = "PASSWORD"
        Wscript.Sleep 50
        .Document.All.Item("PASSWORD").Value = strPassw
        Wscript.Sleep 50
        Set cinputs = .Document.getElementsByTagName("input")
        For Each obj In cinputs
            If LCase(obj.Type) = "button" Then
                obj.Click
                Exit For
            End If
        Next
        Set cinputs = Nothing
    End With
    Call waitUntilReady(objBrowser)
End Sub

'Select the "I agree to the terms" and click Next
Sub DoAcknowledge(objBrowser)
    On Error Resume Next
    With objBrowser
        Wscript.Sleep 200
        .Document.getElementsByName("show_page")(0).Checked = True
        Wscript.Sleep 50
        .Document.All.Item("imgNext").Click
        Set cinputs = Nothing
    End With
    Call waitUntilReady(objBrowser)
End Sub

'Time delay prior to reloading the page
Sub DoTimeDelay(objBrowser, strIdMsg, intSecondsDelay)
    On Error Resume Next
    For J = (intSecondsDelay * 10) To 1 Step -1
        If Err.Number = 0 Then
            Wscript.Sleep 100
            objBrowser.Document.Body.innerHTML = "<h2>" + strIdMsg + _
                "<br/>RELOADING PAGE IN " + cStr(J/10) + " SECONDS...</h2>"
        End If
    Next
    objBrowser.Document.Body.innerHTML = ""
End Sub

'Click on a link given the href
Sub DoClickLink(objBrowser, strLinkRef)
    On Error Resume Next
    With objBrowser
        Wscript.Sleep 500
        Set cinputs = .Document.getElementsByTagName("a")
        For Each obj In cinputs
            If InStr(1, obj.href, strLinkRef, vbTextCompare) > 0 Then
                obj.Click
                Exit For
            End If
        Next
        Set cinputs = Nothing
    End With
    Call waitUntilReady(objBrowser)
End Sub

'Create a timestamp from today's
Function strTimeStamp()
    strTimeStamp = Replace(Replace(Replace(Now,"/","_"),":","_")," ","_")
End Function

'Create a new file with the given info
Sub SaveToFile(strFileContents)
    On Error Resume Next
    strFileName = "offers-" & strTimeStamp  & ".html"
    Set fso = CreateObject("Scripting.FileSystemObject")
    If Not fso.FolderExists("aLOG") Then
        Call fso.CreateFolder("aLOG")
    End If
    Set outFile = fso.CreateTextFile("aLOG\" & strFileName, True)
    outFile.WriteLine(strFileContents)
    outFile.Close
    Set fso = Nothing
End Sub

'Open a the given webpage
Sub OpenPage(objBrowser, strPage)
    On Error Resume Next
    Wscript.Sleep 500
    objBrowser.Navigate strPage
    Call waitUntilReady(objBrowser)
End Sub

'Change title of the webpage
Sub ChangeTitle(objBrowser, strTitle)
    On Error Resume Next
    Wscript.Sleep 100
    objBrowser.document.Title = "Attempt #: " + cStr(I)
    If Err.Number = 0 Then Wscript.Sleep 500
End Sub

'Wait for the browser to finish loading
Sub waitUntilReady(objBrowser)
    On Error Resume Next
    Wscript.Sleep 500
    Do Until objBrowser.readyState = 4
        If Err.Number = 0 Then
            Wscript.Sleep 500
        Else
            Exit Sub
        End If
    Loop
End Sub

'Change the position/dimensions and visibility of the
Sub setIE(objBrowser, intTop, intLeft, intWidth, intHeight, boolVisible)
    On Error Resume Next
    With objBrowser
        .Top = intTop
        .Left = intLeft
        .Height = intHeight
        .Width = intWidth
        Wscript.Sleep 50
        .Visible = boolVisible
    End With
End Sub

'Play a given sound using the default player
Sub PlaySound(strSoundPath, intCount)
    Set objShell = CreateObject("WScript.Shell")
    If intCount > 1 Then
        For i = 0 to intCount
            Call objShell.run(strSoundPath)
            Wscript.Sleep 2000
        Next
    Else
        Call objShell.run(strSoundPath)
    End If
    Set objShell = Nothing
End Sub