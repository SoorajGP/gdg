import 'package:flutter/material.dart';
import '../models/coding_question.dart';
import '../widgets/stat_card.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';


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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Your Progress",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () async {
                  await AuthService.signOut();
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ],
          ),
          const SizedBox(height: 16),


          

          FutureBuilder(
            future: LocalStorageService.getStats(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = snapshot.data as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        StatCard(
                          "Current Streak",
                          data['currentStreak'].toString(),
                        ),
                        StatCard(
                          "Longest Streak",
                          data['longestStreak'].toString(),
                        ),
                        StatCard(
                          "Total Attempts",
                          data['totalAttempts'].toString(),
                        ),
                      ],
                    ),
                ),
              );
            },
          ),



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
