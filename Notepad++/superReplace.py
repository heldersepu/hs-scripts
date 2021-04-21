strTable = ""

def testContents(contents, lineNumber, totalLines):
    global strTable
    if (contents.strip() == "|-"):
        strField = ""
        if (lineNumber+2 < totalLines):
            strLine1 = editor.getLine(lineNumber + 1).strip()
            strLine2 = editor.getLine(lineNumber + 2).strip()
            if (strLine1.startswith("|") and strLine2.startswith("|")):
                strField = strLine2[1:]
        if (strField != ""):
            editor.replaceLine(lineNumber, "{{CDD |" + strTable + " |" + strField + "}}")
            editor.replaceLine(lineNumber + 1, "")
            editor.replaceLine(lineNumber + 2, "")
    elif (contents.startswith("==")):
        strTable = contents.replace("==","").strip().upper()

editor.forEachLine(testContents)
editor.selectAll()
notepad.runMenuCommand("TextFX Tools", "Delete Surplus Blank Lines")