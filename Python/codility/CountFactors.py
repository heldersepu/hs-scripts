import math


def solution(N):
    if N <= 1:
        return 1
    factors = 2
    sq = math.ceil(math.sqrt(N))
    for i in range(2, sq+1):
        if i*i > N:
            break
        if N % i == 0:
            factors += 1 if i*i == N else 2
    return factors


print(solution(24))
print(solution(13))
print(solution(49))
print(solution(1))
print(solution(2))
print(solution(3))
