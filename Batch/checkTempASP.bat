@ECHO OFF

@SET TMP_DIR="C:\Windows\Temporary ASP.NET Files"
@FOR /F "tokens=1* delims=|" %%a IN ('DIR %TMP_DIR% /B /S') DO @(
	icacls "%%a" /Q
	ECHO.
)

@ECHO.
@ECHO.
@PAUSE

