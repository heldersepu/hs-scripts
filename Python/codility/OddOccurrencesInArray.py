def solution(A):
    values = {}
    for i in A:
        if i in values:
            values[i] += 1
        else:
            values[i] = 1
    for key, val in values.items():
        if val % 2 == 1:
            return key


print(solution([3, 2, 3, 2, 6]))
print(solution([3, 3, 2]))
print(solution([2, 3, 3]))
print(solution([4, 4, 4]))
print(solution([2] + [3]*100000))
