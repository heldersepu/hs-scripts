Set objIE = CreateObject("InternetExplorer.Application")
objIE.Navigate("about:blank")
strURL = objIE.document.parentwindow.clipboardData.GetData("text")
objIE.Quit

If IsObject(strURL) then 
	Wscript.Echo "Object in Clipboard!"
else
	If IsArray(strURL) then 
		Wscript.Echo "Array in Clipboard!"
    else
		Wscript.Echo strURL
	end if
end if 