def solution(A, B):
    free = 0
    queue = []
    for i, v in enumerate(B):
        if v == 0:
            while len(queue) > 0:
                e = queue.pop()
                if e > A[i]:
                    queue.append(e)
                    break
            else:
                free += 1
        else:
            queue.append(A[i])
    return free + len(queue)


print(solution([4, 3, 2, 1, 5], [0, 0, 0, 0, 0]))
print(solution([4, 3, 2, 1, 5], [0, 0, 0, 1, 1]))
print(solution([4, 3, 2, 1, 5], [0, 1, 0, 0, 0]))
print(solution([4, 3, 2, 1, 5], [1, 0, 0, 0, 0]))
