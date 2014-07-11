SET DESTIN=K:\QQ007029\Converted

::Create the directory
MD %DESTIN%
::Copy the images
XCOPY Z:\Images\*.* %DESTIN% /D
::Update the CreationDate
updCreationDate %DESTIN%

@ECHO.
@ECHO.
@ECHO         ALL IMAGES UPLOADED!
@ECHO Remember to ask DBA to run Missing Image Report.
@ECHO.
@PAUSE
