import collections


def solution(A):
    if len(A) == 1:
        return 0

    l = len(A)/2
    d = {}
    for i, v in enumerate(A):
        if v in d:
            d[v] += 1
            if d[v] > l:
                return i
        else:
            d[v] = 1
    return -1


def solutionB(A):
    if len(A) > 0:
        c = collections.Counter(A)
        common = c.most_common()[0]
        if common[1] > len(A) / 2:
            for i, v in enumerate(A):
                if v == common[0]:
                    return i
    return -1


print(solutionB([3, 4, 3, 2, 3, 1, 3, 3]))
print(solutionB([8]*100))
print(solutionB([]))
print(solutionB([1]))
print(solutionB([1, 2]))
print(solutionB([1, 1]))
