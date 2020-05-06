import math
import tkinter
import time

window = tkinter.Tk()
window.title("WALL-E SONAR")
window.geometry(f'2000x1000')

canvas = tkinter.Canvas(window)
canvas.configure(bg="black")
canvas.pack(fill="both", expand=True)


def animate_sonar(window, canvas):
    dist = 200
    for angl in range(180, 360):
        rad = angl * math.pi / 180
        x = dist * math.cos(rad) + 300
        y = dist * math.sin(rad) + 300

        canvas.delete("all")
        canvas.create_oval(x-10, y-10, x+10, y+10, fill="green")
        canvas.create_line(300, 300, x, y, fill="red")
        window.update()
        time.sleep(0.05)


animate_sonar(window, canvas)
window.mainloop()
