@SET TFDIR="%ProgramFiles(x86)%\Microsoft Visual Studio 11.0\Common7\IDE"
@IF NOT EXIST %TFDIR% SET TFDIR="%ProgramFiles%\Microsoft Visual Studio 11.0\Common7\IDE"
@IF NOT EXIST %TFDIR% SET TFDIR="C:\TFS"
@SET PATH=%PATH%;%TFDIR%
@CD %TFDIR%

@CALL TF workspaces
@ECHO.&ECHO.&ECHO.

iisreset /stop

:HMS_Server
@COLOR 0F
CALL TF GET C:\SecretAgent\TOOLS\Build  /force
::CALL TF GET C:\SecretAgent\WWWRoot /recursive


CALL TF GET C:\SecretAgent\wwwroot\BlueHomes360                             /recursive  /force
CALL TF GET C:\SecretAgent\wwwroot\BlueHomes360-Features                    /recursive  /force

CALL TF GET C:\SecretAgent\wwwroot\BlueHomes360Mobile                       /recursive  /force
CALL TF GET C:\SecretAgent\wwwroot\BlueHomes360Mobile-Features              /recursive  /force

CALL TF GET C:\SecretAgent\wwwroot\IncludeDirectories\Client                /recursive  /force
CALL TF GET C:\SecretAgent\wwwroot\IncludeDirectories\Client-Features       /recursive  /force

CALL TF GET C:\SecretAgent\wwwroot\IncludeDirectories\Client2               /recursive  /force
CALL TF GET C:\SecretAgent\wwwroot\IncludeDirectories\Client2-Features      /recursive  /force

CALL TF GET C:\SecretAgent\WWWRoot\IncludeDirectories\MasterSite            /recursive  /force
CALL TF GET C:\SecretAgent\WWWRoot\IncludeDirectories\MasterSite-Features   /recursive  /force

CALL TF GET C:\SecretAgent\WWWRoot\rciNETComponents                         /recursive  /force
CALL TF GET C:\SecretAgent\WWWRoot\rciNETComponents-Features                /recursive  /force

CALL TF GET C:\SecretAgent\WWWRoot\rciNETComponents2010                     /recursive  /force
CALL TF GET C:\SecretAgent\WWWRoot\rciNETComponents2010-Features            /recursive  /force

CALL TF GET C:\SecretAgent\WWWRoot\UIProjects2010                           /recursive  /force
CALL TF GET C:\SecretAgent\WWWRoot\UIProjects2010-Features                  /recursive  /force

CALL TF GET C:\SecretAgent\WWWRoot\UIProjects2012                           /recursive  /force
CALL TF GET C:\SecretAgent\WWWRoot\UIProjects2012-Features                  /recursive  /force

CALL TF GET C:\SecretAgent\WWWRoot\HmsComponents2012                        /recursive  /force
CALL TF GET C:\SecretAgent\WWWRoot\HmsComponents2012-Features               /recursive  /force


@COLOR 0A

iisreset /start

