:: Move all files in a folder to a subfolder
@SET dFolder=C:\QuickFL\Images
@FOR %%F in (%dFolder%\*.*) DO @(
    @CALL moveToSubFolder.bat "%%F" "%dFolder%"
)

