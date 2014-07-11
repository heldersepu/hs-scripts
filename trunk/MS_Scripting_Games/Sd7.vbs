dNum = 100
dNum = dNum * 2
dNum = dNum / 30
dNum = Int(dNum)
dNum = dNum ^ 5
dNum = dNum * 4
dNum = Sqr(dNum)
dNum = dNum / 45
dNum = Round(dNum,2)
'Wscript.Echo dNum

Set objVoice = CreateObject("SAPI.SpVoice")
objVoice.Speak CStr(dNum)
