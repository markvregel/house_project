#!/usr/bin/env python

try:
    # for Python2
    from Tkinter import *   ## notice capitalized T in Tkinter 
except ImportError:
    # for Python3
    from tkinter import *   ## notice here too from tkinter import *


register = Tk()
register.title("Index Variables")

def save():
    with open('Output/var_values.txt', 'w') as f:
        f.write("railwayweight %s" %railwayweight.get())
        f.write("\n")
        f.write("roadweight %s" %roadweight.get())
        f.write("\n")
        f.write("childrenboolean %s" %childrenboolean.get())
        f.write("\n")
        f.write("childrenweight %s" %childrenweight.get())
        f.write("\n")
        f.write("elderlyboolean %s" %elderlyboolean.get())
        f.write("\n")
        f.write("elderlyweight %s" %elderlyweight.get())
        f.write("\n")
        f.write("urbanityboolean %s" %urbanityboolean.get())
        f.write("\n")
        f.write("urbanityweight %s" %urbanityweight.get())
        f.write("\n")
        f.write("inconvenienceweight %s" %inconvenienceweight.get())
        f.write("\n")
        f.write("demographicweight %s" %demographicweight.get())
        f.write("\n")
        f.write("facilitiesweight %s" %facilitiesweight.get())
        f.write("\n")
        f.write("ndviweight %s" %ndviweight.get())
        f.write("\n")
        f.write("waterweight %s" %waterweight.get())
        f.write("\n")
        f.write("ptweight %s" %ptweight.get())
    register.quit()
   
Label(register, text ="Do you mind living near a train track? (1-5)").grid(row = 0, column = 0, sticky=W, pady = 3)
Label(register, text ="Do you mind living near a main road? (1-5)").grid(row = 1, column = 0, sticky=W, pady = 3)
Label(register, text ="You want to live surrounded by kids? (TRUE or FALSE)").grid(row = 2, column = 0, sticky=W, pady = 3)
Label(register, text ="How important is this for you? (1-5)").grid(row = 3, column = 0, sticky=W, pady = 3)
Label(register, text ="You want to live surrounded by elderly people? (TRUE or FALSE)").grid(row = 4, column = 0, sticky=W, pady = 3)
Label(register, text ="How important is this for you? (1-5)").grid(row = 5, column = 0, sticky=W, pady = 3)
Label(register, text ="You want to live in a rural area? (TRUE or FALSE)").grid(row = 6, column = 0, sticky=W, pady = 3)
Label(register, text ="How important is this for you? (1-5)").grid(row = 7, column = 0, sticky=W, pady = 3)

Label(register, text ="How important are inconvenience features for you? (1-5)").grid(row = 9, column = 0, sticky=W, pady = 3)
Label(register, text ="How important are demographic features for you? (1-5)").grid(row = 10, column = 0, sticky=W, pady = 3)
Label(register, text ="How important are facilities for you? (1-5)").grid(row = 11, column = 0, sticky=W, pady = 3)
Label(register, text ="How important is a green living environment for you? (1-5)").grid(row = 12, column = 0, sticky=W, pady = 3)
Label(register, text ="How important is living near water for you (1-5)").grid(row = 13, column = 0, sticky=W, pady = 3)
Label(register, text ="How important is living near public transport (1-5)").grid(row = 14, column = 0, sticky=W, pady = 3)
      
railwayweight = StringVar()
roadweight = StringVar()
childrenboolean = StringVar()
childrenweight = StringVar()
elderlyboolean = StringVar()
elderlyweight = StringVar()
urbanityboolean = StringVar()
urbanityweight = StringVar()

inconvenienceweight = StringVar()
demographicweight = StringVar()
facilitiesweight = StringVar()
ndviweight = StringVar()
waterweight = StringVar()
ptweight = StringVar()

e1 = Entry (register, textvariable=railwayweight)
e2 = Entry (register, textvariable=roadweight)
e3 = Entry (register, textvariable=childrenboolean)
e4 = Entry (register, textvariable=childrenweight)
e5 = Entry (register, textvariable=elderlyboolean)
e6 = Entry (register, textvariable=elderlyweight)
e7 = Entry (register, textvariable=urbanityboolean)
e8 = Entry (register, textvariable=urbanityweight)

e9 = Entry (register, textvariable=inconvenienceweight)
e10 = Entry (register, textvariable=demographicweight)
e11 = Entry (register, textvariable=facilitiesweight)
e12 = Entry (register, textvariable=ndviweight)
e13 = Entry (register, textvariable=waterweight)
e14 = Entry (register, textvariable=ptweight)
        
e1.grid(row = 0, column = 1, padx = 3)
e2.grid(row = 1, column = 1, padx = 3)
e3.grid(row = 2, column = 1, padx = 3)
e4.grid(row = 3, column = 1, padx = 3)
e5.grid(row = 4, column = 1, padx = 3)
e6.grid(row = 5, column = 1, padx = 3)
e7.grid(row = 6, column = 1, padx = 3)
e8.grid(row = 7, column = 1, padx = 3)

e9.grid(row = 9, column = 1, padx = 3)
e10.grid(row = 10, column = 1, padx = 3)
e11.grid(row = 11, column = 1, padx = 3)
e12.grid(row = 12, column = 1, padx = 3)
e13.grid(row = 13, column = 1, padx = 3)
e14.grid(row = 14, column = 1, padx = 3)


button1 = Button(register, text = "Write data", command = save)
button1.grid(column=1, sticky=E, pady = 3, padx = 3)
button1.bind("<Button-1>")
           

if __name__ == "__main__":
    register.mainloop()
