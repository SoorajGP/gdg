import 'package:flutter/material.dart';

void main() {
  runApp(const DailyCodingApp());
}

/// ROOT APP
class DailyCodingApp extends StatelessWidget {
  const DailyCodingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Coding Question',
      home: const QuestionScreen(),
    );
  }
}

/// DATA MODEL (QUESTION STRUCTURE)
class CodingQuestion {
  final String title;
  final String description;
  final String solution;
  final String difficulty;
  final String topic;

  CodingQuestion({
    required this.title,
    required this.description,
    required this.solution,
    required this.difficulty,
    required this.topic,
  });
}

/// MAIN SCREEN
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool submitted = false;
  String userAnswer = "";

  // 🔹 TODAY'S QUESTION (Later this will come from Firebase)
  final CodingQuestion todayQuestion = CodingQuestion(
    title: "Reverse a String",
    description: "Given a string, write logic to reverse it.",
    difficulty: "Easy",
    topic: "Strings",
    solution:
        "Initialize two pointers at start and end.\n"
        "Swap characters while moving pointers inward.\n"
        "Stop when pointers meet.\n\n"
        "Time Complexity: O(n)\n"
        "Space Complexity: O(1)",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Coding Question"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Text(
              todayQuestion.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// TAGS
            Row(
              children: [
                Chip(label: Text(todayQuestion.difficulty)),
                const SizedBox(width: 8),
                Chip(label: Text(todayQuestion.topic)),
              ],
            ),

            const SizedBox(height: 16),

            /// DESCRIPTION
            Text(
              todayQuestion.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            /// ANSWER INPUT
            TextField(
              enabled: !submitted,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Your Answer / Pseudo-code",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                userAnswer = value;
              },
            ),

            const SizedBox(height: 20),

            /// SUBMIT BUTTON
            ElevatedButton(
              onPressed: submitted
                  ? null
                  : () {
                      setState(() {
                        submitted = true;
                      });
                    },
              child: const Text("Submit Answer"),
            ),

            const SizedBox(height: 20),

            /// SOLUTION (VISIBLE ONLY AFTER SUBMIT)
            if (submitted)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Solution:\n\n${todayQuestion.solution}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
