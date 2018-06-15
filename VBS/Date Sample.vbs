'// Working with Date & time Funtions

Wscript.Echo DatePart("m", Now)
Wscript.Echo DatePart("d", Now)
Wscript.Echo DatePart("m", Now) & "-" & DatePart("d", Now)
Wscript.Echo FormatDateTime(Now(), vbLongDate)
Wscript.Echo Now
Wscript.Echo Day(now)
Wscript.Echo year(now)
Wscript.Echo WeekDayName(WeekDay(Date()))
Wscript.Echo MonthName(Month(now), True) & " " & MonthName(Month(now))

isFirst      = (Day(now) = 1)
isMonday     = (WeekDayName(WeekDay(Date())) = "Monday")
isFirstDay   = (Day(now) < 4)

If  isFirst or (isMonday and isFirstDay) then Wscript.Echo "    Today is BackuP date !!"

Wscript.Echo "------------------"
Wscript.Echo Month(now) & "-" & Day(now) & "-" & right(Year(now),2)
Wscript.Echo time
Wscript.Echo Hour(time)&Minute(time)

Wscript.Echo FormatDateTime(Now, vbShortDate)
Wscript.Echo FormatDateTime(Now, vbLongDate)
Wscript.Echo FormatDateTime(Now -45, vbLongDate)


'a = Day(now)
'if a > 10 then a = "0"&a

'b = MonthName(Month(now), True)
'Wscript.Echo   Day(now)
'Wscript.Echo   a

'Set objFSO = CreateObject("Scripting.FileSystemObject")
'Set objFolder = objFSO.CreateFolder("C:\Public\Common files\"&b&a)
'objFSO.CopyFile "C:\Scripts\Ne.ppt" , "C:\Public\Common files\"&b&a&"\" , true