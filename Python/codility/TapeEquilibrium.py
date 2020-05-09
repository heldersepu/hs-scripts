def solution(A):
    min = None
    left = 0
    right = sum(A)
    for i in A[0:-1]:
        left += i
        right -= i
        a = abs(left - right)
        if min is None or a < min:
            min = a
    return min


print(solution([3, 1, 2, 4, 3]))
print(solution([3, 1, 1, 3]))
print(solution([-3, 1, 1, 3]))
print(solution([-2, 2]))
