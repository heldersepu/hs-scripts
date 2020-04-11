from tkinter import *


class MyApp:
    def __init__(self):
        self.root = Tk()
        self.mainframe = Frame(self.root)
        self.mainframe.pack(fill=BOTH, expand=True)
        self.mainframe.columnconfigure(0, weight=1)

        self.contentCanvas = Canvas(self.mainframe)
        self.contentCanvas.grid(sticky=N + S + W + E)

        self.horizontalBar = Scrollbar(self.mainframe, orient=HORIZONTAL)
        self.horizontalBar.grid(rowspan=2, sticky=W + E + S)
        self.horizontalBar.config(command=self.contentCanvas.xview)
        self.contentCanvas.config(xscrollcommand=self.horizontalBar.set)

        self.contentFrame = Frame(self.contentCanvas)
        self.text = StringVar()
        self.text.set("- " * 100)
        Label(self.contentFrame, textvariable=self.text).grid()
        self.content = Frame(self.contentFrame)
        self.content.grid()
        Button(self.content, text="Long Content",
               command=self.longContent).grid()

        self.contentCanvas.bind("<Configure>", lambda e: self.contentCanvas.configure(
            scrollregion=self.contentFrame.bbox("all")))
        self.contentCanvas.create_window(
            (0, 0), window=self.contentFrame, anchor="nw")

    def run(self):
        self.root.mainloop()

    def longContent(self):
        self.contentCanvas.configure(
            scrollregion=self.contentCanvas.bbox("all"))
        self.text.set(self.text.get() * 10)


if __name__ == "__main__":
    app = MyApp()
    app.run()
