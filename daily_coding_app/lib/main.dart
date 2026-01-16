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
      home: HomeShell(),
    );
  }
}

/// HOME SHELL
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int selectedIndex = 0;

  int currentStreak = 0;
  int longestStreak = 0;
  int totalAttempts = 0;
  String? lastAttemptDate;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentStreak = prefs.getInt('currentStreak') ?? 0;
      longestStreak = prefs.getInt('longestStreak') ?? 0;
      totalAttempts = prefs.getInt('totalAttempts') ?? 0;
      lastAttemptDate = prefs.getString('lastDate');
    });
  }

  Future<void> updateStats() async {
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

    totalAttempts++;
    longestStreak =
        currentStreak > longestStreak ? currentStreak : longestStreak;
    lastAttemptDate = today;

    await prefs.setInt('currentStreak', currentStreak);
    await prefs.setInt('longestStreak', longestStreak);
    await prefs.setInt('totalAttempts', totalAttempts);
    await prefs.setString('lastDate', today);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          QuestionScreen(onSubmit: updateStats),
          AnalyticsScreen(
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            totalAttempts: totalAttempts,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) => setState(() => selectedIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: "Question",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: "Analytics",
          ),
        ],
      ),
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

/// QUESTION SCREEN
class QuestionScreen extends StatefulWidget {
  final Future<void> Function() onSubmit;

  const QuestionScreen({super.key, required this.onSubmit});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool submitted = false;

  final List<CodingQuestion> questions = [
    CodingQuestion(
      title: "Reverse a String",
      description: "Write logic to reverse a string.",
      difficulty: "Easy",
      topic: "Strings",
      solution:
          "Use two pointers.\nSwap characters.\nTime Complexity: O(n)",
    ),
    CodingQuestion(
      title: "Find Maximum Element",
      description: "Find the maximum element in an array.",
      difficulty: "Easy",
      topic: "Arrays",
      solution:
          "Iterate through array and track max.\nTime Complexity: O(n)",
    ),
  ];

  late CodingQuestion todayQuestion;

  @override
  void initState() {
    super.initState();
    todayQuestion = getTodayQuestion();
  }

  CodingQuestion getTodayQuestion() {
    DateTime now = DateTime.now();
    int value = now.year * 1000 + now.month * 50 + now.day;
    return questions[value % questions.length];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todayQuestion.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(label: Text(todayQuestion.difficulty)),
                      const SizedBox(width: 8),
                      Chip(label: Text(todayQuestion.topic)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(todayQuestion.description),
                  const SizedBox(height: 20),

                  const SizedBox(height: 16),

                  Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Attempt",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        enabled: !submitted,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: "Write your answer or pseudo-code here",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),


                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: submitted
                        ? null
                        : () async {
                            setState(() => submitted = true);
                            await widget.onSubmit();
                          },
                    child: const Text("Submit Answer"),
                  ),
                  if (submitted) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(todayQuestion.solution),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ANALYTICS SCREEN (CLEAN & MEANINGFUL)
class AnalyticsScreen extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;
  final int totalAttempts;

  const AnalyticsScreen({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalAttempts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Progress",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          _StatCard(
            icon: Icons.local_fire_department,
            label: "Current Streak",
            value: "$currentStreak days",
            color: Colors.orange,
          ),

          _StatCard(
            icon: Icons.emoji_events,
            label: "Longest Streak",
            value: "$longestStreak days",
            color: Colors.blue,
          ),

          _StatCard(
            icon: Icons.check_circle,
            label: "Total Days Attempted",
            value: "$totalAttempts",
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

/// REUSABLE STAT CARD 
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
