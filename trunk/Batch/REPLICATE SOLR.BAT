@COLOR 0C
@CLS
@ECHO.
@ECHO.
@ECHO THIS SCRIPT WILL FORCE SOLR REPLICATION
@ECHO     Make sure you want to proceed!
@ECHO.
@PAUSE
@COLOR 0A
@CLS
@SET slaves=98,99,113,114
@SET cores=solr/remaxlistings,solr/autosuggest


@ECHO Disable polling on slaves
@FOR %%a IN (%slaves%) DO @(
	@FOR %%c IN (%cores%) DO @(
		START http://10.93.106.%%a:8080/%%c/replication?command=disablepoll
		@PING 127.0.0.1 > nul
		START http://10.93.106.%%a:8080/%%c/replication?command=abortfetch
		@PING 127.0.0.1 > nul
	)
)

@ECHO Enable replication on master
@FOR %%c IN (%cores%) DO @(
	@START http://10.93.106.97:8080/%%c/replication?command=enablereplication
	@PING 127.0.0.1 > nul
)

@ECHO Enable polling on slaves one by one
@FOR %%a IN (%slaves%) DO @(
	@ECHO SERVER: 10.93.106.%%a
	@ECHO  - Take server offline 
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Cdelete%%3E%%3Cquery%%3E*:*%%3C/query%%3E%%3C/delete%%3E
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Ccommit/%%3E
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3cadd%%3e%%3cdoc%%3e%%3cfield+name%%3d%%22status%%22%%3eAll+OK%%3a+False%%3c%%2ffield%%3e%%3c%%2fdoc%%3e%%3c%%2fadd%%3e
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Ccommit/%%3E
	@PING 127.0.0.1 > nul
	
	@ECHO  - Start Replication and wait for 10 mins
	@PING 127.0.0.1 -n 180 > nul
	@FOR %%c IN (%cores%) DO @(
		START http://10.93.106.%%a:8080/%%c/replication?command=enablepoll
		@PING 127.0.0.1 > nul
		START http://10.93.106.%%a:8080/%%c/replication?command=fetchindex
		@ECHO   -- fetching %%c
		@PING 127.0.0.1 -n 180 > nul
		START http://10.93.106.%%a:8080/%%c/replication?command=fetchindex
	)
	@PING 127.0.0.1 -n 600 > nul

	@ECHO  - Bring server online 
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Cdelete%%3E%%3Cquery%%3E*:*%%3C/query%%3E%%3C/delete%%3E
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Ccommit/%%3E
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3cadd%%3e%%3cdoc%%3e%%3cfield+name%%3d%%22status%%22%%3eAll+OK%%3a+True%%3c%%2ffield%%3e%%3c%%2fdoc%%3e%%3c%%2fadd%%3e
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Ccommit/%%3E
	@PING 127.0.0.1 > nul	
)

