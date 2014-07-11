#!/usr/bin/env python
## pyGTK template

import pygtk
pygtk.require('2.0')
import gtk

class MyProgram:

    def __init__(self):

        # create a new window

        app_window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        app_window.set_size_request(500, 350)
        app_window.set_border_width(10)
        app_window.set_title("MyProgram title")
        app_window.connect("delete_event", lambda w,e: gtk.main_quit())

        bbox = gtk.HButtonBox()
        button_go = gtk.Button(stock='gtk-ok')
        #button_go.connect('clicked', self.button_clicked)
        bbox.add(button_go)
        app_window.add(bbox)

        app_window.show_all()

        return

def main():
    gtk.main()
    return 0

if __name__ == "__main__":
    MyProgram()
    main()
