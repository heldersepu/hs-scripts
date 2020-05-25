def solutionL(N, M):
    chocolates = [True] * N
    count = 0
    pos = 0
    while chocolates[pos]:
        chocolates[pos] = False
        pos = (pos + M) % N
        count += 1
    return count


def solution(N, M):
    def gcd(p, q):
        if q == 0:
            return p
        return gcd(q, p % q)

    def lcm(p, q):
        return p * (q / gcd(p, q))

    return int(lcm(N, M)//M)


print(solution(10, 4))
print(solution(1, 1))
print(solution(1, 2))
print(solution(10, 10))
print(solution((3**9)*(2**14), (2**14)*(2**14)))
