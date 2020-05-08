def solution(n):
    max = 0
    count = 0
    bin = format(n, 'b')
    for i in bin:
        if i == "0":
            count += 1
        else:
            if count > max:
                max = count
            count = 0
    return max


print(solution(1))
print(solution(2))
print(solution(9))
print(solution(20))
print(solution(32))
print(solution(529))
