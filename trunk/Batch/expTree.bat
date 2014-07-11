:: Script to Export a tree for several folders
@SET dTreeFile="c:\Tree.txt"

TREE "E:\etc\movie\avi" /F /A > %dTreeFile%
TREE "G:\usrs\High Def" /F /A >> %dTreeFile%
TREE "X:\src\temp\data" /F /A >> %dTreeFile%
TREE "X:\src\tem1\data" /F /A >> %dTreeFile%
TREE "X:\src\tem2\data" /F /A >> %dTreeFile%
:: Add more folders as needed...
:: use the >> to append to the file

%dTreeFile%
@PAUSE

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                    ::
::   Graphically displays the folder structure of a drive or path.    ::
::                                                                    ::
::   TREE [drive:][path] [/F] [/A]                                    ::
::                                                                    ::
::      /F   Display the names of the files in each folder.           ::
::      /A   Use ASCII instead of extended characters.                ::
::                                                                    ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
