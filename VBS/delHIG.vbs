'H: -> \\AppSRVA\QQData\
'H:\>dir /s /b hig*.dll > U:\myHIG.txt

myFilesArray = Array("H:\newqq95\allcomp\HIG.dll", "H:\Newqq95C\allcomp\HIG.dll", "H:\Newqqga\allcomp\hig.dll", _
 "H:\quick95c\ALLCOMP\HIG.dll", "H:\quick95c\ALLCOMP\HIGI.dll", "H:\QuickQuoteForWindows\Florida\compdll\HIG.dll", _
 "H:\QuickQuoteForWindows\Florida\compdll2\HIG.dll", "H:\QuickQuoteForWindows\Georgia\CompDll\hig.dll", _
 "H:\QuickQuoteForWindows\Texas\CompDllC\HIG.dll", "H:\QuickQuoteForWindows\Texas\CompDllC\HIGI.dll", _
 "H:\Testers\Florida\Beta\HIG.dll", "H:\Testers\Florida\Final\HIG.dll", "H:\Testers\georgia\Beta\hig.dll", _
 "H:\Testers\Texas\Beta\HIG.dll", "H:\Testers\Texas\Beta\HIGI.dll", "H:\TestVer\Newqq95\AllComp\HIG.dll", _
 "H:\TestVer\Newqqga\allcomp\HIG.dll", "H:\TestVer\quick95\ALLCOMP\HIG.dll", "H:\TestVer\quick95\ALLCOMP\HIGI.dll", _
 "H:\TestVer\QuickQuoteForWindows\Florida\compdll\HIG.dll", _
 "H:\TestVer\QuickQuoteForWindows\Florida\MDB_beta\RES\CompDll\HIG.dll", _
 "H:\TestVer\QuickQuoteForWindows\Georgia\CompDll\HIG.dll", "H:\TestVer\QuickQuoteForWindows\Texas\CompDll\HIG.dll", _
 "H:\TestVer\QuickQuoteForWindows\Texas\CompDll\HIGI.dll")

dResp = MsgBox("Whould you like to Delete all HIG.DLL files?", VbYesNo, "Delete Hartford GA & TX.")
If dResp = vbYes then
    Set fso  = CreateObject("Scripting.FileSystemObject")
    'Delete all HIG*.DLL files in TX and GA folders
    For Each dFile In myFilesArray
        dFile = UCase(dFile)
        If (InStr(dFile,"FLORIDA") = 0) and (InStr(dFile,"NEWQQ95") = 0) then
            If fso.FileExists(dFile) then
                fso.DeleteFile(dFile)
            End If
    	End If
    Next
End IF

