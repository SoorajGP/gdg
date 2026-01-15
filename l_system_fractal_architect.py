import tkinter as tk
import turtle


# ----------------- Main Window -----------------
root = tk.Tk()
root.title("L-System Fractal Architect")
root.geometry("900x600")


# ----------------- Canvas -----------------
canvas = tk.Canvas(root, width=600, height=600)
canvas.pack(side=tk.LEFT)

screen = turtle.TurtleScreen(canvas)
screen.bgcolor("white")

t = turtle.RawTurtle(screen)
t.speed(0)
t.hideturtle()


# ----------------- Control Panel -----------------
controls = tk.Frame(root)
controls.pack(side=tk.RIGHT, fill=tk.BOTH, padx=10, pady=10)

title = tk.Label(controls, text="L-System Controls", font=("Arial", 16))
title.pack(pady=10)


# Axiom input
tk.Label(controls, text="Axiom:").pack(anchor="w")
axiom_entry = tk.Entry(controls)
axiom_entry.insert(0, "F")
axiom_entry.pack(fill=tk.X, pady=5)


# Rules input
tk.Label(controls, text="Rules (Format: F=F+F-F-F+F):").pack(anchor="w")
rules_entry = tk.Entry(controls)
rules_entry.insert(0, "F=F+F-F-F+F")
rules_entry.pack(fill=tk.X, pady=5)


# Angle input
tk.Label(controls, text="Angle (degrees):").pack(anchor="w")
angle_entry = tk.Entry(controls)
angle_entry.insert(0, "90")
angle_entry.pack(fill=tk.X, pady=5)


# Iterations input
tk.Label(controls, text="Iterations:").pack(anchor="w")
iterations_entry = tk.Entry(controls)
iterations_entry.insert(0, "2")
iterations_entry.pack(fill=tk.X, pady=5)


# Generate button (logic will be added next)
generate_btn = tk.Button(controls, text="Generate Fractal")
generate_btn.pack(pady=20)


root.mainloop()
