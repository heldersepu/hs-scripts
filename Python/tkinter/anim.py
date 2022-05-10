import time
from tkinter import Canvas, Tk

tk = Tk()
tk.geometry('500x500')

canvas = Canvas(tk)
canvas.pack(expand=True, fill='both')

in_list = [1,1,1,1,1,1,1]

arc_length = 360 / len(in_list)

for mvmt in range(100):
    canvas.delete('all')
    for i in range(len(in_list)):
        start = i * arc_length
        extent = (i + 1) * arc_length
        arc = canvas.create_arc(5, 5, 495, 495, outline='white', start=start + mvmt, extent=extent)
    tk.update()
    time.sleep(0.05)

tk.mainloop()