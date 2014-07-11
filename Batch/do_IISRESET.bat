@SET serverNames=nfremax06,nfremax07,nfremax08,nfremax09,nfremax10
@PROMPT $S

@COLOR 0C
@CLS
@ECHO.
@ECHO.
@ECHO    THIS SCRIPT WILL TAKE SERVERS OFFLINE
@ECHO  DO AN IISRESET AND BRING THEM BACK ONLINE
@ECHO.
@ECHO    Are you sure you want to proceed? 
@ECHO.
@ECHO.
@PAUSE
@COLOR 0A

:: TAKE SERVERS OFFLINE
@FOR %%a IN (%serverNames%) DO @(
    @c:\pstools\psexec \\%%a "C:\Documents and Settings\All Users\Desktop\TakeOffline.cmd"
    START IEXPLORE "http://quantro.%%a.com/system/status.aspx"
)

@COLOR 0C
@CLS
@ECHO.
@ECHO.
@ECHO        SERVERS OFFLINE
@ECHO  Make sure all severs are offline
@ECHO Wait for a few minutes for iisreset
@ECHO.
@ECHO.
@PAUSE
@COLOR 0A

:: IISRESET
@FOR %%a IN (%serverNames%) DO @(
    @c:\pstools\psexec \\%%a IISRESET
)
:: WARMUP THE SERVERS
@FOR %%a IN (%serverNames%) DO @(
    @PING 127.0.0.1 -N 10 > NUL    
    START IEXPLORE "http://quantro.%%a.com/"
)

@COLOR 0C
@CLS
@ECHO.
@ECHO.
@ECHO        IISRESET COMPLETE 
@ECHO Make sure that the site loads correctly
@ECHO.
@ECHO.
@PAUSE
@COLOR 0A

:: BRING SERVERS BACK ONLINE
@FOR %%a IN (%serverNames%) DO @(
    @c:\pstools\psexec \\%%a "C:\Documents and Settings\All Users\Desktop\BringOnline.cmd"
    START IEXPLORE "http://quantro.%%a.com/system/status.aspx"
)

@ECHO.
@ECHO.
@ECHO.
@ECHO        SERVERS ONLINE
@ECHO Make sure that the sites are online
@ECHO.
@ECHO.
@PAUSE
