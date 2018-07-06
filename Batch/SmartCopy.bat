:: MOVE FILES TO MATCHING FOLDERS

@SET dFolder=C:\TEMP

@FOR /F "delims=" %%D IN ('DIR /AD /B %dFolder%') DO @(
    @ECHO %%D
    @FOR %%F IN (%dFolder%\*%%D*.*) DO @(
        @ECHO - %%F
        @MOVE "%%F" "%dFolder%\%%D"
    )
    @ECHO.
)

@ECHO.
@ECHO *** COPY COMPLETE ***
@ECHO.
@PAUSE
