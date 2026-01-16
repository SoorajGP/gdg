import 'package:flutter/material.dart';

import '../data/question_bank.dart';
import '../services/streak_service.dart';
import '../services/bookmark_service.dart';
import 'question_screen.dart';
import 'analytics_screen.dart';

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

  List<String> bookmarkedIds = [];

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    final stats = await StreakService.load();
    final bookmarks = await BookmarkService.load();

    setState(() {
      currentStreak = stats["current"];
      longestStreak = stats["longest"];
      totalAttempts = stats["total"];
      lastAttemptDate = stats["lastDate"];
      bookmarkedIds = bookmarks;
    });
  }

  Future<void> onSubmit() async {
    final updated = await StreakService.update(
      currentStreak,
      longestStreak,
      totalAttempts,
      lastAttemptDate,
    );

    setState(() {
      currentStreak = updated["current"]!;
      longestStreak = updated["longest"]!;
      totalAttempts = updated["total"]!;
      lastAttemptDate =
          DateTime.now().toIso8601String().split('T')[0];
    });
  }

  Future<void> onToggleBookmark(String id) async {
    final updated =
        await BookmarkService.toggle(bookmarkedIds, id);
    setState(() {
      bookmarkedIds = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          QuestionScreen(
            questions: questionBank,
            bookmarkedIds: bookmarkedIds,
            onSubmit: onSubmit,
            onToggleBookmark: onToggleBookmark,
          ),
          AnalyticsScreen(
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            totalAttempts: totalAttempts,
            bookmarkedIds: bookmarkedIds,
            questions: questionBank,
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
