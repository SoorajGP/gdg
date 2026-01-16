import '../models/coding_question.dart';

final List<CodingQuestion> questionBank = [
  CodingQuestion(
    id: "reverse_string",
    title: "Reverse a String",
    description: "Write logic to reverse a string.",
    difficulty: "Easy",
    topic: "Strings",
    solution:
        "Use two pointers.\nSwap characters.\nTime Complexity: O(n)",
  ),
  CodingQuestion(
    id: "max_element",
    title: "Find Maximum Element",
    description: "Find the maximum element in an array.",
    difficulty: "Easy",
    topic: "Arrays",
    solution:
        "Traverse array and track max.\nTime Complexity: O(n)",
  ),
  CodingQuestion(
    id: "fibonacci",
    title: "Fibonacci Sequence",
    description: "Generate Fibonacci sequence up to n terms.",
    difficulty: "Medium",
    topic: "Recursion",
    solution:
        "Use recursion or iteration.\nTime Complexity: O(n)",
  ),
  CodingQuestion(
    id: "balanced_parentheses",
    title: "Balanced Parentheses",
    description: "Check if parentheses in a string are balanced.",
    difficulty: "Medium",
    topic: "Stacks",
    solution:
        "Use stack to track opening parentheses.\nTime Complexity: O(n)",
  ),
  CodingQuestion(
    id: "dijkstra_algorithm",
    title: "Dijkstra's Algorithm",
    description: "Find shortest path in a weighted graph.",
    difficulty: "Hard",
    topic: "Graphs",
    solution:
        "Use priority queue to explore shortest paths.\nTime Complexity: O((V + E) log V)",
  ),
];
  