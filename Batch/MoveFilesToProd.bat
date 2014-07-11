@CLS
@SET TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%-%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
@SET fldSource=C:\SecretAgent\wwwroot\WebServices\ListingDataService\BIN
@SET fldDestin=C$\SecretAgent\wwwroot\WebServices\ListingDataService\bin

:: Copy the files to multiple destinations
@FOR %%A IN (nfwebservices1 nfwebservices2 nfwebservices3 nfwebservices4 nfwebservices5 nfwebservices6 nfwebservices7 nfwebservices8 nfwebservices9) DO @(
    @ECHO.
    @ECHO   --- %%A ---
    @ECHO   Making a backup of the files
    MD \\%%A\%fldDestin%\BACKUP\%TIMESTAMP%
    COPY /Y \\%%A\%fldDestin%\eNListingData.dll       \\%%A\%fldDestin%\BACKUP\%TIMESTAMP%
    COPY /Y \\%%A\%fldDestin%\WcfServiceMaster.dll    \\%%A\%fldDestin%\BACKUP\%TIMESTAMP%
    COPY /Y \\%%A\%fldDestin%\ListingDataService.dll  \\%%A\%fldDestin%\BACKUP\%TIMESTAMP%
    COPY /Y \\%%A\%fldDestin%\eNCommonInterfaces.dll  \\%%A\%fldDestin%\BACKUP\%TIMESTAMP%

    @ECHO   Copying the files
    COPY /Y %fldSource%\eNListingData.dll       \\%%A\%fldDestin%
    COPY /Y %fldSource%\WcfServiceMaster.dll    \\%%A\%fldDestin%
    COPY /Y %fldSource%\ListingDataService.dll  \\%%A\%fldDestin%
    COPY /Y %fldSource%\eNCommonInterfaces.dll  \\%%A\%fldDestin%
)
@ECHO.
@ECHO ALL DONE!
@PAUSE
