@SET QQID=%1
@SET ERROR_MSG="OK"

@PROMPT $S$S
@COLOR F0
@CLS
@ECHO.
@ECHO  This Script will extract and copy all the images from the ZipIt file
@ECHO.

:: Validation for the required components
@IF %1.==. SET /P QQID=Please enter QQID:
@IF %QQID%.==. SET ERROR_MSG=" MISSING QQID "

@IF NOT EXIST "%ProgramFiles%\7-Zip\7z.exe" @(
	SET ERROR_MSG=" 7z.exe not detected! "
)
@IF NOT EXIST "%ProgramFiles%\TeraCopy\TeraCopy.exe" @(
	SET ERROR_MSG=" TeraCopy.exe not detected! "
)
@IF NOT %ERROR_MSG%=="OK" GOTO SHOW_ERROR

:: Start the logic
@ECHO.
@ECHO [--- Create network drives -------------]
IF NOT EXIST R: @(
	NET USE R: \\qqstore02.prod.qq\webimages\images Rh22515 /user:prod\ihammes
)
IF NOT EXIST S: @(
	NET USE S: \\10.0.20.47\UploadShar
)

@ECHO.
@ECHO [--- Unzip images ----------------------]
@IF NOT EXIST C:\TEMP\%QQID% MD C:\TEMP\%QQID%
SET ERROR_MSG=" No image files detected with QQID = %QQID%! "
@FOR %%F in (S:\*%QQID%_Images*.zip) DO @(
    @SET ERROR_MSG="OK"
	"%ProgramFiles%\7-Zip\7z.exe" x -o"C:\TEMP\%QQID%" %%F
)
@IF NOT %ERROR_MSG%=="OK" GOTO SHOW_ERROR

@ECHO.
@ECHO [--- Copy images -----------------------]
@IF NOT EXIST R:\%QQID%\Converted MD R:\%QQID%\Converted
@FOR /D %%D in (C:\TEMP\%QQID%\*) DO @(
	@IF EXIST %%D\Images @(
		@ECHO   - Copying folder: %%D\Images
		MOVE %%D\Images %%D\Converted
		"%ProgramFiles%\TeraCopy\TeraCopy.exe" Copy %%D\Converted R:\%QQID%
		MOVE %%D\Converted %%D\Images
	)
	@IF EXIST %%D\Images_Rolodex @(
		@ECHO   - Copying folder: %%D\Images_Rolodex
		"%ProgramFiles%\TeraCopy\TeraCopy.exe" Copy %%D\Images_Rolodex R:\%QQID%
	)
)
updCreationDate.exe R:\%QQID%\Converted

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
@ECHO  Can not copy the files:
@ECHO.
@ECHO  %ERROR_MSG%
@ECHO.
@ECHO.
@PAUSE

