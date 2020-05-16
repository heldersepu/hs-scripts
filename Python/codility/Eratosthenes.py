def solution(N):
    primes = [2] + list(range(3, N, 2))
    i = 1
    while i < len(primes):
        for j in range(primes[i]*2, N, primes[i]):
            if j in primes:
                primes.remove(j)
        i += 1
    return primes


print(solution(100))
