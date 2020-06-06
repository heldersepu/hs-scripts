"""
Strings with long blocks of repeating characters take much less space 
if kept in a compressed representation. To obtain the compressed representation, 
we replace each segment of equal characters in the string with the number of 
characters in the segment followed by the character (for example, we replace segment 
"CCCC" with "4C"). To avoid increasing the size, we leave the one-letter segments 
unchanged (the compressed representation of "BC" is the same string − "BC").
"""


def compress(S):
    comp = []
    prev = S[0]
    count = 0
    for c in S:
        if prev == c:
            count += 1
        else:
            comp.append([count, prev])
            count = 1
        prev = c
    comp.append([count, prev])
    return comp


def length(comp):
    s = ""
    for c in comp:
        if c[0] == 1:
            s += c[1]
        elif c[0] > 1:
            s += str(c[0]) + c[1]
    print(s)
    return len(s)


def solution(S, K):
    l = len(S)
    if l < 3:
        return 0
    minsize = 0

    return length(compress(S))


print(solution("ABBBCCDDCCC", 3))  # 5 A3B4C
print(solution("AAAAAAAAAAABXXAAAAAAAAAA", 3))  # 3 21A
print(solution("ABCDDDEFG", 2))  # 6 ABC3DG
print(solution("AABCAPAQAA", 4))
