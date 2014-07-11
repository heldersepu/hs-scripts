import os
def doWalk(dirSource):
    for root, dirs, files in os.walk(dirSource):
        for name in files:
            if (name.endswith(".php")):                
                notepad.open(os.path.join(root, name))
                notepad.menuCommand(MENUCOMMAND.EDIT_TRIMTRAILING)
                if (notepad.getEncoding() == BUFFERENCODING.UTF8):
                    notepad.menuCommand(MENUCOMMAND.FORMAT_CONV2_AS_UTF_8)
                notepad.save()
                notepad.close()
        for name in dirs:
            if (not name.startswith(".")):
                doWalk(os.path.join(root, name))

dirSource = "C:\\xampp\\htdocs\\telesima"
doWalk(dirSource)
