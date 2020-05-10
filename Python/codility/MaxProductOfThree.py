import random
import timeit


def solution(A):
    A.sort(reverse=True)
    top = A[0] * A[1] * A[2]
    bottom = A[0] * A[-1] * A[-2]
    return max(top, bottom)


def solutionB(A):
    if len(A) == 3:
        return A[0] * A[1] * A[2]

    max1 = max(A)
    min1 = min(A)
    A.remove(max1)
    A.remove(min1)

    max2 = max(A)
    min2 = min(A)
    A.remove(max2)

    top = max1 * max2 * max(A)
    bottom = max1 * min1 * min2
    return max(top, bottom)


print(solution([-3, 1, 2, -2, 5, 6]))
print(solutionB([-3, 1, 2, -2, 5, 6]))

print(solution([-30, 1, 2, -2, 5, 6]))
print(solutionB([-30, 1, 2, -2, 5, 6]))

print(solutionB([3, 1, 2]))
print(solutionB([3, -1, 2, -10]))


starttime = timeit.default_timer()
r = list(range(10000000))
random.shuffle(r)
solution(r)
print(timeit.default_timer() - starttime)

starttime = timeit.default_timer()
r = list(range(10000000))
random.shuffle(r)
solutionB(r)
print(timeit.default_timer() - starttime)
