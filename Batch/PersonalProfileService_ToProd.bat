@PROMPT $S
@CLS
@COLOR 0C
@ECHO.
@ECHO.
@ECHO  THIS SCRIPT WILL DEPLOY DLLs TO PRODUCTION!
@ECHO     Are you sure you want to proceed?
@ECHO.
@PAUSE
@COLOR 0B
@CLS

@SET TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%-%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
@SET fldSource=\\enBuildServer4\C$\SecretAgent\wwwroot\WebServices\PersonalProfileService\bin
@SET fldDestin=SecretAgent\wwwroot\WebServices\PersonalProfileService\bin

@SET serverNames=NFWEBSERVICES1,NFWEBSERVICES2,NFWEBSERVICES3,NFWEBSERVICES4,NFWEBSERVICES5,NFWEBSERVICES6,NFWEBSERVICES7,NFWEBSERVICES8,NFWEBSERVICES9

@SET listFiles=PersonalProfileService.dll,eNPersonalProfile.dll,eNCommonInterfaces.dll,WcfServiceMaster.dll,eNCommonEntities.dll,eNAuthentication.dll


@ECHO.
@ECHO   Making a backup of the files
@ECHO.
@FOR %%a IN (%serverNames%) DO @(
    @ECHO %%a
    MD "\\%%a\c$\%fldDestin%\BACKUP\%TIMESTAMP%"
    @FOR %%b IN (%listFiles%) DO @(
        COPY /Y \\%%a\c$\%fldDestin%\%%b   "\\%%a\c$\%fldDestin%\BACKUP\%TIMESTAMP%"
    )
)

@ECHO.
@ECHO.
@ECHO Backup completed
@ECHO.
@PAUSE

@ECHO.
@ECHO   Copying the files
@ECHO.
@FOR %%a IN (%serverNames%) DO @(
    @ECHO %%a
    @FOR %%b IN (%listFiles%) DO @(
        COPY /Y %fldSource%\%%b   \\%%a\c$\%fldDestin%
    )
    @PING 127.0.0.1 -N 40 > NUL
)




:: @ECHO.
:: @ECHO Copy completed
:: @ECHO.
:: @PAUSE
::
:: @FOR %%a IN (%serverNames%) DO @(
::     @ECHO %%a
::     @c:\pstools\psexec \\%%a IISRESET
::     @PING 127.0.0.1 -N 60 > NUL
:: )

@COLOR 0A
@ECHO.
@ECHO ALL DONE!
@ECHO.
@PAUSE
