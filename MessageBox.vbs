'Show different types of MsgBox

'Yes, No - Yellow triangle Exclamation 
Resp = MsgBox (vbcrlf & "  Some files do not have the proper case            " & vbcrlf & _
	"     Do you want to correct this files ?   "& vbcrlf,52," Changes detected")
'OK - Red Circle X
m = MsgBox ("Display Critical Message icon. !", 16, "MsgBox Example")
'OK, Cancel - Red Circle X
m = MsgBox ("Display Critical Message icon. !", 17, "MsgBox Example")

'OK - Blue Dialog Question
m = MsgBox ("Display Warning Query icon.", 32, "MsgBox Example")
'OK,Cancel - Blue Dialog Question
m = MsgBox ("Display Warning Query icon.", 33, "MsgBox Example")
'Yes, No, Cancel - Blue Dialog Question
m = MsgBox ("Display Warning Query icon.", 35, "MsgBox Example")

'OK - Yellow triangle Exclamation 
m = MsgBox ("Display Warning Message icon.", 48, "MsgBox Example")
'OK, Cancel - Yellow triangle Exclamation 
m = MsgBox ("Display Warning Message icon.", 49, "MsgBox Example")

'OK - Blue Dialog Question
m = MsgBox ("Display Information Message icon.",64, "MsgBox Example")
'OK,Cancel - Blue Dialog Question
m = MsgBox ("Display Information Message icon.",65, "MsgBox Example")
'OK,Cancel - Blue Dialog Question
m = MsgBox ("Display Information Message icon.",4161, "MsgBox Example")
