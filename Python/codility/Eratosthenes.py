import timeit


def solution(N):
    primes = set(range(3, N, 2))
    primes.add(2)
    i = 3
    while i < len(primes):
        for j in range(i**2, N, i):
            if j in primes:
                primes.remove(j)
        i += 2
    return primes


def solutionB(N):
    sieve = [False, True] * (N//2 + 1)
    sieve[1] = False
    sieve[2] = True
    i = 3
    while (i*i <= N):
        if sieve[i] == True:
            for j in range(i*i, N+1, i):
                sieve[j] = False
        i += 2
    primes = []
    for i in range(N):
        if sieve[i]:
            primes.append(i)
    return primes


print(solution(100))
print(solutionB(100))

starttime = timeit.default_timer()
solution(10000000)
print(timeit.default_timer() - starttime)

starttime = timeit.default_timer()
solutionB(10000000)
print(timeit.default_timer() - starttime)
