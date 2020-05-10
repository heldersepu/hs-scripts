def solution(S):
    go = True
    while go:
        temp = S
        S = S.replace('()', '') \
            .replace('[]', '') \
            .replace('{}', '')
        go = not (temp == S)
    return 1 if S == '' else 0


def solutionB(S):
    if len(S) == 0:
        return 1

    opening = ["(", "{", "["]
    closing = [")", "}", "]"]
    queue = []
    for s in S:
        if s in opening:
            queue.append(s)
        elif s in closing:
            if len(queue) < 1:
                return 0
            e = queue.pop()
            if opening.index(e) != closing.index(s):
                return 0
    return 1 if len(queue) == 0 else 0


print(solutionB('{[()()]}'))
print(solutionB('([)()]'))
print(solutionB(''))
print(solutionB('{[()()]}'*100000))
print(solutionB('('*100000 + ')'*100000))
