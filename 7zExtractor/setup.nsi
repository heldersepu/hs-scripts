# This script creates an extractor for split 7z archives
# just rename the 7z-eXtract.exe to match your *.7z.001 files

!define FILE_NAME "7z-eXtract"
Name "${FILE_NAME}"

SetCompressor /FINAL /SOLID lzma
SetCompressorDictSize 64
OutFile "${FILE_NAME}.exe"
InstallDir "."

Function .onInit
    SetSilent silent
FunctionEnd

Section -Main SEC0000
    SetOutPath $INSTDIR
    SetOverwrite on
    File "7-zip.dll"
    File "7z.dll"
    File "7zG.exe"
SectionEnd

Function .onInstSuccess
    StrCpy $0 $EXEFILE -4
    ExecWait "7zg.exe x $0.7z.001"
    Delete "7-zip.dll"
    Delete "7z.dll"
    Delete "7zG.exe"
FunctionEnd
