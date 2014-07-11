;NSIS Modern User Interface version 1.70
; $Id: badrive.nsi 2429 2011-07-25 19:15:54Z wini $
;--------------------------------
;
;  This is install script for badrive , both demo and release versions
;
;--------------------------------

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------


  !define MUI_ICON bdinst32.ico
  !define MUI_UNICON bduninst32.ico
;  !define MUI_CUSTOMFUNCTION_GUIINIT myGUIinit
;  !define MUI_CUSTOMFUNCTION_ABORT deldll



;svn export svn://svn.sharkssl.com/BarracudaDrive/applications/trunk/setup applications/setup

;  SetCompressor zlib  ;lzma bzip2 or zlib
  SetCompressor lzma  ;lzma bzip2 or zlib
  ShowInstDetails show
  ShowUninstDetails show
  XPStyle on
  CRCCheck force

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

!define FVER  "4.4.7.0"


!define SREGKEY  "Software\realtimelogic"
!ifdef DEMO
!define BDDIR  "bddemo"
!else
!define BDDIR  "badrive"
!endif
!echo ${SREGKEY}
!echo "${__FILE__} ${__LINE__} ${__TIMESTAMP__}"


;				!define INSTALLCOMPANY
;				!define INSTALLKEY
;				!define INSTALLNUMBER
;				!define INSTALLDATE


!define SWP_NOSIZE          0x0001
!define SWP_NOMOVE          0x0002
!define SWP_NOZORDER        0x0004
!define SWP_NOREDRAW        0x0008
!define SWP_NOACTIVATE      0x0010


;
;--------------------------------
;General
;--------------------------------

  ;Name and file
  !ifdef DEMO
    !define NAME "BarracudaDrive Demonstration"
    Name ${NAME}
    OutFile "bddemoinstall.exe"
  !else
    !define NAME "BarracudaDrive"
    Name ${NAME}
    !ifdef VISTA
      OutFile "bdinstall_vista.exe"
    !else
      OutFile "bdinstall.exe"
    !endif
  !endif

;--------------------------------


ReserveFile "bdinst.dll"
ReserveFile "msvcr71.dll"
ReserveFile "badrive\readme.txt"
ReserveFile "badrive\install.txt"
ReserveFile "stop.ico"



  var DOFW          ; bool - we installed the firewall hack
  var DOSKYPE       ; bool - skype is running
  var HPORT
  var SPORT
  var TRYPORT
  var REINSTALL


!include winver.nsh

Function .onInit
;  MessageBox MB_OK $R0
;  MessageBox MB_OK $INSTDIR

;  Call GetWindowsVersion
;  Pop $R0


!ifdef zzOSTEST
!ifndef VISTA
  StrCmp $R0 'Vista' jnak
!else
  StrCmp $R0 'Vista' jok
!endif
jnak:
  IfSilent +2
  MessageBox MB_OK|MB_USERICON "The detected operating system (Windows $R0) is not$\r$\nsupported for this application."
  Quit

jok:
!endif

  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "bdinstaller") i .r1 ?e'
  Pop $R0

;    MessageBox MB_OK|MB_ICONEXCLAMATION "The installer is already running."
  StrCmp $R0 0 +2
  Abort

  ;initialize
  Push 0
  Pop $DOFW

  Push ${BST_UNCHECKED}
  Pop $TRYPORT

  Push 80
  Pop $HPORT
  Push 443
  Pop $SPORT

  ; default to skype not running
  Push 0
  Pop $DOSKYPE


!echo "reading HKLM ${SREGKEY}\Directory"
  ReadRegStr $0 HKLM "${SREGKEY}\Directory" ""
  StrCmp $0 "" 0 +3
  StrCpy $R0 $SYSDIR 2
  StrCpy $INSTDIR "$R0\bd"
;  MessageBox MB_OK $INSTDIR

  SetShellVarContext all ;current

  File /oname=$PLUGINSDIR\bdinst.dll "bdinst.dll"
  File /oname=$PLUGINSDIR\msvcr71.dll "msvcr71.dll"
  File /oname=$PLUGINSDIR\readme.txt "badrive\readme.txt"
  File /oname=$PLUGINSDIR\install.txt "badrive\install.txt"
  File /oname=$PLUGINSDIR\stop.ico "stop.ico"

  ClearErrors
  IfFileExists "$INSTDIR\user.dat" +4 +1
  Push 0
  Pop $REINSTALL
  Goto +3
  Push 1
  Pop $REINSTALL



FunctionEnd  ; .oninit




; called when Abort is called or cancel button or errors
Function .onInstFailed
  MessageBox MB_OK|MB_USERICON \
      "called from .onInstFailed"
FunctionEnd

; called when the GUI ends
Function .onGUIEnd
  call cleanup
FunctionEnd

Function cleanup
  Delete /REBOOTOK "$PLUGINSDIR\bdinst.dll"
  Delete /REBOOTOK "$PLUGINSDIR\msvcr71.dll"
  Delete "$PLUGINSDIR\readme.txt"
  Delete "$PLUGINSDIR\install.txt"
  Delete "$PLUGINSDIR\stop.ico"
  RMDir /REBOOTOK "$PLUGINSDIR"
  ClearErrors

FunctionEnd


;  MessageBox MB_OK $MPATH
;  InstallDir "$PROGRAMFILES\bd"
  InstallDir "$INSTDIR"

;--------------------------------
;Special
;--------------------------------

  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "${SREGKEY}\directory" ""


;--------------------------------
;Variables

  Var MUI_TEMP
  Var STARTMENU_FOLDER

;--------------------------------
;Interface Settings

  !define MUI_FINISHPAGE_NOAUTOCLOSE
  !define MUI_UNFINISHPAGE_NOAUTOCLOSE
  !define MUI_ABORTWARNING

;  !define MUI_INSTFILESPAGE_COLORS "FFFFFF 000000"

;--------------------------------
;Pages


  !define MUI_WELCOMEPAGE_TEXT \
  "This wizard will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close all other applications before starting Setup. This will make it possible to update relevant system files without having to restart your computer.$\r$\n$\r$\n\
   It is important that all other web servers (including BarracudaDrive) and messaging clients (such as Skype) are stopped before installing  BarracudaDrive.\
   $\r$\n"

  !define MUI_PAGE_CUSTOMFUNCTION_SHOW welcome_show
  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE CheckExe

;  !define MUI_WELCOMEFINISHPAGE_CUSTOMFUNCTION_INIT onfinish

  !insertmacro MUI_PAGE_WELCOME

  !insertmacro MUI_PAGE_LICENSE "${BDDIR}\license.rtf"

  Page custom PortTestPage PortTestPage.leave    ; the Port Test page

;  !insertmacro MUI_PAGE_COMPONENTS


  !insertmacro MUI_PAGE_DIRECTORY


  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_DEFAULTFOLDER "BarracudaDrive"

  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM"
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "${SREGKEY}"
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

  !define MUI_FINISHPAGE_TITLE "Setup Wizard Completion"
;  !define MUI_FINISHPAGE_TEXT "BarracudaDrive has been installed on your computer\r\n\r\nClick Finish to close the wizard."
;  !define MUI_FINISHPAGE_TEXT_REBOOT "Restarting after an install is recommended."

  !define MUI_FINISHPAGE_LINK "http://barracudaserver.com/"
  !define MUI_FINISHPAGE_LINK_LOCATION "http://barracudaserver.com/products/"

  !define MUI_FINISHPAGE_SHOWREADME_CHECKED
  !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\readme.txt"
  !define MUI_FINISHPAGE_SHOWREADME_TEXT "View the readme.txt file"

;  !define MUI_FINISHPAGE_RUN "$INSTDIR\bdctl.exe"
;  !define MUI_FINISHPAGE_RUN_TEXT "Run the Barracuda task bar control"

;  !define MUI_FINISHPAGE_RUN_PARAMETERS "${INSTALLCOMPANY} ${INSTALLNUMBER} ${INSTALLKEY}"

  !insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER


  !insertmacro MUI_PAGE_INSTFILES

  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE onfinish
  !insertmacro MUI_PAGE_FINISH


  !define MUI_UNCONFIRMPAGE_TEXT_TOP \
  "BarracudaDrive will removed from your computer, INCLUDING ANY FILES THAT YOU HAVE CREATED. \
   Backup any files that you want to keep. $\r$\n\
   Click Uninstall to continue"
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !define MUI_FINISHPAGE_REBOOTLATER_DEFAULT
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Version Information

  VIProductVersion "${FVER}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${FVER}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${NAME}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "Install of ${NAME}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "Real Time Logic"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "Copyright (C) Real Time Logic 2006-2009. All rights reserved."
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "${NAME} Install"

;--------------------------------
;Installer Sections

!macro mkshtcut nm pg
!ifndef DELETEMODE
CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\${nm}.lnk" "$INSTDIR\${pg}" "" "" "" "" "" "${nm}"
!else
Delete "$MUI_TEMP\${nm}.lnk" ; ${pg}
!endif
!macroend


Section "" Sec1

    SetShellVarContext all ;current

    SetOutPath "$INSTDIR"


    SetOverwrite on
    ;  SetOverwrite try

    ;  SetDetailsPrint none
    SetDetailsPrint both

    ; =========================================================================
    ; =========================================================================
    ; =========================================================================
    ; THE LIST OF FILES THAT WE USE
    ; =========================================================================
    ; =========================================================================
    ; =========================================================================


    File /a ${BDDIR}\*.*
    !ifdef VISTA
        File /x ${BDDIR}\bd.exe
        File /x ${BDDIR}\bdctl.exe
        File /a ${BDDIR}\vista\bd.exe
        File /a ${BDDIR}\vista\bdctl.exe
    !endif

    SetOutPath "$INSTDIR\applications"
    IntCmp $REINSTALL 1 +2
    File /a "${BDDIR}\applications\setup.zip"
    File /a "${BDDIR}\applications\setup.zip"
    File /a "${BDDIR}\applications\forum.zip"
    File /a "${BDDIR}\applications\cms.zip"
    ClearErrors

    SetOutPath "$INSTDIR\data"
    SetOverwrite off
    File /a "${BDDIR}\data\cms.sqlite.db"
    File /a "${BDDIR}\data\forum.sqlite.db"
    SetOverwrite on
    ClearErrors

    SetOutPath "$INSTDIR\cmsdocs"
    SetOverwrite off
    File /a /r "${BDDIR}\cmsdocs\*.*"
    SetOverwrite on
    ClearErrors

    SetOutPath "$INSTDIR\themes"
    File /a "${BDDIR}\themes\*.*"
    ClearErrors


    SetOutPath "$INSTDIR"


    Delete "$INSTDIR\badrive.exe"  ;legacy
    ClearErrors

    ; =========================================================================
    ; =========================================================================

    IntCmp $DOFW 0 +5
    SimpleFC::AddApplication "bdctl" "$INSTDIR\bdctl.exe" 0 2 "" 1
    Pop $0 ; return error(1)/success(0)
    SimpleFC::AddApplication "bd" "$INSTDIR\bd.exe" 0 2 "" 1
    Pop $0 ; return error(1)/success(0)

    ; =========================================================================
    ; =========================================================================

    ;Store installation folder
    ClearErrors
    ; SHCTX?
    WriteRegStr HKLM "${SREGKEY}\Directory" "" $INSTDIR
    IfErrors 0 +2
    DetailPrint "Directory registry write failed..."

    ;Setup LUA_PATH
    ;  ReadRegStr $0 HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "LUA_PATHx"
    ;  StrCmp $0 "" 0 +4
    ;  WriteRegStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
    ;    "LUA_PATH" "?.lua;?.lc;$INSTDIR\lua\?.lua;$INSTDIR\lua\?.lc;?"
    ;  DetailPrint "Environment variable LUA_PATH created"
    ;  GoTo +2
    ;  DetailPrint "Environment variable LUA_PATH is $0"

    ;  RegDLL $INSTDIR\pclocx.dll

    ;	nsExec::ExecToLog '"$INSTDIR\bd" -remove'
    ;	Pop $0 # return value/error/timeout

    ClearErrors

    ;Create uninstaller
    WriteUninstaller "$INSTDIR\Uninstall.exe"

    DetailPrint "Creating shortcuts in $SMPROGRAMS\$STARTMENU_FOLDER"
    SetDetailsPrint none

    ;-----
    ;-----Create shortcuts
    ;-----
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"

    !insertmacro mkshtcut "BarracudaDrive" "bdctl.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Install Service (Automatic Start).lnk" "%comspec%" \
    "/K bd -remove & bd -installauto" \
    "" "" "" "" "Installs the BarracudaDrive service. The service is automatically started when you restart."

    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Install Service (Manual Start).lnk" "%comspec%" \
    "/K bd -remove & bd -install" \
    "" "" "" "" "Installs the BarracudaDrive service. The service needs to be manually started."

    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Remove Service.lnk" "%comspec%" \
    "/K bd -remove" \
    "" "" "" "" "Remove the BarracudaDrive service."

    ;      http://barracudaserver.com/products/BarracudaDrive/ {index.html}
    ;      http://barracudaserver.com/products/support/
    ;      http://barracudaserver.com/products/BarracudaDrive/doc/

    !insertmacro mkshtcut "Readme" "readme.txt"
    !insertmacro mkshtcut "BarracudaDrive  License" "license.rtf"
    !insertmacro mkshtcut "Uninstall BarracudaDrive" "Uninstall.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\BarracudaDrive Directory.lnk" "$INSTDIR\" \
    "" "" "" "" "" "Open an Explorer window of the BarracudaDrive directory"
    !insertmacro MUI_STARTMENU_WRITE_END
    ;-----
    ;-----end Create shortcuts
    ;-----
    WriteINIStr "$SMPROGRAMS\$STARTMENU_FOLDER\Web Site.url" "InternetShortcut" "URL" "http://barracudaserver.com/products/BarracudaDrive/"
    WriteINIStr "$SMPROGRAMS\$STARTMENU_FOLDER\Support Page.url" "InternetShortcut" "URL" "http://barracudaserver.com/products/BarracudaDrive/support/"

    WriteINIStr "$SMPROGRAMS\$STARTMENU_FOLDER\BarracudaDrive Documentation.url" "InternetShortcut" "URL" "http://barracudaserver.com/products/BarracudaDrive/doc/"
    !ifdef DEMO
        WriteINIStr "$SMPROGRAMS\$STARTMENU_FOLDER\Order licenses.url" "InternetShortcut" "URL" "https://www.spinifex.net/barracuda/bdorder.html"
    !endif

    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\badrive" ;legacy
    DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "badrive" ;legacy

    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bd" \
    "DisplayName" "BarracudaDrive"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bd" \
    "UninstallString" '"$INSTDIR\Uninstall.exe"'
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bd" \
    "Publisher" "Real Time Logic"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bd" \
    "HelpLink" "http://barracudaserver.com/products/BarracudaDrive/support/"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" \
    "bdctl" '"$INSTDIR\bdctl.exe"'

    Delete "$PLUGINSDIR\bdinst.dll"
    Delete "$PLUGINSDIR\readme.txt"

    SetDetailsPrint both
    DetailPrint "Shortcuts created"
    ClearErrors


    ;-------------------------------
    ;--- Setup the service start ---
    ;-------------------------------

    DetailPrint "Installing automatic service startup"
    nsExec::ExecToStack /TIMEOUT=4000 '"$INSTDIR\bd" -installauto'
    Pop $0 # return value/error/timeout
    IntCmp $0 0 instok
    ;	Pop $0 # string
    Push "already exists"
    Call StrStr
    Pop $R0
    StrCpy $0 "$R0" -3
    ;	DetailPrint "  Return value: $0"
    StrCmp $0 "already exists" 0 instok
    nsExec::ExecToLog '"$INSTDIR\bd" -start'
    ;	nsExec::ExecToLog '"$INSTDIR\bd" -installauto'

    Pop $0 # return value/error/timeout
    instok:

    ClearErrors
    ; restart skype
    StrLen $0 $DOSKYPE
    IntCmp $0 1 +2 +2 0
    Exec '"$DOSKYPE"'
    ClearErrors

    ;--------------------------------
    ;--- Invoke the task bar icon ---
    ;--------------------------------

    ExecShell "open" '"$INSTDIR\bdctl"'

    ;  nsExec::ExecToLog 'attrib "$INSTDIR\*.*" /S /D'
    ;  SetFileAttributes '"$INSTDIR"' 0


    ;-----------------------------------
    ;--- Double check that all is OK ---
    ;-----------------------------------

    Push 1
    Pop  $9

    nsExec::ExecToStack /TIMEOUT=2000 '"$INSTDIR\bd" -state'
    Pop $0 # return value/error/timeout
    Pop $0 # string
    ;  MessageBox MB_OK|MB_USERICON  "$0"
    StrCpy $1 "$0" 10 # bd running
    StrCmp $1 "bd running" +3
    Push 0
    Pop  $9

    ClearErrors

    call notifybd2

    ClearErrors

    DetailPrint "Appending port data to bd.conf"
    FileOpen $0 $INSTDIR\bd.conf a
    IfErrors +5
    FileSeek $0 0 END
    ClearErrors
    FileWrite $0 "port=$HPORT$\r$\nsslport=$SPORT$\r$\ntryports=$TRYPORT$\r$\n"
    FileClose $0

    ClearErrors

SectionEnd

!ifdef zzDELETE
Section "" Sec2
SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_Sec1 ${LANG_ENGLISH} "Install files."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Sec1} $(DESC_Sec1)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
!endif




; modify the welcome screen
; 300 dialogs units wide and 140 high for MUI2
Function welcome_show

  ; mui.WelcomePage  is the HWND

  ; ${NSD_CreateLabel} x y width height text
  Push $4
  Push $2
  Push $1
  Push $0


	${NSD_CreateLink} 120u -44u 100% 8u "View INSTALL Notes"
	Pop $1
	SetCtlColors $1 0x00008F transparent
  System::Call "User32::SetWindowPos(i, i, i, i, i, i, i) i ($1, 0, 0, 0, 0, 0, ${SWP_NOSIZE}|${SWP_NOMOVE})"
  ${NSD_OnClick} $1 onClickInstallNotes
  ${NSD_CreateLabel} 120u -20u 100% 8u "$_Click"
	Pop $0
  SetCtlColors $0 0x000000 transparent
  System::Call "User32::SetWindowPos(i, i, i, i, i, i, i) i ($0, 0, 0, 0, 0, 0, ${SWP_NOSIZE}|${SWP_NOMOVE})"

  Pop $0
  Pop $1
  Pop $2
  Pop $4

FunctionEnd


Function onClickInstallNotes
  Pop $0 ; don't forget to pop HWND of the stack
  ExecShell "open" "$PLUGINSDIR\install.txt"
;  ExecShell "open" "${NSISDIR}\Docs\Modern UI\License.txt"
;  ExecWait 'notepad "${NSISDIR}\Docs\Modern UI\License.txt"'
;  ExecWait 'notepad "$PLUGINSDIR\install.txt"'
FunctionEnd



Function CheckSkype
;  see if skype is running and if so present check box to restart it
  System::Call '$PLUGINSDIR\bdinst::chksk() i() .r1 ? c'
  IntCmp $1 1 0 skipkill skipkill
    MessageBox MB_OKCANCEL|MB_USERICON 'We have detected Skype.$\r$\nSkype prevents the BarracudaDrive installation.$\r$\nIs it OK if we restart Skype during this install?' \
        /SD IDOK IDCANCEL skipkill
;   kill skype
    System::Call "$PLUGINSDIR\bdinst::killsk(t .r0, i ${NSIS_MAX_STRLEN}) i.r2 ? c"
    Push $0
    Pop $DOSKYPE

skipkill:

FunctionEnd



Function PortTestPage       ; the Port Test page
	var /GLOBAL HW_PORT
	var /GLOBAL HW_PORT.HTTP
	var /GLOBAL HW_PORT.HTTPS
	var /GLOBAL HW_PORT.TRYPORT

  Push $5

  call firewall_fix   ; works around windows firewall

  Push 0
  Pop $5     ; use $5 to indicate not ok


  System::Call '$PLUGINSDIR\bdinst::chkports() i() .r0 ? c'
  IntCmp $0 0  portsok

  Call CheckSkype
  ; IntCmp $DOSKYPE 0 +4
  Sleep 2000        ; so the following test works
  System::Call '$PLUGINSDIR\bdinst::chkports() i() .r0 ? c'
  IntCmp $0 0  portsok

  Push 1
  Pop $5     ; use $5 to indicate not ok

portsok:

  !insertmacro MUI_HEADER_TEXT "BarracudaDrive Port Test" \
  "Testing of TCP/IP Ports 80 and 443"

  nsDialogs::Create /NOUNLOAD 1018
	Pop $HW_PORT

  IntCmp $5 1 +4
  ${NSD_CreateLabel} 0u 0u 100% 30u "The tests indicate that the both default ports are available for use. This means that BarracudaDrive should start successfully. Click Next to continue."
	Pop $0
  GoTo portsnowarn
  ${NSD_CreateIcon} 0u 0u 20u 21u "stop.ico"
	Pop $1
  StrCpy $0 "$PLUGINSDIR\stop.ico"
	System::Call 'user32::LoadImage(i 0, t r0, i ${IMAGE_ICON}, i 0, i 0, i ${LR_LOADFROMFILE}) i.s'
	Pop $2
	SendMessage $1 ${STM_SETIMAGE} ${IMAGE_ICON} $2

  ${NSD_CreateLabel} 29u 0u -29u 40u "WARNING!! The tests indicate that one or both default server ports are in use. BarracudaDrive will not start unless you change these ports or stop the applications that are using these ports. If you are unsure of what to do, then click Next to continue completing the installation. When finished, restart the computer and open http://localhost/ to test if the server is working."
	Pop $0
  SetCtlColors $0L 0xAF0000 transparent

portsnowarn:

  ${NSD_CreateLabel}  0u 45u 42u 8u "Server Ports"
	Pop $0
  ${NSD_CreateNumber} 48u 43u 30u 12u $HPORT
	Pop $HW_PORT.HTTP
  ${NSD_SetText} $HW_PORT.HTTP "$HPORT"
  ${NSD_CreateNumber} 87u 43u 31u 12u $SPORT
	Pop $HW_PORT.HTTPS
  ${NSD_SetText} $HW_PORT.HTTPS "$SPORT"

  ${NSD_CreateCheckBox} 0u 65u 260u 10u "Try alternate ports, if a port is already in use (experts only)."
	Pop $HW_PORT.TRYPORT
  ${NSD_SetState} $HW_PORT.TRYPORT $TRYPORT

  ${NSD_CreateLink} 200u 45u -1u 8u "View INSTALL Notes"
	Pop $0
  ${NSD_AddStyle} $0 ${WS_TABSTOP}
	SetCtlColors $0 0x00008F transparent
  ${NSD_OnClick} $0 onClickInstallNotes

  ${NSD_SetFocus} $mui.Button.Next



  ${NSD_CreateHLINE} 0u 75u 100% 2u ""
	Pop $0

  IntCmp $5 1 +5
  ${NSD_CreateLabel}  0u 84u 100% -1u "You can change these ports after installation by modifying the BarracudaDrive configuration file (bd.conf).$\r$\nIf you press Back and then Next you can repeat the Port Test.$\r$\n$\r$\nIf you are unsure of what to do, then $_Click."
	Pop $0
  DetailPrint "Ports 80 and 443 are available"
  GoTo +4
  ${NSD_CreateLabel}  0u 94u 100% -1u "You can continue installing BarracudaDrive and change these ports after installation by modifying the BarracudaDrive configuration file (bd.conf). If you prefer you can cancel the install and disable the application that is using these ports and then try the install again.$\r$\nIf you press Back and then Next you can repeat the Port Test."
	Pop $0
  SetCtlColors $0 0x00008F transparent

  nsDialogs::Show

  Pop $5

FunctionEnd ;  PortTestPage

Function PortTestPage.leave       ; the Port Test page called only on next

  ${NSD_GetText}  $HW_PORT.HTTP $HPORT
  ${NSD_GetText}  $HW_PORT.HTTPS $SPORT
	${NSD_GetState} $HW_PORT.TRYPORT $TRYPORT

FunctionEnd

Function firewall_fix   ; works around windows firewall

  Push 0
  Pop $DOFW

; before we test anything lets get the windows firewall out of the way

  SimpleFC::IsFirewallServiceRunning
  Pop $0 ; return error(1)/success(0)
  IntCmp $0 1 fwdone
  Pop $1 ; return 1=IsRunning/0=Not Running
  IntCmp $1 0 fwdone

; Check if the firewall is enabled
;  MessageBox MB_OK|MB_USERICON "Testing if installed"
  SimpleFC::IsFirewallEnabled
  Pop $0 ; return error(1)/success(0)
  IntCmp $0 1 fwdone
  IntCmp $0 1 fwerr
  Pop $1 ; return 1=Enabled/0=Disabled
  IntCmp $1 0 fwdone

  ; Check if the application is added to the firewall exception list
;  MessageBox MB_OK|MB_USERICON "Testing if added"
  SimpleFC::IsApplicationAdded "$INSTDIR\bd.exe"
  Pop $0 ; return error(1)/success(0)
  IntCmp $0 1 fwerr
  Pop $1 ; return 1=Added/0=Not added
  IntCmp $1 1 fwdone

  System::Call 'kernel32::GetModuleFileNameA(i 0, t .R0, i 1024) i r1'  ;$R0 will contain the installer filename
;  MessageBox MB_OK|MB_USERICON "adding $R0"
; Add an application to the firewall exception list - All Networks - All IP Version - Enabled
  SimpleFC::AddApplication "bdinstall" "$R0" 0 2 "" 1
  Pop $0 ; return error(1)/success(0)
  IntCmp $0 1 fwdone
  Push 1
  Pop $DOFW
  Goto fwdone

fwerr:
  IfSilent +2
  MessageBox MB_OK|MB_USERICON "Windows Firewall configuration failed."
  Quit

fwdone:
  ;MessageBox MB_OK|MB_USERICON "Windows Firewall configuration OK."
FunctionEnd


Function un.fireall_fix

  SimpleFC::IsFirewallServiceRunning
  Pop $0 ; return error(1)/success(0)
  IntCmp $0 0 +1 fwdone fwdone
  Pop $1 ; return 1=IsRunning/0=Not Running
  IntCmp $1 0 fwdone

; Check if the firewall is enabled
  SimpleFC::IsFirewallEnabled
  Pop $0 ; return error(1)/success(0)
  IntCmp $0 1 fwerr
  Pop $1 ; return 1=Enabled/0=Disabled
  IntCmp $1 0 fwdone

; Remove an application from the firewall exception list
  System::Call 'kernel32::GetModuleFileNameA(i 0, t .R0, i 1024) i r1'  ;$R0 will contain the installer filename
  SimpleFC::RemoveApplication "$R0"
  Pop $0 ; return error(1)/success(0)
  SimpleFC::RemoveApplication "$INSTDIR\bd.exe"
  Pop $0 ; return error(1)/success(0)
  SimpleFC::RemoveApplication "$INSTDIR\bdctl.exe"
  Pop $0 ; return error(1)/success(0)
fwerr:
fwdone:
;  MessageBox MB_OK|MB_USERICON "Windows Firewall configuration removed OK."

FunctionEnd


Function notifybd1
;  IntCmp $5 1 +4
;  System::Call '$PLUGINSDIR\bdinst::chkbd(i 0) i .r0 ? c'
;  Push 1
;  Pop $5
;  Return
FunctionEnd

Function notifybd2
;  IntCmp $6 1 +4
;  System::Call '$PLUGINSDIR\bdinst::chkbd(i 1) i .r0 ? c'
;  Push 1
;  Pop $6
;  Return
FunctionEnd

Function un.notifybd3
;  IntCmp $7 1 +4
;  System::Call '$PLUGINSDIR\bdinst::chkbd(i 2) i .r0 ? c'
;  Push 1
;  Pop $7
;  Return
FunctionEnd

Function CheckExe

  call notifybd1

;  nsExec::ExecToStack /TIMEOUT=2000 '"PATH" param1 param2 paramN'

;  ExecWait '"$PLUGINSDIR\bdquit.exe"' $0
;  IntCmp $0 0  endkill
;  DetailPrint "BD already running"

  Push 1
  Pop $1
  IfSilent +3    ;jump if not
    Push 0
    Pop $1
  Push $HWNDPARENT
  Pop  $2
  System::Call '$PLUGINSDIR\bdinst::chkbdstate(i,i) i(r1,r2) .r0 ? c'
; 0 not running, -1 quit, 1 killed,

;  MessageBox MB_YESNO "$PLUGINSDIR $0 $1 $2"

  IntCmp $0 0  endkill +1 +2
  Quit
  DetailPrint "Terminated existing BD"
endkill:

FunctionEnd

 ; StrStr
 ; input, top of stack = string to search for
 ;        top of stack-1 = string to search in
 ; output, top of stack (replaces with the portion of the string remaining)
 ; modifies no other variables.
 ;
 ; Usage:
 ;   Push "this is a long ass string"
 ;   Push "ass"
 ;   Call StrStr
 ;   Pop $R0
 ;  ($R0 at this point is "ass string")

 Function StrStr
   Exch $R1 ; st=haystack,old$R1, $R1=needle
   Exch    ; st=old$R1,haystack
   Exch $R2 ; st=old$R1,old$R2, $R2=haystack
   Push $R3
   Push $R4
   Push $R5
   StrLen $R3 $R1
   StrCpy $R4 0
   ; $R1=needle
   ; $R2=haystack
   ; $R3=len(needle)
   ; $R4=cnt
   ; $R5=tmp
   loop:
     StrCpy $R5 $R2 $R3 $R4
     StrCmp $R5 $R1 done
     StrCmp $R5 "" done
     IntOp $R4 $R4 + 1
     Goto loop
 done:
   StrCpy $R1 $R2 "" $R4
   Pop $R5
   Pop $R4
   Pop $R3
   Pop $R2
   Exch $R1
 FunctionEnd

Function onfinish
  IfSilent +4
  IntCmp $9 1 +3
    MessageBox MB_OK|MB_USERICON \
      "The BarracudaDrive service failed to start.$\r$\n\
      Check your configuration settings and Install notes.$\r$\n\
      Restart the computer and open http://localhost/$\r$\n\
      to test if the server is working."
    Return
  ExecShell "open" "http://barracudadrive.net/install/win/?url=localhost:$HPORT/setup/"

FunctionEnd



;--------------------------------
;--------------------------------
;--------------------------------
;--------------------------------
;Uninstaller Section
;--------------------------------
;--------------------------------
;--------------------------------
;--------------------------------


Section "Uninstall"

  SetShellVarContext all ;current
  ;ADD YOUR OWN FILES HERE...

  SetDetailsPrint none

  call un.notifybd3
  call un.fireall_fix

  SetDetailsPrint both

  ExecWait '"$INSTDIR\bdctl" /STOP'

  ClearErrors
;remove services
	nsExec::ExecToLog '"$INSTDIR\bd" -remove'
	Pop $0 # return value/error/timeout
  ClearErrors

;  UnRegDLL "$INSTDIR\pclocx.dll"
;  IfErrors 0 +4
;   	nsExec::ExecToLog 'regsvr32 /u /c /s "$INSTDIR\pclocx.dll"'
; 	  Pop $0 # return value/error/timeout
;    DetailPrint "unregistered DLL with regsvr32"
;  ClearErrors

; =========================================================================
; =========================================================================
; =========================================================================
;  A NAMED LIST OF FILES THAT WE USE AND MUST UNINSTALL
; =========================================================================
; =========================================================================
; =========================================================================

  !define DELETEMODE
  Delete /REBOOTOK "$INSTDIR\badrive.exe"  ;legacy
  Delete /REBOOTOK "$INSTDIR\bdctl.exe"
  Delete /REBOOTOK "$INSTDIR\bd.exe"
  Delete /REBOOTOK "$INSTDIR\bd.zip"
  Delete /REBOOTOK "$INSTDIR\bd.conf"
  Delete /REBOOTOK "$INSTDIR\blua.dll"
  Delete /REBOOTOK "$INSTDIR\license.rtf"
  Delete /REBOOTOK "$INSTDIR\msvcp100.dll"
  Delete /REBOOTOK "$INSTDIR\msvcr100.dll"
  Delete /REBOOTOK "$INSTDIR\readme.txt"
  Delete /REBOOTOK "$INSTDIR\install.txt"
  Delete /REBOOTOK "$INSTDIR\start.txt"
  Delete /REBOOTOK "$INSTDIR\sqlite3.exe"
  Delete /REBOOTOK "$INSTDIR\barracuda.dll"
  Delete /REBOOTOK "$INSTDIR\balua.dll"
  Delete /REBOOTOK "$INSTDIR\applications\setup.zip"
  Delete /REBOOTOK "$INSTDIR\applications\forum.zip"
  Delete /REBOOTOK "$INSTDIR\applications\cms.zip"
;  Delete /REBOOTOK "$INSTDIR\applications\tutorials.zip"
;  Delete /REBOOTOK "$INSTDIR\data\cms.sqlite.db"
;  Delete /REBOOTOK "$INSTDIR\data\forum.sqlite.db"
;  Delete /REBOOTOK "$INSTDIR\cmsdocs\*.*"
  Delete /REBOOTOK "$INSTDIR\uninstall.exe"
  ClearErrors

  RMDir /REBOOTOK "$INSTDIR\applications"
  RMDir /REBOOTOK "$INSTDIR\data"
  RMDir /REBOOTOK "$INSTDIR\cmsdocs"
  RMDir /REBOOTOK "$INSTDIR\themes"
  RMDir /r /REBOOTOK "$INSTDIR\trace"
  RMDir /r /REBOOTOK "$INSTDIR\cache"
  RMDir /REBOOTOK "$INSTDIR"
  ClearErrors

  !insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\badrive" ;legacy
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bd"

  StrCpy $MUI_TEMP "$SMPROGRAMS\$MUI_TEMP"

  Delete "$MUI_TEMP\Uninstall badrive.lnk" ;legacy
  Delete "$MUI_TEMP\Uninstall bdctl.lnk"
  Delete "$MUI_TEMP\Install Service (Automatic Start).lnk"
  Delete "$MUI_TEMP\Install Service (Manual Start).lnk"
  Delete "$MUI_TEMP\Remove Service.lnk"
  Delete "$MUI_TEMP\BarracudaDrive Directory.lnk"

  Delete "$MUI_TEMP\\Web Site.url"
  Delete "$MUI_TEMP\\Support Page.url"
  Delete "$MUI_TEMP\\BarracudaDrive Documentation.url"
  !ifdef DEMO
  Delete "$MUI_TEMP\\Order licenses.url"
  !endif
; =========================================================================
; =========================================================================
; =========================================================================

  !insertmacro mkshtcut "Readme" "readme.txt"
  !insertmacro mkshtcut "BarracudaDrive  License" "license.rtf"
  !insertmacro mkshtcut "Uninstall BarracudaDrive" "Uninstall.exe"
  !insertmacro mkshtcut "BarracudaDrive" "bdctl.exe"
  !insertmacro mkshtcut "BarracudaDrive" "badrive.exe" ;legacy

; =========================================================================
; =========================================================================
  ;Delete empty start menu parent diretories
; =========================================================================
; =========================================================================

  startMenuDeleteLoop:
	ClearErrors
    RMDir $MUI_TEMP
    GetFullPathName $MUI_TEMP "$MUI_TEMP\.."

    IfErrors startMenuDeleteLoopDone

    StrCmp $MUI_TEMP $SMPROGRAMS startMenuDeleteLoopDone startMenuDeleteLoop
  startMenuDeleteLoopDone:

;  DeleteRegKey /ifempty HKLM "${SREGKEY}\Directory"
  DeleteRegKey /ifempty HKLM "${SREGKEY}\badrive\install" ;legacy
  DeleteRegKey /ifempty HKLM "${SREGKEY}\bd\install"
  DeleteRegKey /ifempty HKLM "${SREGKEY}\badrive"         ;legacy
  DeleteRegKey /ifempty HKLM "${SREGKEY}\bd"
;  DeleteRegKey HKCU "${SREGKEY}\badrivew"
  DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "badrive" ;legacy
  DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "bdctl"

SectionEnd
