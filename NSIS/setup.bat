:: Launch the NSIS setup

@SET NSIS="%ProgramFiles%\NSIS\makensis.exe"
@IF NOT EXIST %NSIS% SET NSIS="%ProgramFiles(x86)%\NSIS\makensis.exe"
CALL %NSIS% setup.nsi

@ECHO.
@PAUSE