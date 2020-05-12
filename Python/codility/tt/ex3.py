"""
Merging a sorted list consisting of K elements with a sorted list consisting of L elements takes (K+L) milliseconds (ms). 
The time required to merge more than two lists into one final list depends on the order in which the merges are performed.
"""


def solution(A):
    if len(A) < 2:
        return 0
    A.sort()
    t = []
    r = A[0]
    for i in range(1, len(A)):
        r += A[i]
        t.append(r)
    return sum(t)


print(solution([100, 250, 1000]))
print(solution([100, 250]))
