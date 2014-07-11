:: Move a given file to a subFolder=right(file,6)
@SET strFile=%1
@SET strFile=%strFile:"=%
@SET strFolder=%2
@SET strFolder=%strFolder:"=%

@SET strExt=%strFile:~-3%
@SET subFld=%strFile:~-6%
@SET subFld=%subFld:\=%
@SET strFolder=%strFolder%\%strExt%\%subFld%

@IF NOT EXIST %strFolder% MD %strFolder%
@MOVE "%strFile%" %strFolder% > NUL
