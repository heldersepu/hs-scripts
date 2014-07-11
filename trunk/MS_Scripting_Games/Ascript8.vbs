myFile = "C:\Scripts\SongList.csv"

If myFile <> "" Then
    myPlaylist = getPlayList(myFile)
    totTime = sortPlayList(myPlaylist)
    
    'Wscript.Echo myPlaylist & totTime
    Wscript.Echo Replace(myPlaylist, ",", VbTab) & _
      "Total music time: " & Replace(totTime,".",":")
End If     

Function addMyTime(dTime1, dTime2)
    If Len(dTime1) < 1 then dTime1 = "0:0"
    If InStr(dTime1, ":") = 0 then dTime1 = dTime1 & ":0"
    If Len(dTime2) < 1 then dTime2 = "0:0"
    If InStr(dTime2, ":") = 0 then dTime2 = dTime2 & ":0"
    addTime1 = Split(dTime1, ":")
    addTime2 = Split(dTime2, ":")
    
    mySec = ((Int(addTime1(1)) + Int(addTime2(1))) mod 60)
    myMin = (Int(addTime1(0)) + Int(addTime2(0)) + _
            ((Int(addTime1(1)) + Int(addTime2(1)))\60)) 
    If Len(mySec) = 1 then mySec = "0" & mySec
    addMyTime = myMin & ":" & mySec
End Function

Function getTime(strPlay)
    totTime = 0
    
    arrLines = Split(strPlay,VbCrLf) 
    For K = 0 to Ubound(arrLines)
        If InStr(arrLines(K),",") > 0 then
            arrItems = Split(arrLines(K),",")
            totTime = addMyTime(totTime,arrItems(2))
        End If
    Next
    getTime = Replace(totTime,":",".")
End Function

Function doCount(strList,strItem)
    dPos = 0
    intCount = 0
    Do 
        dPos = InStr(dPos+1,strList,strItem)
        If (dPos <> 0) then 
            intCount = intCount + 1
        End If     
    Loop While dPos <> 0
    doCount = intCount
End Function 

Function getPlayList(dFile)
    dUsed = ""
    dPlayList = ""
    
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set inFile  = fso.OpenTextFile(dFile, 1)
    arrSongs = Split(inFile.ReadAll,VbCrLf)
    inFile.Close

    Do
        Do 
            intRnd = ((Timer*Rnd) Mod Ubound(arrSongs))
            arrLine = Split(arrSongs(intRnd),",")
            intArt = doCount(dPlayList,arrLine(0))
        Loop While (intArt >= 2) or (InStr(dUsed,intRnd)>0)
        
        dUsed = dUsed & intRnd & ","
        dPlayList = dPlayList & arrSongs(intRnd) & VbCrLf
        
        dTime = getTime(dPlayList)
        If dTime > 80 then
            dUsed = ""
            dPlayList = ""
        End If
    Loop While ((dTime < 75) or (dTime > 80))
    getPlayList = dPlayList
End Function

Function sortPlayList(strPlayList)
    arrSongs = Split(strPlayList,VbCrLf)
    For I = 0 to Ubound(arrSongs)-1
        For J = I + 1 to Ubound(arrSongs)
            If arrSongs(I) > arrSongs(J) then
                strTemp = arrSongs(I)
                arrSongs(I) = arrSongs(J)
                arrSongs(J) = strTemp
            End If
        Next
    Next
    strPlayList = ""
    For I = 1 to Ubound(arrSongs) 
        strPlayList = strPlayList & arrSongs(I) & VbCrLf
    Next
    sortPlaylist = getTime(strPlayList)
End Function
