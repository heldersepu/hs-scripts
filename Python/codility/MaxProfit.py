def solution(A):
    profit = 0
    if len(A) > 1:
        start = 0
        end = 0
        for idx, v in enumerate(A):
            if v < A[start]:
                start = idx
                end = idx
            elif v > A[end]:
                end = idx
            p = A[end] - A[start]
            if p > profit:
                profit = p
    return profit


print(solution([23171, 21011, 21123, 21366, 21013, 21367]))
print(solution([0, 20]))
print(solution([20, 0]))
