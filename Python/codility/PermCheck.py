def solution(A):
    A.sort()
    if A[0] > 1:
        return 0
    for i in range(1, len(A)):
        if not (A[i] == (A[i-1]+1)):
            return 0
    return 1


print(solution([1, 3, 6, 4, 1, 2]))
print(solution([1, 3, 4, 2]))
print(solution([3, 4, 2]))
print(solution([8, 4]))
print(solution([4, 8]))
print(solution([3, 4]))
print(solution([4, 3]))
print(solution([1000000000]))
print(solution([1]))
