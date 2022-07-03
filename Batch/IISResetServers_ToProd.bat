@PROMPT $S
@CLS
@COLOR 0C
@ECHO.
@ECHO.
@ECHO  THIS SCRIPT WILL RESET PRODUCTION !
@ECHO     Are you sure you want to proceed?
@ECHO.
@PAUSE
@COLOR 0B
@CLS


@SET serverNames=NFWEBSERVICES2,NFWEBSERVICES1
@SET RootSystem=SecretAgent\wwwroot\WebServices\Root\System

@ECHO   Copying the files
@FOR %%a IN (%serverNames%) DO @(
    @ECHO %%a
    ::Take server offline
    XCopy \\%%a\c$\%RootSystem%\StatusFail.aspx \\%%a\c$\%RootSystem%\Status.aspx /Y/R/I

    @PING 127.0.0.1 -n 300 > NUL
    IISRESET %%a

    ::Bring server online
    XCopy \\%%a\c$\%RootSystem%\StatusOriginal.aspx \\%%a\c$\%RootSystem%\Status.aspx  /Y/R/I
    @PING 127.0.0.1 -n 60 > NUL
)


@COLOR 0A
@ECHO.
@ECHO ALL DONE!
@ECHO.
@PAUSE
