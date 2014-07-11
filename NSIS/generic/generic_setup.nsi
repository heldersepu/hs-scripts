!define PRODUCT_NAME "ProdName"
!define PRODUCT_VERSION "1.3.1.0"
!define PRODUCT_WEB_SITE "http://www.sepuweb.com/"
!define PRODUCT_PUBLISHER "sepuweb"

!include nsDialogs.nsh

; The name of the installer
Name "${PRODUCT_NAME}"
Icon "${PRODUCT_NAME}.ICO"

; The file to write
OutFile "${PRODUCT_NAME}-${PRODUCT_VERSION}.exe"

; Set the compression algorithm
SetCompressor /FINAL /SOLID lzma
SetCompressorDictSize 32

; The default installation directory
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"

; Registry key to check for directory (so if you install again, it will
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\${PRODUCT_NAME}" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------
;Version Information
VIProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "Comments" "${PRODUCT_NAME}"
VIAddVersionKey "LegalCopyright" "${PRODUCT_WEB_SITE}"
VIAddVersionKey "FileDescription" "${PRODUCT_NAME}"
VIAddVersionKey "FileVersion" "${PRODUCT_VERSION}"

;--------------------------------
; Pages
Page components
Page directory
Page instfiles
Page custom finalPage

UninstPage uninstConfirm
UninstPage instfiles

ShowInstDetails show
ShowUninstDetails show

Var CHECKBOX
Var boolCHECKBOX
Var Image
Var ImageHandle

;--------------------------------
; The final install page that asks to run the application
Function finalPage

	nsDialogs::Create 1018
	Pop $0
	${NSD_CreateLabel} 75u 30u 80% 8u "${PRODUCT_NAME} was succesfully installed on your computer."
	Pop $0
	${NSD_CreateCheckbox} 80u 50u 50% 8u "Run ${PRODUCT_NAME} v${PRODUCT_VERSION}"
	Pop $CHECKBOX
    SendMessage $CHECKBOX ${BM_SETCHECK} ${BST_CHECKED} 0
    GetFunctionAddress $1 OnCheckbox
	nsDialogs::OnClick $CHECKBOX $1

    ; Add an image
    ${NSD_CreateBitmap} 0 0 100% 40% ""
    Pop $Image
    ${NSD_SetImage} $Image "$INSTDIR\setup.bmp" $ImageHandle
	nsDialogs::Show
    ${NSD_freeImage} $ImageHandle

FunctionEnd
Function OnCheckbox
    SendMessage $CHECKBOX ${BM_GETSTATE} 0 0 $1
    ${If} $1 != 8
        StrCpy $boolCHECKBOX "True"
    ${Else}
        StrCpy $boolCHECKBOX "False"
    ${EndIf}
FunctionEnd
Function .onInstSuccess
	${If} $boolCHECKBOX != "False"
        Exec "$INSTDIR\${PRODUCT_NAME}.exe"
    ${EndIf}
FunctionEnd


;--------------------------------
; The stuff to install
Section "${PRODUCT_NAME} (required)"
    SetAutoClose true
    SectionIn RO
    SetOutPath $INSTDIR

    ; Put files here
    File "setup.bmp"
    File "Prod.exe"
    File "Prod.CONF"

    ; Write the installation path into the registry
    WriteRegStr HKLM "SOFTWARE\${PRODUCT_NAME}" "Install_Dir" "$INSTDIR"

    ; Write the uninstall keys for Windows
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UninstallString" '"$INSTDIR\uninstall.exe"'
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoModify" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoRepair" 1
    WriteUninstaller "uninstall.exe"    
SectionEnd

; Optional Shortcuts sections (can be disabled by the user)
Section "Start Menu Shortcuts"
    CreateDirectory "$SMPROGRAMS\${PRODUCT_PUBLISHER}\${PRODUCT_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_PUBLISHER}\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_NAME}.exe"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_PUBLISHER}\${PRODUCT_NAME}\Uninstall ${PRODUCT_NAME}.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

Section "Desktop Shortcut"
    CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_NAME}.exe"
SectionEnd

Section "Quick Launch Shortcut"
    CreateShortCut "$QUICKLAUNCH\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_NAME}.exe"
SectionEnd

;--------------------------------
; Uninstaller
Section "Uninstall"
    SetAutoClose true
    StrCpy $0 "${PRODUCT_NAME}.exe"

    ; Remove registry keys
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
    DeleteRegKey HKLM "SOFTWARE\${PRODUCT_NAME}"

    ; Remove directories used
    RMDir /r "$SMPROGRAMS\${PRODUCT_PUBLISHER}\${PRODUCT_NAME}"
    RMDir /r "$INSTDIR"

    ; Delete Shortcuts
    Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
    Delete "$QUICKLAUNCH\${PRODUCT_NAME}.lnk"
SectionEnd
