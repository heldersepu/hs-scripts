def solution(A):
    array_len = len(A)
    if array_len <= 2:
        return 0

    peaks = []
    for i in range(1, array_len-1):
        if A[i-1] < A[i] > A[i+1]:
            peaks.append(i)

    if len(peaks) < 2:
        return len(peaks)

    for i in range(array_len, 0, -1):
        if i == 1:
            return 1
        if array_len % i == 0:
            f = array_len // i
            found = [False] * i
            count = 0
            for p in peaks:
                block = p//f
                if not found[block]:
                    found[block] = True
                    count += 1
            if count == i:
                return i


print(solution([3, 3]))
print(solution([3, 3, 3]))
print(solution([3, 4, 3]))
print(solution([1, 2, 3, 4,   3, 4, 1, 2,   3, 4, 6, 2]))
