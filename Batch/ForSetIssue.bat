:: ECHO all files in a folder
@SET dFolder=C:\WINDOWS

@FOR %%F in (%dFolder%\*.*) DO @(
    @SET strFile=%%F
    @ECHO %strFile%
)

@ECHO.
@ECHO LAST FILE:
@ECHO %strFile%
@ECHO.
@PAUSE
