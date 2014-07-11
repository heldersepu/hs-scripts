@SET dFile="C:\Users\Dog\.googlemaps\markers"
@SET dExtra1= --min-zoom=0 --threads=1

@DEL temp.txt
@rem Split the items by =
FOR /F "usebackq eol=# tokens=3,4 delims==" %%i IN (%dFile%) DO @ECHO %%i %%j >> temp.txt

@rem Split by spaces and Tabs
FOR /L %%H IN (1,1,9) DO @(
    FOR /L %%G IN (1,1,9) DO @(
        FOR /F "tokens=1,3" %%i IN (temp.txt) DO @(
            download.exe --latitude=%%~i --longitude=%%~j --height=%%H --width=%%G %dExtra1%
            ping 127.0.0.1 > nul
        )
    )
)

@DEL temp.txt
@ECHO.
@ECHO All Done!
@pause
