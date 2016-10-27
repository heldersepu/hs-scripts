@ECHO OFF

@D:
@CD "D:\SourceCode\Global"

@FOR /F "tokens=1* delims=|" %%a IN ('DIR /AD /S /B obj') DO @(
	ECHO /S /Q "%%a"
	RMDIR /S /Q "%%a"
)

@FOR /F "tokens=1* delims=|" %%a IN ('DIR /AD /S /B bin') DO @(
	ECHO /S /Q "%%a"
	RMDIR /S /Q "%%a"
)

@ECHO.
@ECHO.
@PAUSE

