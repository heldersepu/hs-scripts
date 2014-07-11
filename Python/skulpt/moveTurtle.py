import turtle
 
t = turtle.Turtle()
s = turtle.Turtle()
t.speed(10)
s.speed(10)
t.color('Red')
s.color('Blue')
s.right(90)
s.forward(2)
s.right(90)
s.forward(12)
for i in range(50):    
    for j in range(2):
        t.forward(7 + i)
        s.forward(7 + i)
    t.right(90)
    s.right(90)
