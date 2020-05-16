def solution(A):
    count = {}
    for element in A:
        if element not in count:
            count[element] = 1
        else:
            count[element] += 1

    divisors = {}
    for element in A:
        divisors[element] = set([1, element])

    # Get all divisors via sieve of eratosthenes
    divisor = 2
    A_max = max(A)
    while divisor*divisor <= A_max:
        c = divisor
        while c <= A_max:
            if c in divisors and not divisor in divisors[c]:
                divisors[c].add(divisor)
                divisors[c].add(c//divisor)
            c += divisor
        divisor += 1

    result = [0] * len(A)
    for i, v in enumerate(A):
        result[i] = (len(A) - sum([count.get(d, 0) for d in divisors[v]]))

    return result


print(solution([3, 1, 2, 3, 6]))
