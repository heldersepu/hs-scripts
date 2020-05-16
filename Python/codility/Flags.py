def count(peaks, guess):
    c = 1
    prev = peaks[0]
    for i in peaks[1:]:
        if i-prev >= guess:
            c += 1
            prev = i
        if c > guess:
            break
    return c


def flags(peaks, min_idx, max_idx):
    if (min_idx >= max_idx):
        return max_idx
    guess = (min_idx + max_idx) // 2
    if count(peaks, guess) > guess:
        return flags(peaks, guess+1, max_idx)
    return flags(peaks, min_idx, guess)


def solution(A):
    if len(A) <= 2:
        return 0
    peaks = []
    for i in range(1, len(A)-1):
        if A[i-1] < A[i] > A[i+1]:
            peaks.append(i)
    return flags(peaks, 0, len(peaks))


array = [1, 5, 3, 4, 3, 4, 1, 2, 3, 4, 6, 2]
print(solution(array))
array = [1, 5, 1, 4, 3, 4, 1, 2, 3, 4, 6, 2]
print(solution(array))
