@echo on 

taskkill /S enstaging01 /F /IM "PSEXECSVC.EXE"
:Top
@COLOR 0C
@If (%1) == () GOTO iisreset
xcopy %1 \\enstaging01\c$\SecretAgent\wwwRoot\Common\bin    /R /Y /Q

c:\pstools\psexec \\enstaging01 c:\gac\gacutil.exe /i c:\SecretAgent\wwwRoot\Common\bin\%~n1%~x1
@Shift
@GOTO Top


:iisreset
@COLOR 0A
@iisreset
@c:\pstools\psexec \\enstaging01 iisreset

@ECHO.
@PAUSE

