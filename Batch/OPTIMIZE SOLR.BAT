@COLOR 0C
@CLS
@ECHO.
@ECHO.
@ECHO THIS SCRIPT WILL START A SOLR OPTIMIZATION
@ECHO   The SolrDataLoader should be paused
@ECHO     Make sure you want to proceed!
@ECHO.
@PAUSE
@COLOR 0A
@CLS
@SET slaves=98,99,113,114
@SET core=solr/remaxlistings

@ECHO Disable sheduled tasks
@schtasks /Change /RP D0n0tSt0p /TN checkErrors /DISABLE
@schtasks /Change /RP D0n0tSt0p /TN checkSolrDataLoader /DISABLE
@PING 127.0.0.1 > nul

@ECHO Pause the solr data loader
@FOR /L %%H IN (0,1,9) DO @(
	@ECHO inPause > C:\solr\remaxProcessors\thread%%H\PauseSolrDataLoader.txt
)

@ECHO Disable polling on slaves
@FOR %%a IN (%slaves%) DO @(
	START http://10.93.106.%%a:8080/%core%/replication?command=disablepoll
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/%core%/replication?command=abortfetch
	@PING 127.0.0.1 > nul
)

@ECHO Disable replication on master
@START http://10.93.106.97:8080/%core%/replication?command=disablereplication
@PING 127.0.0.1 -n 80 > nul

@ECHO Start the optimization on master
@START http://10.93.106.97:8080/%core%/update?optimize=true
@PING 127.0.0.1 > nul
@FOR /L %%H IN (0,1,9) DO @(
    @TIME /T
    @PING 127.0.0.1 -n 120 > nul
)

@ECHO Enable replication on master
@START http://10.93.106.97:8080/%core%/replication?command=enablereplication
@PING 127.0.0.1 > nul

@ECHO Enable polling on slaves one by one
:: We should probably
:: - Then after a minute restart it
::@START http://tomcat:s3cret!@10.93.106.98:8080/manager/html
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
	START http://10.93.106.%%a:8080/%core%/replication?command=enablepoll
	@PING 127.0.0.1 > nul
    START http://10.93.106.%%a:8080/%core%/replication?command=fetchindex
	@PING 127.0.0.1 -n 180 > nul
    START http://10.93.106.%%a:8080/%core%/replication?command=fetchindex
	@PING 127.0.0.1 -n 600 > nul


	@ECHO  - Bring server online
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Cdelete%%3E%%3Cquery%%3E*:*%%3C/query%%3E%%3C/delete%%3E
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Ccommit/%%3E
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3cadd%%3e%%3cdoc%%3e%%3cfield+name%%3d%%22status%%22%%3eAll+OK%%3a+True%%3c%%2ffield%%3e%%3c%%2fdoc%%3e%%3c%%2fadd%%3e
	@PING 127.0.0.1 > nul
	START http://10.93.106.%%a:8080/solr/status/update?stream.body=%%3Ccommit/%%3E
	@PING 127.0.0.1 -n 180 > nul
)

@ECHO Start the solr data loader
@FOR /L %%H IN (0,1,9) DO @(
	@DEL C:\solr\remaxProcessors\thread%%H\PauseSolrDataLoader.txt
)

@ECHO.
@ECHO     OPTIMIZATION COMPLETE!

@ECHO.
@ECHO Next enable sheduled tasks
@ECHO.
@PING 127.0.0.1 -n 600 > nul

@schtasks /Change /RP D0n0tSt0p /TN checkErrors /ENABLE
@schtasks /Change /RP D0n0tSt0p /TN checkSolrDataLoader /ENABLE
@PING 127.0.0.1 > nul

