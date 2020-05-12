import math


def solution(N):
    sqrt = math.floor(math.sqrt(N))
    x = 1
    for i in range(sqrt, 0, -1):
        if (N % i == 0):
            x = i
            break
    return x*2 + (N/x)*2


print(solution(64))
print(solution(30))
print(solution(1))
print(solution(1000000000))
