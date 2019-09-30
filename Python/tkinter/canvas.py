from tkinter import Tk, Frame, Button, Canvas

class MyCanvas:
    def __init__(self):
        window = Tk()
        window.title("Canvas")

        self.canvas = Canvas(window, width = 200, height = 100, bg = "white")
        self.canvas.pack()

        frame = Frame(window)
        frame.pack()
        btRectangle = Button(frame, text = "Rectangle", command = self.displayRect)
        btOval = Button(frame, text = "Oval", command = self.displayOval)
        btRectangle.grid(row = 1, column = 1)
        btOval.grid(row = 1, column = 2)
        #btClear.grid(row = 1, column = 3)

        window.mainloop()

    def displayRect(self):
        self.canvas.create_rectangle(110, 10, 210, 80, outline = "black", tags = "rect")

    def displayOval(self):
        self.canvas.create_oval(110, 10, 210, 80, outline = "black", tags = "oval")

    def clearCanvas(self):
        self.canvas.delete("rect", "oval")

MyCanvas()
