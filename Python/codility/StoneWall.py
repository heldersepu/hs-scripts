def solution(H):
    blocks = 0
    stack = []

    for i in H:
        while len(stack) > 0 and stack[-1] > i:
            stack.pop()
        if not(len(stack) > 0 and stack[-1] == i):
            blocks += 1
            stack.append(i)
    return blocks


print(solution([8, 8, 5, 7, 9, 8, 7, 4, 8]))
print(solution([8]*100))
