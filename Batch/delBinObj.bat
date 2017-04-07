@ECHO OFF

@D:
@CD "D:\SourceCode\Global\CompassServices\Hotfix\CompassServices"

@FOR /F "tokens=1* delims=|" %%a IN ('DIR /AD /S /B obj') DO @(
	ECHO "%%a"
	RMDIR /S /Q "%%a"
)

@FOR /F "tokens=1* delims=|" %%a IN ('DIR /AD /S /B bin') DO @(
	ECHO "%%a"
	RMDIR /S /Q "%%a"
)

@FOR /F "tokens=1* delims=|" %%a IN ('DIR /AD /S /B Packages') DO @(
	ECHO "%%a"
	RMDIR /S /Q "%%a"
)

@FOR /F "tokens=1* delims=|" %%a IN ('DIR /AD /S /B TestResults') DO @(
	ECHO "%%a"
	RMDIR /S /Q "%%a"
)

@FOR /F "tokens=1* delims=|" %%a IN ('DIR /AD /S /B FakesAssemblies') DO @(
	ECHO "%%a"
	RMDIR /S /Q "%%a"
)

@ECHO.
@ECHO.
@PAUSE

