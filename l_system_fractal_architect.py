import tkinter as tk
import turtle


# Create main window
root = tk.Tk()
root.title("L-System Fractal Architect")
root.geometry("900x600")


# Create canvas for turtle
canvas = tk.Canvas(root, width=600, height=600)
canvas.pack(side=tk.LEFT)


# Attach turtle to Tkinter canvas
screen = turtle.TurtleScreen(canvas)
screen.bgcolor("white")

t = turtle.RawTurtle(screen)
t.speed(0)
t.hideturtle()


# Placeholder label (we'll replace later)
label = tk.Label(root, text="L-System Controls", font=("Arial", 14))
label.pack(pady=10)


root.mainloop()
