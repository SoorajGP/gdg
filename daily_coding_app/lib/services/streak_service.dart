import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static Future<Map<String, dynamic>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "current": prefs.getInt('currentStreak') ?? 0,
      "longest": prefs.getInt('longestStreak') ?? 0,
      "total": prefs.getInt('totalAttempts') ?? 0,
      "lastDate": prefs.getString('lastDate'),
    };
  }

  static Future<Map<String, int>> update(
      int current, int longest, int total, String? lastDate) async {
    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toIso8601String().split('T')[0];

    if (lastDate != today) {
      current = (lastDate != null &&
              DateTime.now()
                      .difference(DateTime.parse(lastDate))
                      .inDays ==
                  1)
          ? current + 1
          : 1;
      total++;
      if (current > longest) longest = current;

      await prefs.setInt('currentStreak', current);
      await prefs.setInt('longestStreak', longest);
      await prefs.setInt('totalAttempts', total);
      await prefs.setString('lastDate', today);
    }

    return {
      "current": current,
      "longest": longest,
      "total": total,
    };
  }
}
