def solution(N, A):
    counters = [0] * N
    maxi = 0
    doMaxi = False
    for K in range(len(A)):
        if A[K] == (N + 1):
            if doMaxi:
                counters = [maxi] * N
        else:
            counters[A[K]-1] += 1
            if counters[A[K]-1] > maxi:
                maxi = counters[A[K]-1]
                doMaxi = True
    return counters


print(solution(5, [3, 4, 4, 6, 1, 4, 4]))
print(solution(5, [3, 4, 4, 6, 6, 1, 4, 4]))
print(solution(5, []))
print(solution(5, [2]))
solution(100000, list(range(100000)))
solution(100000, [100001]*100000)
print("done")
