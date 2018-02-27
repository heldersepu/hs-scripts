@PROMPT $S
@COLOR 0A

REG DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /va /f
@ECHO.
REG DELETE HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /va /f
@ECHO.

REM Cleanup for 64 Bit PC
REG DELETE HKCU\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Run /va /f
@ECHO.
REG DELETE HKCU\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Run /va /f

@ECHO.
@ECHO.
@PAUSE
