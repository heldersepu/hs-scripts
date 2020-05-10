def solution(A):
    intersect = 0
    for i in range(len(A)-1):
        for j in range(i+1, len(A)):
            if (j - i) <= (A[i] + A[j]):
                intersect += 1
                if intersect > 10000000:
                    return -1
    return intersect


def solutionB(A):
    intersect = 0

    points = []
    for i in range(len(A)):
        points += [(i-A[i], True), (i+A[i], False)]
    print(points)
    points.sort(key=lambda x: (x[0], not x[1]))
    print(points)

    actives = 0
    for _, x in points:
        if (x):
            intersect += actives
            actives += 1
        else:
            actives -= 1
        if intersect > 10000000:
            return -1
    return intersect


arr = [1, 5, 2, 1, 4, 0]
print(solution(arr))
print(solutionB(arr))
print("---")
arr.sort()
print(solution(arr))
print(solution([2]*5))
print(solution([1]*5))
print(solution([0]*5))
print(solution([0]*10000))
print(solutionB([0]*10000))
