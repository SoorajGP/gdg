import 'package:flutter/material.dart';
import '../models/coding_question.dart';
import '../services/local_storage_service.dart';


class QuestionScreen extends StatefulWidget {
  final List<CodingQuestion> questions;
  final List<String> bookmarkedIds;
  final Future<void> Function() onSubmit;
  final Future<void> Function(String) onToggleBookmark;

  const QuestionScreen({
    super.key,
    required this.questions,
    required this.bookmarkedIds,
    required this.onSubmit,
    required this.onToggleBookmark,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool submitted = false;
  late CodingQuestion todayQuestion;

  @override
  void initState() {
    super.initState();
    todayQuestion = _getTodayQuestion();
  }

  CodingQuestion _getTodayQuestion() {
    final now = DateTime.now();
    final index = (now.year * 1000 + now.day) % widget.questions.length;
    return widget.questions[index];
  }

  @override
  Widget build(BuildContext context) {
    final isBookmarked =
        widget.bookmarkedIds.contains(todayQuestion.id);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      todayQuestion.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                    ),
                    onPressed: () async {
                        await widget.onToggleBookmark(todayQuestion.id);
                        setState(() {});
                      },

                  ),
                ],
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

              TextField(
                enabled: !submitted,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Your Attempt",
                  border: OutlineInputBorder(),
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
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(todayQuestion.solution),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
