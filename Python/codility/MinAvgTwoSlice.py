def solution(A):
    minAve = 20000
    pos = 0
    N = len(A)

    # calculate the prefix sums
    pref = [0] * (N + 1)
    for k in range(1, N + 1):
        pref[k] = pref[k - 1] + A[k - 1]

    # checks for the min average
    for P in range(N):
        for Q in range(P+1, min(P+3, N)):
            ave = (pref[Q+1] - pref[P]) / (Q-P+1)
            if ave < minAve:
                minAve = ave
                pos = P
    return pos


print(solution([4, 2, 2, 5, 1, 5, 8]))
