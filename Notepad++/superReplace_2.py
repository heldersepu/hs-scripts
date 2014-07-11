
editor.convertEOLs(2)
editor.rereplace("{.+", "") 
editor.rereplace("!.+", "") 
editor.rereplace(".+}", "") 
editor.rereplace("|-.+", "|-") 
#editor.rereplace("=.+", "") 
editor.replace("\n", "") 
editor.replace("|-", "\n") 
editor.rereplace("|(.+)|(.+)", "    |\\2 =\\1")


def testContents(contents, lineNumber, totalLines): 
    posOne = contents.find("|")
    posTwo = contents.find("=")
    if ((posOne > 0) and (posTwo > 0)):
        editor.replaceLine(lineNumber, contents[0:posOne] + contents[posOne:posTwo].lower() + contents[posTwo:-1])

editor.forEachLine(testContents)