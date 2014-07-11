@PROMPT $S
@CLS
@COLOR 0C
@ECHO.
@ECHO.
@ECHO THIS SCRIPT WILL DEPLOY XML'S TO THE DEPLOYMENT SERVERS!
@ECHO Are you sure you want to proceed?
@ECHO.
@PAUSE
@COLOR 0B
@CLS

@SET fldSource1=C:\SecretAgent\TOOLS\FailOverRegistryTool\FailOverRegistryTool2010\FailOverRegistryTool\FailOverRegistryTool\Config\Norfolk.xml

@SET fldDestin1=SecretAgent\TOOLS\FailOverRegistryTool\FailOverRegistryTool2010\FailOverRegistryTool\FailOverRegistryTool\Config\Norfolk.xml

@SET serverNames=NFDEPLOY01,NFDEPLOY02,NFDEPLOY03

@Echo Copying the files
@FOR %%a IN (%serverNames%) DO @(
    @ECHO %%a
    @ECHO.

    COPY /Y /Z %fldSource1%      \\%%a\c$\%fldDestin1%
  
    @PING 127.0.0.1 -n 10 > NUL

)

@ECHO.
@ECHO.
@PAUSE



