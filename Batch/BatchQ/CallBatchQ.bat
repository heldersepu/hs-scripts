@FOR %%F in (C:\BatchQ\???.BAT) DO @(    
	@CALL %%F 
	@PING 127.0.0.1 -n 10 > NUL
	@MOVE %%F %%F.DONE
)

@ECHO.
@ECHO     ALL DONE !
@ECHO.
@ECHO.
@PAUSE
@EXIT
