@COLOR 0F
@PROMPT $S
@SET TFDIR="%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\Common7\IDE"
@IF NOT EXIST %TFDIR% SET TFDIR="%ProgramFiles%\Microsoft Visual Studio 14.0\Common7\IDE"
@SET PATH=%PATH%;%TFDIR%
@CD C:\SecretAgent

TF workspaces /collection:http://hmstfs01:8080/tfs/HMS_Server
TF workspace /new /collection:http://hmstfs01:8080/tfs/HMS_Server /noprompt
TF workfold /map $/SecretAgent/SecretAgent C:\SecretAgent

TF GET C:\SecretAgent\wwwroot\rciNETComponents2010\eNCore /overwrite /recursive
TF GET C:\SecretAgent\wwwroot\rciNETComponents2010\eNControls /overwrite /recursive
TF GET C:\SecretAgent\wwwroot\UIProjects2010\UILeads /overwrite /recursive
TF GET C:\SecretAgent\wwwroot\UIProjects2010\UISystem /overwrite /recursive
TF GET C:\SecretAgent\wwwroot\UIProjects2010\UIAgentTools /overwrite /recursive
TF GET C:\SecretAgent\wwwroot\UIProjects2010\UIAutoProcessing /overwrite /recursive

@COLOR 0A
@ECHO.
@ECHO.
@PAUSE
