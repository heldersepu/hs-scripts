"""
Strings with long blocks of repeating characters take much less space 
if kept in a compressed representation. To obtain the compressed representation, 
we replace each segment of equal characters in the string with the number of 
characters in the segment followed by the character (for example, we replace segment 
"CCCC" with "4C"). To avoid increasing the size, we leave the one-letter segments 
unchanged (the compressed representation of "BC" is the same string − "BC").
"""


def solution(S, K):
    l = len(S)
    if l < 3:
        return 0
    return 0


print(solution("ABBBCCDDCCC", 3))  # 5 A3B4C
print(solution("AAAAAAAAAAABXXAAAAAAAAAA", 3))  # 3 21A
print(solution("ABCDDDEFG", 2))  # 6 ABC3DG
