@SET ErrLog=C:\Inetpub\wwwroot\error_log.htm

DIR C:\solr\remaxlistings\errorfiles /b > %ErrLog%
FOR /F "usebackq" %%A IN ('%ErrLog%') DO SET size=%%~zA

IF %size% LSS 5 (
	ECHO All OK: True > %ErrLog%
)
