#!/usr/bin/env python
# example-start wheelbarrow wheelbarrow.c

import gtk

# XPM
WheelbarrowFull_xpm = [
    "48 48 64 1",
    "       c None",
    ".      c #DF7DCF3CC71B",
    "X      c #965875D669A6",
    "o      c #71C671C671C6",
    "O      c #A699A289A699",
    "+      c #965892489658",
    "@      c #8E38410330C2",
    "#      c #D75C7DF769A6",
    "$      c #F7DECF3CC71B",
    "%      c #96588A288E38",
    "&      c #A69992489E79",
    "*      c #8E3886178E38",
    "=      c #104008200820",
    "-      c #596510401040",
    ";      c #C71B30C230C2",
    ":      c #C71B9A699658",
    ">      c #618561856185",
    ",      c #20811C712081",
    "<      c #104000000000",
    "1      c #861720812081",
    "2      c #DF7D4D344103",
    "3      c #79E769A671C6",
    "4      c #861782078617",
    "5      c #41033CF34103",
    "6      c #000000000000",
    "7      c #49241C711040",
    "8      c #492445144924",
    "9      c #082008200820",
    "0      c #69A618611861",
    "q      c #B6DA71C65144",
    "w      c #410330C238E3",
    "e      c #CF3CBAEAB6DA",
    "r      c #71C6451430C2",
    "t      c #EFBEDB6CD75C",
    "y      c #28A208200820",
    "u      c #186110401040",
    "i      c #596528A21861",
    "p      c #71C661855965",
    "a      c #A69996589658",
    "s      c #30C228A230C2",
    "d      c #BEFBA289AEBA",
    "f      c #596545145144",
    "g      c #30C230C230C2",
    "h      c #8E3882078617",
    "j      c #208118612081",
    "k      c #38E30C300820",
    "l      c #30C2208128A2",
    "z      c #38E328A238E3",
    "x      c #514438E34924",
    "c      c #618555555965",
    "v      c #30C2208130C2",
    "b      c #38E328A230C2",
    "n      c #28A228A228A2",
    "m      c #41032CB228A2",
    "M      c #104010401040",
    "N      c #492438E34103",
    "B      c #28A2208128A2",
    "V      c #A699596538E3",
    "C      c #30C21C711040",
    "Z      c #30C218611040",
    "A      c #965865955965",
    "S      c #618534D32081",
    "D      c #38E31C711040",
    "F      c #082000000820",
    "                                                ",
    "          .XoO                                  ",
    "         +@#$%o&                                ",
    "         *=-;#::o+                              ",
    "           >,<12#:34                            ",
    "             45671#:X3                          ",
    "               +89<02qwo                        ",
    "e*                >,67;ro                       ",
    "ty>                 459@>+&&                    ",
    "$2u+                  ><ipas8*                  ",
    "%$;=*                *3:.Xa.dfg>                ",
    "Oh$;ya             *3d.a8j,Xe.d3g8+             ",
    " Oh$;ka          *3d$a8lz,,xxc:.e3g54           ",
    "  Oh$;kO       *pd$%svbzz,sxxxxfX..&wn>         ",
    "   Oh$@mO    *3dthwlsslszjzxxxxxxx3:td8M4       ",
    "    Oh$@g& *3d$XNlvvvlllm,mNwxxxxxxxfa.:,B*     ",
    "     Oh$@,Od.czlllllzlmmqV@V#V@fxxxxxxxf:%j5&   ",
    "      Oh$1hd5lllslllCCZrV#r#:#2AxxxxxxxxxcdwM*  ",
    "       OXq6c.%8vvvllZZiqqApA:mq:Xxcpcxxxxxfdc9* ",
    "        2r<6gde3bllZZrVi7S@SV77A::qApxxxxxxfdcM ",
    "        :,q-6MN.dfmZZrrSS:#riirDSAX@Af5xxxxxfevo",
    "         +A26jguXtAZZZC7iDiCCrVVii7Cmmmxxxxxx%3g",
    "          *#16jszN..3DZZZZrCVSA2rZrV7Dmmwxxxx&en",
    "           p2yFvzssXe:fCZZCiiD7iiZDiDSSZwwxx8e*>",
    "           OA1<jzxwwc:$d%NDZZZZCCCZCCZZCmxxfd.B ",
    "            3206Bwxxszx%et.eaAp77m77mmmf3&eeeg* ",
    "             @26MvzxNzvlbwfpdettttttttttt.c,n&  ",
    "             *;16=lsNwwNwgsvslbwwvccc3pcfu<o    ",
    "              p;<69BvwwsszslllbBlllllllu<5+     ",
    "              OS0y6FBlvvvzvzss,u=Blllj=54       ",
    "               c1-699Blvlllllu7k96MMMg4         ",
    "               *10y8n6FjvllllB<166668           ",
    "                S-kg+>666<M<996-y6n<8*          ",
    "                p71=4 m69996kD8Z-66698&&        ",
    "                &i0ycm6n4 ogk17,0<6666g         ",
    "                 N-k-<>     >=01-kuu666>        ",
    "                 ,6ky&      &46-10ul,66,        ",
    "                 Ou0<>       o66y<ulw<66&       ",
    "                  *kk5       >66By7=xu664       ",
    "                   <<M4      466lj<Mxu66o       ",
    "                   *>>       +66uv,zN666*       ",
    "                              566,xxj669        ",
    "                              4666FF666>        ",
    "                               >966666M         ",
    "                                oM6668+         ",
    "                                  *4            ",
    "                                                ",
    "                                                "
]

class WheelbarrowExample:
    def __init__(self):
        window = gtk.Window()
        window.show()

        # Now for the pixmap and the pixmap widget
        style = window.get_style()
        gdk_pixmap, mask = gtk.create_pixmap_from_xpm_d(
            window.get_window(), style.bg[gtk.STATE_NORMAL],
            WheelbarrowFull_xpm)
        pixmap = gtk.Pixmap(gdk_pixmap, mask)
        pixmap.show()

        # To display the pixmap, we use a fixed widget to place the pixmap
        fixed = gtk.Fixed()
        fixed.set_usize(400, 400)
        fixed.put(pixmap, 100, 100)
        window.add(fixed)
        window.set_background(gtk.gdk.Color(red=0, green=0, blue=0, pixel=0))
        fixed.show()

        # This masks out everything except for the image itself
        #window.shape_combine_mask(mask, 10, 10)
    
if __name__ == "__main__":
    WheelbarrowExample()
    gtk.mainloop()
    
