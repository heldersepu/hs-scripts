'** URL, USER, Password **
MOSPAC_NA = Array("https://partner.microsoftonline.com",      "UserName1", "PassWord")
MOSPAC_EU = Array("https://partner.emea.microsoftonline.com", "UserName2", "PassWord")
MOSPAC_AP = Array("https://partner.apac.microsoftonline.com", "UserName3", "PassWord")
OWA =       Array("https://mail.microsoft.com",               "UserName4", "PassWord")
RIGHTNOW =  Array("%USERPROFILE%\Desktop\RightNow.appref-ms", "UserName5", "PassWord")

'** WEB Tools **
WebTools = Array( _
           "https://vkbexternal.partners.extranet.microsoft.com", _
           "http://technet.microsoft.com", _
           "https://sharepoint.partners.extranet.microsoft.com/sites/msonline/agenttriage/Lists/Known%20Issue%20Bug/AllItems.aspx", _
           "https://mocmc.partners.extranet.microsoft.com")
MyWord = "%USERPROFILE%\Desktop\BPOSSupportGuidelite.docx"
strHomePage = "http://www.bing.com/"


'** This Tag Home Page **
Set objIE = CreateObject("InternetExplorer.Application")
objIE.Navigate strHomePage
Call setIE(objIE, 0, 50, 770, 650)

'***This is set of first Window (MOSPAC)***
Set objIE = CreateObject("InternetExplorer.Application")
Call setIE(objIE, 50, 100, 770, 800)
Call OpenMOSPAC(objIE, MOSPAC_NA)
Call OpenMOSPAC(objIE, MOSPAC_EU)
Call OpenMOSPAC(objIE, MOSPAC_AP)

'***This sets Second Window (OWA)***
Set objIE = CreateObject("InternetExplorer.Application")
Call setIE(objIE, 150, 202, 640, 800)
Call OpenOWA(objIE, OWA)

For Each srtURL In WebTools
    Wscript.Sleep 2000
    objIE.Navigate2 srtURL, 2048
Next

Set objShell = Wscript.CreateObject("WScript.Shell")
Call OpenStopWatch(objShell)
Call OpenWordDoc(MyWord)
Call OpenRightNow(objShell, RIGHTNOW)

Set objShell = Nothing
Set objIE = Nothing


Sub OpenWordDoc(strMyWord)
    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(strMyWord) then
        Set objWord = CreateObject("Word.Application")
        objWord.Visible = True
        objWord.Documents.Open (strMyWord)
        Wscript.Sleep 1000
        Set objWord = Nothing
    End If
    Set fso = Nothing
End Sub

Sub OpenOWA(objBrowser, arrOWA)
    On Error Resume Next
    With objBrowser
        .Navigate arrOWA(0)
        Do Until .readyState = 4
            Wscript.Sleep 500
        Loop
        .Document.All.Item("username").Value = arrOWA(1)
        .Document.All.Item("password").Value = arrOWA(2)
        .Document.All.Item("rdoPrvt").click
        Set cinputs = .Document.getElementsByTagName("input")
        For Each obj In cinputs
            If LCase(obj.Type) = "submit" and  (LCase(obj.Value) = "sign in") Then
                obj.Click
                Exit For
            End If
        Next
        Set cinputs = Nothing
    End With
End Sub

Sub OpenStopWatch(objShell)
    strProgramPath = "%USERPROFILE%\Desktop\stpwatch.exe"
    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(strProgramPath) then
        objShell.Run strProgramPath
        objShell.Run strProgramPath
        Wscript.Sleep 2000
    End If
    Set fso = Nothing
End Sub

Sub OpenRightNow(objShell, arrRIGHTNOW)
    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(arrRIGHTNOW(0)) then
        objShell.Run arrRIGHTNOW(0)
        Wscript.Sleep 4000
        objShell.SendKeys arrRIGHTNOW(1)
        objShell.SendKeys "{tab}"
        objShell.SendKeys arrRIGHTNOW(2)
        objShell.SendKeys "~"
        Wscript.Sleep 8000
        objShell.SendKeys "{tab}"
        objShell.SendKeys "~"
    End If
    Set fso = Nothing
End Sub

Sub OpenMOSPAC(objBrowser, arrMOSPAC)
    On Error Resume Next
    Wscript.Sleep 500
    With objBrowser
        .Navigate arrMOSPAC(0)
        Do Until .readyState = 4
            Wscript.Sleep 500
        Loop
        .Document.All.Item("AdminCenterLoginControl_UserNameTextBox").Value = arrMOSPAC(1)
        .Document.All.Item("AdminCenterLoginControl_PasswordTextbox").Value = arrMOSPAC(2)
        .Document.All.Item("AdminCenterLoginControl_ActionButton").Click
        Do Until .readyState = 4
            Wscript.Sleep 500
        Loop
        Wscript.Sleep 1000
        .Navigate2 arrMOSPAC(0), 2048
    End With
End Sub

Sub setIE(objBrowser, intTop, intLeft, intHeight, intWidth)
    objBrowser.Top = intTop
    objBrowser.Left = intLeft
    objBrowser.Height = intHeight
    objBrowser.Width = intWidth
    Wscript.Sleep 50
    objBrowser.Visible = True
End Sub
