def solution(X, A):
    if len(A) > 0:
        s = {A[0]}
        for i in range(len(A)):
            if X >= A[i] > 0:
                s.add(A[i])
            if len(s) == X:
                return i
    return -1


print(solution(5, [1, 3, 1, 4, 2, 3, 5, 4]))
print(solution(1, [1, 3, 1, 4, 2, 3, 5, 4]))
print(solution(2, [1, 3, 1, 4, 2, 3, 5, 4]))
print(solution(5, []))
print(solution(5, [2]))
