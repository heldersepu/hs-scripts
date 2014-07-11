:: The list of files should be comma separated
@SET listFiles=Mastersite.dll,NETrciMenu.dll

:: Source and destinations
@SET fldSource=\\hmsBuildserver8\C$\SecretAgent\wwwroot\Common\BIN
@SET fldDestin1=C:\SecretAgent\wwwroot\common\bin


:: --- :: --- :: --- :: --- :: --- :: --- :: --- :: --- ::
@PROMPT $S
@CLS
@COLOR 0C

@ECHO.
@ECHO.
@ECHO  THIS SCRIPT WILL COPY DLLs AND RESTART IIS!
@ECHO     Are you sure you want to proceed?
@ECHO.
@PAUSE
@COLOR 0B
@CLS

:: MAKE BACKUP OF DLLS
@IISRESET /stop
@ECHO.
@ECHO   ***** Making a backup of the files ***** 
@SET TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%-%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
MD %fldDestin1%\BACKUP\%TIMESTAMP%

@FOR %%a IN (%listFiles%) DO @(
    COPY /Y %fldDestin1%\%%a %fldDestin1%\BACKUP\%TIMESTAMP%
)

:: COPY THE DLLS
@ECHO.
@ECHO    ***** Copying the files ***** 
@FOR %%a IN (%listFiles%) DO @(
    XCOPY %fldSource%\%%a C:\SecretAgent\wwwroot\common\bin /Y /R /K
    XCOPY C:\SecretAgent\wwwroot\common\bin\%%a %fldDestin1% /Y /R /K
)

:: GAC THE DLLS
@ECHO.
@ECHO    ***** GAC the files ***** 
@FOR %%a IN (%listFiles%) DO @(
    H:\GAC\GACUTIL.EXE /i c:\SecretAgent\wwwRoot\Common\bin\%%a
)

@PING 127.0.0.1 > nul
@IISRESET

@COLOR 0A
@ECHO.
@ECHO DLL FILES COPIED!
@ECHO.
@PAUSE

:: CALL THE TEST PAGES
@FOR /F "usebackq" %%i IN (`hostname`) DO SET MYHOST=%%i
START IEXPLORE "http://remaxcabrokerconfig.%MYHOST%.com/system/status.aspx"
START IEXPLORE "http://remaxcabrokerconfig.%MYHOST%.com/"
START IEXPLORE "http://remaxcabrokerconfig.%MYHOST%.com/listings/featuredsearches_r4.aspx"
START IEXPLORE "http://remaxcabrokerconfig.%MYHOST%.com/listings/FeaturedSearch_r4.ASPX"
START IEXPLORE "http://remaxcabrokerconfig.%MYHOST%.com/ADMIN"
