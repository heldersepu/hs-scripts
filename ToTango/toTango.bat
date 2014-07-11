@PROMPT $S
@ECHO.
@SET AUTH_TOKEN="Authorization: 294281578d23199c82023f20a57293e93bfce260"

:: Listing accounts in an active-list
curl -H %AUTH_TOKEN% https://app.totango.com/api/v1/accounts/active_list/1/current.json
@ECHO.

:: Retrieve engagement statistics for accounts in an active-list
curl -H %AUTH_TOKEN% https://app.totango.com/api/v1/accounts/active_list/1/current.json?return=stats
@ECHO.

:: Retrieve users from accounts in an active-list
curl -H %AUTH_TOKEN% https://app.totango.com/api/v1/accounts/active_list/1/current.json?return=users
@ECHO.

:: Retrieve status lifecycle history for accounts in an active-list
curl -H %AUTH_TOKEN% https://app.totango.com/api/v1/accounts/active_list/1/current.json?return=lifecycle
@ECHO.



:: Getting recent changes to an active-list
:: TIME-STAMP must be in unix-time format
curl -H %AUTH_TOKEN% https://app.totango.com/api/v1/accounts/active_list/1/recent.json?since=1356912000
@ECHO.
curl -H %AUTH_TOKEN% https://app.totango.com/api/v1/accounts/active_list/1/past.json?since=1356912000
@ECHO.

@ECHO.
@ECHO.
@PAUSE