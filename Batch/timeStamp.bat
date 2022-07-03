@ECHO OFF

@SET dLogFile="c:\log.txt"

ECHO This is a sample log file. >  %dLogFile%
DIR "H:\QUICK95\ALLCOMP"        >> %dLogFile%
DIR "C:\Documents and Settings" >> %dLogFile%
DIR "C:\QUICK95\ALLCOMP"        >> %dLogFile%
DATE /t >> %dLogFile%
TIME /t >> %dLogFile%
pause
