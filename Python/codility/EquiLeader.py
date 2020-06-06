import collections


def solution(A):
    count = 0
    if len(A) > 0:
        c = collections.Counter(A)
        leader = c.most_common()[0]
        if leader[1] > len(A) / 2:
            left = 0
            right = leader[1]
            for i, v in enumerate(A):
                if (v == leader[0]):
                    left += 1
                    right -= 1
                if (left > (i+1)/2 and right > (len(A)-(i+1))/2):
                    count += 1
    return count


print(solution([3, 4, 3, 2, 3, 1, 3, 3]))
print(solution([1, 3, 1, 1, 1, 2]))
print(solution([3]))
