def solutionL(N):
    s = 0
    for i in range(N+1):
        if (i % 3 == 0) or (i % 5 == 0):
            s += i
    return s


def solutionC(N):
    def fsum(N, F):
        n = (N // F) * F
        return (n + F) * (n//F)//2
    return fsum(N, 3) + fsum(N, 5) - fsum(N, 15)


print(solutionL(151))
print(solutionC(151))
