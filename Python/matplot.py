import numpy
from tkinter import *
from tkinter import ttk
import matplotlib.pyplot as plt
from matplotlib import style
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg


def expand_graph():
    fig = plt.figure(figsize=(8, 6))
    fig.suptitle('Expanded Graph')
    #plt.plot(x, y, lw=1)
    plt.plot(ax1)
    plt.xlabel('x-values')
    plt.ylabel('y-values')
    plt.show()


if __name__ == "__main__":
    root = Tk()

    x = numpy.arange(0.0, 2.0, 0.01)
    y = 1 + numpy.cos(2 * numpy.pi * x)

    style.use('ggplot')

    Figure1 = plt.figure(figsize=(8, 6))
    plot1 = FigureCanvasTkAgg(Figure1, root)
    plot1.get_tk_widget().grid(columnspan=6, rowspan=15)
    ax1 = Figure1.add_subplot()
    ax1.plot(x, y, lw=1)
    ax1.set_xlabel("x-values", fontsize='medium')
    ax1.set_ylabel("y-values", fontsize='medium')

    button = ttk.Button(root, text="Expand Graph",
                        command=expand_graph, width=15)
    button.grid(row=16, columnspan=6)

    root.mainloop()
