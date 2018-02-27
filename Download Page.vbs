'Save a web page source to File into the user's Desktop

Set WshShell = WScript.CreateObject("WScript.Shell") 
strDesktop   = WshShell.SpecialFolders("Desktop")
Set FSO      = CreateObject("Scripting.FileSystemObject") 
Set outFile  = FSO.CreateTextFile(strDesktop & "\dPage.txt", True)

dPageSource  = wGet("http://www.sepuweb.com/sample/index-es.html") 
outFile.WriteLine(dPageSource)
outFile.Close

Function wGet(dURL)
	Set HttpObj  = CreateObject("WinHttp.WinHttpRequest.5.1")
	HttpObj.Open "GET", dURL, False
	HttpObj.Send
	wGet = HttpObj.ResponseText 
End Function
