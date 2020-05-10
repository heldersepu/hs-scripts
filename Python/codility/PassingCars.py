def solution(A):
    zcount = 0
    passing = 0
    for i in A:
        if i == 0:
            zcount += 1
        else:
            passing += zcount
        if passing > 1000000000:
            return -1
    return passing


print(solution([0, 1, 0, 1, 1]))
