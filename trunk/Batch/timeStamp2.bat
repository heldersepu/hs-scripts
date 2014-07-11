@ECHO OFF

@SET strDate=%DATE:/=_%
@SET strDate=%strDate: =_%

@SET strTime=%TIME::=-%
@SET strTime=%strTime: =-%
@SET strTime=%strTime:.=-%

@ECHO %strDate%%strTime%
@ECHO.


@FOR /f "tokens=1* delims= " %%a IN ('date/t') DO set cdate=%%b
@FOR /f "tokens=1-3 delims=/ " %%a IN ('ECHO %cdate%') DO set cdate=%%a%%b%%c
@FOR /f "tokens=5 delims= " %%a IN ('ECHO ^| time ^| find "current" ') DO set ctime=%%a
@FOR /f "tokens=1-3 delims=:." %%a IN ('ECHO %ctime%') DO set ctime=%%a%%b%%c

@ECHO %cdate%-%ctime%
@ECHO.


@SET TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
@ECHO %TIMESTAMP%
@ECHO.


@SET TIMESTAMP=%DATE:~4,2%%DATE:~7,2%%DATE:~10,4%-%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
@SET TIMESTAMP=%TIMESTAMP: =%
@ECHO %TIMESTAMP%
@ECHO.


@FOR /f "tokens=1* delims=|" %%a IN ('DIR "c:\temp" /B /OD /AD') DO @SET NEW_DIR=%%a
@ECHO %NEW_DIR%
@ECHO.

@ECHO.
@PAUSE
