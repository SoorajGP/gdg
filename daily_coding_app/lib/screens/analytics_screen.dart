import 'package:flutter/material.dart';
import '../models/coding_question.dart';
import '../widgets/stat_card.dart';

class AnalyticsScreen extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;
  final int totalAttempts;
  final List<String> bookmarkedIds;
  final List<CodingQuestion> questions;

  const AnalyticsScreen({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalAttempts,
    required this.bookmarkedIds,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final bookmarkedQuestions = questions
        .where((q) => bookmarkedIds.contains(q.id))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Progress",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          StatCard("🔥 Current Streak", "$currentStreak days"),
          StatCard("🏆 Longest Streak", "$longestStreak days"),
          StatCard("✅ Total Attempts", "$totalAttempts"),

          const SizedBox(height: 24),
          const Text(
            "Bookmarked Questions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          if (bookmarkedQuestions.isEmpty)
            const Text("No bookmarks yet."),

          for (final q in bookmarkedQuestions)
            Card(
              child: ListTile(
                title: Text(q.title),
                subtitle: Text("${q.difficulty} • ${q.topic}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              q.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(q.description),
                            const SizedBox(height: 16),
                            const Text(
                              "Solution",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(q.solution),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
