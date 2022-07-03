@ECHO ON
@COLOR 0C
@iisreset /status
@ECHO.
@REM @iisreset /stop
@ECHO.

:TOP
@COLOR 0C
@IF (%1) == () GOTO iisreset
@ECHO.
@ECHO %1
@XCopy %1 C:\SecretAgent\WWWRoot\common\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\WWWRoot\ERACorporate\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\WWWRoot\Century21Site\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\WWWRoot\RemaxCanadaMobile\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\WWWRoot\REMAXCorporateBeta\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\WWWRoot\RemaxMobile\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\WWWRoot\RemaxMobileBlackberry\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\WWWRoot\ColdWellBankerSite_2010\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\wwwroot\TemplateSite\bin\   /R /Y /Q /D
@XCopy %1 C:\SecretAgent\wwwRoot\BlueHomes360\bin   /R /Y /Q /D

@REM @XCopy %1 C:\SecretAgent\WWWRoot\eNSite\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\RMLSSite\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\remaxbeta\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\REMAXSite\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\RemaxBroker\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\BlueHomes360\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\TemplateSite\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\RealogySiteCB\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\RealogySiteC21\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\RealogySiteERA\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\REMAXBrokerBeta\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\ENEnterpriseSite\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\REMAXBrokerBeta2\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\RemaxClassicSite\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\Support.Remax.com\bin\   /R /Y /Q /D
@REM @XCopy %1 C:\SecretAgent\WWWRoot\REMAXCorporateBeta\bin\   /R /Y /Q /D

@SHIFT
@GOTO Top

:iisreset
@COLOR 0A
@ECHO.
@ECHO.
@iisreset /status
@ECHO.
@REM @iisreset
@ECHO.

@ping 127.0.0.1 -n 2 > nul
::pause
