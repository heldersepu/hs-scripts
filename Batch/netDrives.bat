IF NOT EXIST R: NET USE R: \\qqstore02.prod.qq\webimages\images Rh22515 /user:prod\ihammes
@NET USE /PERSISTENT:YES

IF NOT EXIST S: NET USE S: \\10.0.20.47\UploadShar
@NET USE /PERSISTENT:YES

@ECHO.
@PAUSE
