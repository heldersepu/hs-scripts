import sys

if len(sys.argv) == 2:
    out = ""
    for i in range(0, len(sys.argv[1])):
        if (i % 2 == 0):
            out += sys.argv[1][i].upper()
        else:
            out += sys.argv[1][i].lower()
    print(out)
