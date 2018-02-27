@SET FLDR=%1
@SET ERROR_MSG="OK"

@PROMPT $S$S
@COLOR F0
@CLS
@ECHO.
@ECHO  This Script will Compact and repair all mdb
@ECHO.

:: Validation for the required components
@IF %1.==. SET /P FLDR=Please enter FLDR:
@IF %FLDR%.==. SET ERROR_MSG=" MISSING FLDR "
@IF NOT %ERROR_MSG%=="OK" GOTO SHOW_ERROR

@ECHO.
@ECHO [--- Compact and repair --------------]
@FOR %%F in (%FLDR%\*.MDB) DO @(
    @ECHO   %%F
    JETCOMP -src: %%F -dest: %%F.MDB
    @DEL %%F
    @MOVE %%F.MDB %%F
    @ECHO.
)

::Pause before EXIT
@COLOR 0A
@ECHO.
@ECHO.
@ECHO.
@ECHO     ALL DONE !
@ECHO.
@ECHO.
@PING 127.0.0.1 > NUL
@EXIT

:SHOW_ERROR
@COLOR 0C
@CLS
@ECHO.
@ECHO.
@ECHO  %ERROR_MSG%
@ECHO.
@ECHO.
@PAUSE
