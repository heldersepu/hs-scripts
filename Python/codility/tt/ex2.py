"""
There are N given points (numbered from 0 to N-1) on a plane.
The K-th point is located at coordinates (X[K], Y[K]) and its tag is S[K].
We want to draw a circle centered on coordinates (0, 0).
The circle should not contain two points with the same tag.
What is the maximum number of points that can lie inside the circle?
"""
import math


def distance(a, b):
    return math.sqrt((a**2) + (b**2))


def solution(S, X, Y):
    # sorted by distance to the center
    p = []
    for i in range(len(X)):
        p += [(X[i], Y[i], S[i], distance(X[i], Y[i]))]
    p.sort(key=lambda x: x[3])

    # count the "OK" points
    points = {}
    count = 0
    for i in p:
        tag = i[2]
        dist = i[3]
        if tag in points:
            if points[tag] == dist:
                count -= 1
            break
        else:
            count += 1
            points[tag] = dist
    return count


print(solution("ABDCA", [2, -1, -4, -3, 3], [2, -2, 4, 1, -3]))
print(solution("ABB", [1, -2, -2], [1, -2, -2]))
print(solution("CCD", [1, -1, 2], [1, -1, 2]))
