import random


def solution(A):
    smallest = 1
    A.sort()
    if (A[len(A)-1] > 0):
        for i in A:
            if (i > 0):
                if (i > smallest):
                    return smallest
                else:
                    smallest = i + 1
    return smallest


array = [1, 3, 6, 4, 1, 2]
print(solution(array))

array = range(10000)
random.shuffle(array)
print(solution(array))
