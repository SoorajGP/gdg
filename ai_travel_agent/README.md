# AI-Based Travel Planning Agent

This project implements an AI-powered travel planning agent as part of **GDG Recruitments – AI/ML Domain**.

The agent accepts natural language input, reasons step-by-step, invokes tools to assist planning, and produces a structured travel itinerary for the user.

---

## Agent Architecture

The system follows an **agent-based architecture** implemented using **LangChain**.

### Agent Flow
1. User provides travel requirements in natural language.
2. The agent reasons about user preferences (location, duration, budget, interests).
3. The agent invokes tools to:
   - Fetch relevant attractions
   - Build a day-wise itinerary
4. The final output is returned as a structured travel plan.

---

## Tools Used

- **Get Attractions Tool**
  - Returns attractions based on location and interests.
- **Build Itinerary Tool**
  - Generates a day-wise travel plan using the selected attractions.

These tools are implemented as Python functions and invoked by the agent during reasoning.

---

## Reasoning Strategy

The agent uses a step-by-step reasoning approach (simulated using a Fake LLM) to decide:
- Which tool to call
- In what order
- How to combine tool outputs into a final itinerary

This demonstrates agentic planning and tool-based reasoning without reliance on external APIs.

---

## Sample Output

```json
{
  "location": "Jaipur",
  "duration": "3 days",
  "budget": "Low",
  "interests": ["History"],
  "itinerary": {
    "Day 1": ["Amber Fort", "Hawa Mahal"],
    "Day 2": ["City Palace", "Jantar Mantar"],
    "Day 3": ["Local sightseeing"]
  }
}
```

---

## Tech Stack
- Python
- LangChain
- Agent-based architecture with tool calling

## Environment Note

- This project was developed using Python 3.13.
Due to experimental NumPy builds on Windows for this Python version, non-fatal runtime warnings may appear during execution. These warnings do not affect the agent logic, tool execution, or output generation.