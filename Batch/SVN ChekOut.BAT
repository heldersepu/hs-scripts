@ECHO OFF 
::Tortoise executable
@SET TSVN="C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe"

::Create a BackUp folder
IF NOT EXIST C:\BackUp\NUL MD C:\BackUp

::TX Engine
IF EXIST C:\qqtxeng\NUL MOVE C:\qqtxeng C:\BackUp
%TSVN% /command:checkout /url:svn://AppSrvA/svn/texas/nextbeta/qqtxeng /path:C:\qqtxeng /notempfile /closeonend:2
::TX Sources
IF EXIST C:\quick95\NUL MOVE C:\quick95 C:\BackUp
%TSVN% /command:checkout /url:svn://AppSrvA/svn/texas/nextbeta/quick95 /path:C:\quick95 /notempfile /closeonend:2

::FL Engine
IF EXIST C:\qqfleng\NUL MOVE C:\qqfleng C:\BackUp
%TSVN% /command:checkout /url:svn://AppSrvA/svn/Florida/nextbeta/qqfleng /path:C:\qqfleng /notempfile /closeonend:2
::FL Sources
IF EXIST C:\newqq95\NUL MOVE C:\newqq95 C:\BackUp
%TSVN% /command:checkout /url:svn://AppSrvA/svn/Florida/nextbeta/newqq95 /path:C:\newqq95 /notempfile /closeonend:2

::GA Engine
IF EXIST C:\qqenginems\NUL MOVE C:\qqenginems C:\BackUp
%TSVN% /command:checkout /url:svn://AppSrvA/svn/Georgia/nextregular/qqenginems /path:C:\qqenginems /notempfile /closeonend:2
::GA Sources
IF EXIST C:\newqqga\NUL MOVE C:\newqqga C:\BackUp
%TSVN% /command:checkout /url:svn://AppSrvA/svn/Georgia/nextregular/newqqga /path:C:\newqqga /notempfile /closeonend:2

