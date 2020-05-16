def semiprimes(N):
    # get primes
    primes = [2] + list(range(3, N//2+1, 2))
    i = 1
    while i < len(primes):
        for j in range(primes[i]*2, N//2+1, primes[i]):
            if j in primes:
                primes.remove(j)
        i += 1

    # get semiprimes
    semiprime = {4, 6, 9}
    for i in range(len(primes)-1):
        for j in range(i, len(primes)):
            sp = primes[i] * primes[j]
            if sp > N:
                break
            semiprime.add(primes[i] * primes[j])

    # get rolling count of semiprimes
    count = [0]*(N+1)
    for i in range(1, N+1):
        count[i] = count[i-1]
        if i in semiprime:
            count[i] += 1
    return count


def solution(N, P, Q):
    semip = semiprimes(min(N, max(Q)))
    count = [0] * len(Q)
    for i, v in enumerate(Q):
        if P[i] <= Q[i] <= N:
            count[i] = semip[Q[i]] - semip[P[i]-1]
    return count


print(solution(55, [1, 4, 16], [26, 10, 20]))
