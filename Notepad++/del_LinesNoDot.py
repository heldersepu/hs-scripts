def testContents(contents, lineNumber, totalLines): 
    if (contents.find(".") < 0):
        editor.replaceLine(lineNumber, "")

editor.forEachLine(testContents)
editor.selectAll()
notepad.runMenuCommand("TextFX Tools", "Delete Surplus Blank Lines")
