UPDATE QFWinData_QQ010047..Company SET NaicCode = left(ltrim(NAIC),6)
WHERE NaicCode is NULL and NAIC <> ''