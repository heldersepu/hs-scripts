BaseURL = "http://www.homesmartinternational.com/"
MainURL = BaseURL & "OfficeRoster.cfm?state=AZ"

Set objIE = CreateObject("InternetExplorer.Application")
objIE.visible = true
call OpenPage(objIE, MainURL)

'Get a list of offices from the main page
I = 0
Set cinputs = objIE.Document.getElementsByTagName("a")
For Each obj In cinputs
    If (LCase(obj.innerText) = "agents") Then
        Redim Preserve arrOffices(i)
        arrOffices(i) = cStr(obj)
        I = I + 1
    End If
Next
Set cinputs = Nothing

'Get a list of Agents from the offices
I = 0
For Each office In arrOffices
    call OpenPage(objIE, office & "&perPage=100")
    Set cinputs = objIE.Document.getElementsByTagName("tr")
    For Each obj In cinputs
        If obj.getAttribute("style") <> "" then
            If (inStr(obj.getAttribute("onclick"), "fancybox") > 0) Then
                Redim Preserve arrAgents(i)
                arrAgents(i) = Mid(cStr(obj.getAttribute("onclick")),28)
                I = I + 1
            End If
        End If
    Next
    Set cinputs = Nothing
    Exit For
Next

'Open each agent page and extract the data
For Each agent In arrAgents
    pos = InStr(agent, "'")
    If (pos > 0) Then
        AgentURL = BaseURL & Left(agent, pos - 1)
        call OpenPage(objIE, AgentURL)
        'TODO extract data from agent page
    End If
Next
MsgBox "ALL DONE"

'Open the given page and wait until is fully loaded
Sub OpenPage(objBrowser, URL)
    With objBrowser
        .Navigate URL
        Wscript.Sleep 500
        Do Until .readyState = 4
            Wscript.Sleep 500
        Loop
    End With
End Sub

