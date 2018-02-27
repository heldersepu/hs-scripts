'Start a batch file minified
set s = createobject("WScript.Shell")

'Minimize. The active window remains active. 
'https://ss64.com/vb/run.html
s.run "C:\hs-scripts\Batch\tfGet.bat", 7
