import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const DailyCodingApp());
}

/// ROOT APP
class DailyCodingApp extends StatelessWidget {
  const DailyCodingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuestionScreen(),
    );
  }
}

/// QUESTION MODEL
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

  int currentStreak = 0;
  String? lastAttemptDate;

  /// QUESTION BANK
  final List<CodingQuestion> questions = [
    CodingQuestion(
      title: "Reverse a String",
      description: "Write logic to reverse a given string.",
      difficulty: "Easy",
      topic: "Strings",
      solution:
          "Use two pointers at start and end.\n"
          "Swap characters until pointers meet.\n"
          "Time Complexity: O(n)",
    ),
    CodingQuestion(
      title: "Find Maximum Element",
      description: "Find the maximum element in an array.",
      difficulty: "Easy",
      topic: "Arrays",
      solution:
          "Initialize max with first element.\n"
          "Traverse array and update max.\n"
          "Time Complexity: O(n)",
    ),
    CodingQuestion(
      title: "Check Palindrome",
      description: "Check whether a string is a palindrome.",
      difficulty: "Medium",
      topic: "Strings",
      solution:
          "Compare characters from start and end.\n"
          "If mismatch, not a palindrome.\n"
          "Time Complexity: O(n)",
    ),
  ];

  late CodingQuestion todayQuestion;

  @override
  void initState() {
    super.initState();
    todayQuestion = getTodayQuestion();
    loadStreak();
  }

  /// 🔹 DAILY ROTATION
  CodingQuestion getTodayQuestion() {
    DateTime now = DateTime.now();
    int dayNumber = now.year * 1000 + now.month * 50 + now.day;
    int index = dayNumber % questions.length;
    return questions[index];
  }

  /// 🔹 LOAD STREAK FROM LOCAL STORAGE
  Future<void> loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentStreak = prefs.getInt('streak') ?? 0;
      lastAttemptDate = prefs.getString('lastDate');
    });
  }

  /// 🔹 UPDATE STREAK ON SUBMIT
  Future<void> updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toIso8601String().split('T')[0];

    if (lastAttemptDate == today) return;

    if (lastAttemptDate != null) {
      DateTime last = DateTime.parse(lastAttemptDate!);
      DateTime now = DateTime.now();

      if (now.difference(last).inDays == 1) {
        currentStreak++;
      } else {
        currentStreak = 1;
      }
    } else {
      currentStreak = 1;
    }

    lastAttemptDate = today;

    await prefs.setInt('streak', currentStreak);
    await prefs.setString('lastDate', today);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Coding Question"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// STREAK DISPLAY
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "🔥 Current Streak: $currentStreak days",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

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
                  : () async {
                      setState(() {
                        submitted = true;
                      });
                      await updateStreak();
                      setState(() {});
                    },
              child: const Text("Submit Answer"),
            ),

            const SizedBox(height: 20),

            /// SOLUTION
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
