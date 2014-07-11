Set filesys = CreateObject("Scripting.FileSystemObject")
flag = true

if filesys.FileExists("oui.txt") Then
 do 
    mstop = 6
    ThisLine = Null

    if flag then 
      macA = InputBox (vbcrlf & "Please enter the first 6 digits of the Mac Address","  Mac Address Finder")
    else
      macA = InputBox (vbcrlf & "Please enter the first 6 digits of the Mac Address" & _
             vbcrlf & vbcrlf & "     !!! " & macA & "  not on records !!!","  Mac Address Finder", macA)
    end if

    macA = left(trim(UCase(macA)),6)
    
    if macA <> "" then
       Set db = filesys.OpenTextFile("oui.txt", 1)
       Do until (db.AtEndOfStream or InStr(ThisLine, macA) = 1 )
          ThisLine = db.ReadLine
       Loop
       If InStr(ThisLine, macA) = 1 Then
           cop = Mid(ThisLine, InStr(ThisLine, ")" ) + 1)
           if len(cop) > 3 then
             ad1 = db.ReadLine
             ad1 = right(ad1, len(ad1) - 2)
             ad2 = db.ReadLine
             ad2 = right(ad2, len(ad2) - 2)
             ad3 = db.ReadLine
             ad3 = right(ad3, len(ad3) - 2)
          
             mstop = Msgbox (vbcrlf & macA & cop & _
                    vbcrlf & ad1 & vbcrlf & ad2 & vbcrlf & ad3 & vbcrlf & vbcrlf & _
                    vbcrlf & " Another Mac Address ? "& vbcrlf,vbYesNo,"  Mac Address Finder")
           else
             mstop = Msgbox (vbcrlf & macA & "   This Mac Addess is Private "& vbcrlf & vbcrlf & _
                    vbcrlf & " Another Mac Address ? "& vbcrlf,vbYesNo,"  Mac Address Finder")
           end if
           flag = true
       else
           flag = false
       end if
    end if
 loop while (mstop = 6 and macA <> "")
end if
 


' 'right(db.ReadLine, len(db.ReadLine) - 1))