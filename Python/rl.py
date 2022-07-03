# Mystery computation in Python
# Takes input n and computes output named result

import simplegui

# global state
result = 23
iteration = 0
max_iterations = 20

def Collatz(n):
    return n / 2 if (n % 2 == 0) else n * 3 + 1

# timer callback
def update():
    global iteration, result
    print result
    if (iteration >= max_iterations or result == 1):
        timer.stop()
    else:
        iteration += 1
        result = Collatz(result)


# register event handlers
timer = simplegui.create_timer(1, update)

# start program
timer.start()