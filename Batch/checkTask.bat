@PROMPT $S
@COLOR 0C
:: If SolrAddressMatching is running just exit
@ECHO.
@ECHO Looking for SolrAddressMatching
@TASKLIST
@SET /A iCOUNT=0
:DOCHECK
TASKLIST /FI "IMAGENAME eq SolrAddressMatching.exe" | FIND /I /N "SolrAddressMatching.exe"
@IF "%ERRORLEVEL%"=="0" EXIT
@PING 127.0.0.1 -n 3 > NUL
@SET /A iCOUNT=%iCOUNT%+1
@IF %iCOUNT% LSS 10 GOTO DOCHECK


@CLS
@COLOR 0A
@ECHO.
@ECHO Launching SolrAddressMatching
@ECHO.
:DSTART
@IF %iCOUNT% GTR 1 @SET /A iCOUNT=0
DEL C:\homevalue\workingfiles\*.* /Q
C:\homevalue\SolrAddressMatching\SolrAddressMatching.exe
@ECHO     -_-_     -_-_     -_-_     -_-_     -_-_
@PING 127.0.0.1 -n 10 > NUL
@COLOR %iCOUNT%A
@SET /A iCOUNT=%iCOUNT%+1
@GOTO DSTART
