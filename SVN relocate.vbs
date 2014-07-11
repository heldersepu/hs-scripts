' Array with all possible folders
arrFolders = Array( _
"h:\NEWQQGA", _
"H:\NEWQQGA\Allcomp", _
"H:\NEWQQGA\compzips", _
"H:\NEWQQGAC", _
"H:\NEWQQGAC\allcomp", _
"H:\NEWQQGAC\COMPZIPS", _
"H:\QuickQuoteForWindows\Georgia\Auxiliary", _
"H:\QuickQuoteForWindows\Georgia\AuxiliaryC", _
"H:\QuickQuoteForWindows\Georgia\Compdll", _
"H:\QuickQuoteForWindows\Georgia\Compdll2", _
"H:\QuickQuoteForWindows\Georgia\Compzips", _
"H:\QuickQuoteForWindows\Georgia\Compzips2", _
"H:\QuickQuoteForWindows\Georgia\Engine Files", _
"H:\QuickQuoteForWindows\Georgia\Engine FilesC", _
"H:\QuickQuoteForWindows\Georgia\Engine Files-Source", _
"h:\Newqq95", _
"H:\Newqq95\Allcomp", _
"H:\Newqq95\compzips", _
"H:\Newqq95C", _
"H:\newqq95C\allcomp", _
"H:\Newqq95C\COMPZIPS", _
"H:\QuickQuoteForWindows\Florida\Auxiliary", _
"H:\QuickQuoteForWindows\Florida\AuxiliaryC", _
"H:\QuickQuoteForWindows\Florida\Compdll", _
"H:\QuickQuoteForWindows\Florida\Compdll2", _
"H:\QuickQuoteForWindows\Florida\Compzips", _
"H:\QuickQuoteForWindows\Florida\Compzips2", _
"H:\QuickQuoteForWindows\Florida\Engine Files", _
"H:\QuickQuoteForWindows\Florida\Engine FilesC", _
"h:\QUICK95", _
"h:\QUICK95\Allcomp", _
"h:\QUICK95\compzips", _
"h:\QUICK95\PreComp", _
"H:\quick95C", _
"H:\quick95C\ALLCOMP", _
"H:\quick95C\COMPZIPS", _
"H:\quick95C\PRECOMP", _
"H:\QuickQuoteForWindows\Texas\CompDll", _
"H:\QuickQuoteForWindows\Texas\CompDllC", _
"H:\QuickQuoteForWindows\Texas\Compzips", _
"H:\QuickQuoteForWindows\Texas\CompzipsC", _
"H:\QuickQuoteForWindows\Texas\EngineFiles", _
"H:\QuickQuoteForWindows\Texas\EngineFilesC" )

For Each dFolder In arrFolders
    If not doReloc(dFolder) then
        doReloc(Replace(dFolder, "H:", "\\MainNt2\QQData"))
    End If
Next


Function doReloc(strFolder)
    Set fso = CreateObject("Scripting.FileSystemObject")
    'Check if the  .SVN folder exists
    If (fso.FolderExists(strFolder & "\.svn")) then
        doReloc = True
        Set objShell = CreateObject("WScript.Shell")
        strCommandIni = "TortoiseProc /command:relocate /path:"
        strCommandEnd = " /notempfile /closeonend"
        'Open the Tortoise Relocate Dialog
        objShell.Run strCommandIni & strFolder & strCommandEnd
        Set objShell = Nothing
    Else
        doReloc = False
    End If
    Set fso = Nothing
End Function

