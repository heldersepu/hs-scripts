@COLOR 0F
@PROMPT $S

DEL /AH %userName%\AppData\Local\IconCache.db
DEL /AR %userName%\AppData\Local\IconCache.db
DEL %userName%\AppData\Local\IconCache.db

TASKKILL /F /IM explorer.exe
@PING 127.0.0.1 > NUL
explorer.exe