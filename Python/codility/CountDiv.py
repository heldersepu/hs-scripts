def solution(A, B, K):
    count = 0
    for i in range(A, B+1):
        if i % K == 0:
            count = len(range(i, B+1, K))
            break
    return count


print(solution(1, 10, 2))
print(solution(3, 10, 2))
print(solution(1, 1, 2))
print(solution(12, 14, 5))
print(solution(14, 16, 5))
print(solution(2, 2, 2))
print(solution(0, 0, 11))
