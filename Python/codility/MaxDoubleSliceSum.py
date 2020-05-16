def solution(A):
    ending_here = [0] * len(A)
    starting_here = [0] * len(A)

    for idx in range(1, len(A)):
        ending_here[idx] = ending_here[idx-1] + A[idx]

    for idx in reversed(range(len(A)-1)):
        starting_here[idx] = starting_here[idx+1] + A[idx]

    max_double_slice = -1000000
    for idx in range(1, len(A)-1):
        max_double_slice = max(
            max_double_slice, starting_here[idx+1] + ending_here[idx-1])

    return max_double_slice


def solutionB(A):
    count = 0
    if len(A) > 3:
        if len(A) == 4:
            count = max(A[1:-1])
        else:
            A = A[1:-1]
            max_ending = max_slice = -1000000
            start = 0
            end = len(A)
            for idx, v in enumerate(A):
                if (max_ending + v) > v:
                    max_ending += v
                else:
                    max_ending = v
                    start = idx

                if max_ending >= max_slice:
                    max_slice = max_ending
                    end = idx
            dmin = 0
            #print(start, end)
            if len(A[start+1:end]) > 0:
                if start == 0 and end == len(A) - 1:
                    dmin = min(A[start+1:end])
                else:
                    dmin = min(0, min(A[start+1:end]))
            count = max_slice - dmin
    return max(0, count)


print(solutionB([3, 2, 6, -1, 4, 5, -1, 2]))
print(solutionB([3, -200, 6, -1, 4, 5, -1, 2]))
print(solutionB([-1, -1, 10, 10, -1, -1]))
print(solutionB([1, 1, 1, 1, 1]))
print(solutionB([1, 1, -1, 1, 1]))
print(solutionB([1, 1, -1, 1]))
print(solutionB([1, -1, -1, 1]))
print(solutionB([1, 1, 1, 1]))
print(solutionB([1, 1, 1]))
