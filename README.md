# L-System Fractal Architect

This project is an implementation of a Lindenmayer System (L-System) fractal generator built as part of **GDG Recruitments 2026** under the **Python** domain.

The application allows users to define an axiom, production rules, angle, and number of iterations, and visualizes the resulting fractal using Turtle Graphics embedded inside a Tkinter GUI.

---

## Features

- Interactive Tkinter-based user interface
- Turtle graphics rendered inside a Tkinter canvas
- Parallel L-system string expansion
- Customizable axiom, rules, angle, and iterations
- Branching support using push/pop turtle state (`[` and `]`)
- Recursive color gradient for visual depth
- Optimized rendering for large L-system strings

---

## How It Works

1. The user provides:
   - An initial axiom
   - Production rules (e.g., `F=F+F-F-F+F`)
   - Rotation angle
   - Number of iterations
2. The L-system expansion function applies rules iteratively using parallel rewriting.
3. The final expanded string is interpreted using turtle commands:
   - `F` → Move forward
   - `+` → Turn right
   - `-` → Turn left
4. The fractal is rendered on the canvas.

---

## Tech Stack

- Python 3
- Tkinter
- Turtle Graphics

---




Sooraj G P
VIT Vellore


