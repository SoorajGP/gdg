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

def expand_l_system(axiom, rules, iterations):
    current = axiom

    for _ in range(iterations):
        next_string = ""
        for char in current:
            if char in rules:
                next_string += rules[char]
            else:
                next_string += char
        current = next_string

    return current

def parse_rules(rules_text):
    rules = {}
    parts = rules_text.split(",")

    for part in parts:
        if "=" in part:
            key, value = part.split("=")
            rules[key.strip()] = value.strip()

    return rules

def generate_fractal():
    t.clear()
    t.penup()
    t.goto(0, 0)
    t.setheading(0)
    t.pendown()

    axiom = axiom_entry.get()
    rules_text = rules_entry.get()
    angle = float(angle_entry.get())
    iterations = int(iterations_entry.get())

    rules = parse_rules(rules_text)
    final_string = expand_l_system(axiom, rules, iterations)

    draw_l_system(final_string, angle)

def draw_l_system(instructions, angle, step=5):
    stack = []
    length = len(instructions)

    screen.tracer(0, 0)  # Real-time optimization
    t.penup()
    t.goto(0, 0)
    t.setheading(90)  # Better for tree-like structures
    t.pendown()

    for i, char in enumerate(instructions):

        # 🌈 Recursive Gradient (explained below)
        color_ratio = i / length
        t.pencolor(color_ratio, 0.6, 1 - color_ratio)

        if char == "F":
            t.forward(step)

        elif char == "+":
            t.right(angle)

        elif char == "-":
            t.left(angle)

        elif char == "[":
            # Save state
            stack.append((t.position(), t.heading()))

        elif char == "]":
            # Restore state
            position, heading = stack.pop()
            t.penup()
            t.goto(position)
            t.setheading(heading)
            t.pendown()

    screen.update()





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
generate_btn = tk.Button(controls, text="Generate Fractal", command=generate_fractal)
generate_btn.pack(pady=20)



root.mainloop()
