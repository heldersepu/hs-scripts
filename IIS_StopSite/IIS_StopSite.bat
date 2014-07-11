@SET serverNames=webServer03,webServer01,webServer02,webServer04,webServer05,webServer06,webServer07,webServer08,webServer09,webServer10


@ECHO.&ECHO.&ECHO.&COLOR 0C
@ECHO ******************************************************************************
@ECHO.&ECHO.
@ECHO            This script will STOP some sites on multiple servers.
@ECHO.&ECHO.
@ECHO ******************************************************************************
@ECHO.&ECHO.&@PAUSE
@CLS
@COLOR 0A

@FOR %%a IN (%serverNames%) DO @(
    ECHO    %%a
    MD \\%%a\c$\IIS_StopSite\
    COPY C:\hs-scripts\IIS_StopSite\IIS_StopSite.vbs  \\%%a\c$\IIS_StopSite\
    ping 127.0.0.1 > nul
    C:\pstools\psexec.exe \\%%a cscript.exe C:\IIS_StopSite\IIS_StopSite.vbs
    ping 127.0.0.1 > nul
    RD /S /Q \\%%a\c$\IIS_StopSite\
    ECHO.
    ECHO.
)

@ECHO.&ECHO.
@ECHO ALL DONE !
@ECHO.&ECHO.&@PAUSE
