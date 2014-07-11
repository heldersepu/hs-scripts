import pygtk
pygtk.require('2.0')
import gtk, cairo
from math import pi

# Window setup
window = gtk.Window(gtk.WINDOW_TOPLEVEL)
window.set_decorated(True)
window.set_app_paintable(True)
#window.set_colormap(window.get_screen().get_rgba_colormap())
window.realize()
window.set_flags(gtk.HAS_FOCUS | gtk.CAN_FOCUS)
window.grab_focus()

# Cairo transparent setup
cr = window.get_window().cairo_create()
cr.set_operator(cairo.OPERATOR_CLEAR)
surface = cairo.ImageSurface(cairo.FORMAT_ARGB32, 201, 201)
cr.rectangle(0, 0, 201, 201)
cr.fill()

# Cairo semi-transparent setup
cr.set_operator(cairo.OPERATOR_OVER)
cr.set_source_rgba(0.5, 0.0, 0.0, 0.5)
cr.arc(100, 100, 100, 0, pi*2)
cr.fill()

# Cairo opaque setup
cr.set_operator(cairo.OPERATOR_OVER)
width = 3
r, g, b, a = (0.0,0.0,0.0,1.0)
cr.set_source_rgba(r,g,b,a)
cr.rectangle(-1, -1, 3, 3)
cr.fill()

# Restore default Cairo conditions
cr.set_operator(cairo.OPERATOR_OVER)
window.add(cr)
window.show_all()
gtk.mainloop()
# Save layered image to a png image file
# with open('layered.png', 'w+') as png:
    # surface.write_to_png(png)