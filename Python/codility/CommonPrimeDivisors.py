def gcd(p, q):
    if q == 0:
        return p
    return gcd(q, p % q)


def hasSameFactors(p, q):
    if p == q == 0:
        return True

    denom = gcd(p, q)

    while (p != 1):
        p_gcd = gcd(p, denom)
        if p_gcd == 1:
            break
        p /= p_gcd
    else:
        while (q != 1):
            q_gcd = gcd(q, denom)
            if q_gcd == 1:
                break
            q /= q_gcd
        else:
            return True

    return False


def solution(A, B):
    cnt = 0
    for idx in range(len(A)):
        if hasSameFactors(A[idx], B[idx]):
            cnt += 1

    return cnt


print(solution([15, 10, 3], [75, 30, 5]))
print(solution([1], [1]))
print(solution([2, 1, 2], [1, 2, 2]))
