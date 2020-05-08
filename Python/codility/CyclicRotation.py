def solution(A, K):
    l = len(A)
    if l == 0:
        return []
    max = K % l
    return A[l - max:] + A[0:l - max]


print(solution([3, 8, 9, 7, 6], 3))
print(solution([1, 2, 3, 4], 8))
print(solution([], 8))
