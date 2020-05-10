def solution(S, P, Q):
    result = [4] * len(P)
    for i in range(len(P)):
        sub = S[P[i]: Q[i]+1]
        if "A" in sub:
            result[i] = 1
        elif "C" in sub:
            result[i] = 2
        elif "G" in sub:
            result[i] = 3
    return result


print(solution("CAGCCTA", [2, 5, 0], [4, 5, 6]))
solution("TTTTT"*100000, [0]*100000, [50000]*100000)
print("one")
solution("GGGGT"*100000, [0]*100000, [50000]*100000)
print("two")
