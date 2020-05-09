def solution(A):
    if len(A) > 0:
        A.sort()
        prev = A[0]
        if (prev > 1):
            return prev - 1
        for i in A:
            if (i-1) > prev:
                return i - 1
            prev = i
        return prev + 1
    return 1


print(solution([2, 3, 1, 5]))
print(solution([2, 3, 1]))
print(solution([2, 3]))
print(solution([4, 3]))
print(solution([3]))
print(solution([1]))
print(solution([]))
