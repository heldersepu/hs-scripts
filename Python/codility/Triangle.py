def solution(A):
    if len(A) > 2:
        A.sort()
        for i in range(len(A)-2):
            if A[i] + A[i+1] > A[i+2] and A[i+1] + A[i+2] > A[i] and A[i+2] + A[i] > A[i+1]:
                return 1
    return 0


print(solution([2, 1, 1, 2, 3, 1]))
print(solution([10, 2, 4, 1, 8, 20]))
print(solution([10, 50, 5, 1]))
print(solution([10, 5, 6, 7, 8]))
print(solution(list(range(10))))
