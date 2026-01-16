import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _currentStreak = 'currentStreak';
  static const _longestStreak = 'longestStreak';
  static const _totalAttempts = 'totalAttempts';
  static const _lastAttemptDate = 'lastAttemptDate';
  static const _bookmarks = 'bookmarks';

  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // ---------- STATS ----------

  static Future<Map<String, dynamic>> getStats() async {
    final p = await _prefs;
    return {
      'currentStreak': p.getInt(_currentStreak) ?? 0,
      'longestStreak': p.getInt(_longestStreak) ?? 0,
      'totalAttempts': p.getInt(_totalAttempts) ?? 0,
      'lastAttemptDate': p.getString(_lastAttemptDate),
    };
  }

  static Future<void> updateStats({
    required int current,
    required int longest,
    required int total,
    required String lastDate,
  }) async {
    final p = await _prefs;
    await p.setInt(_currentStreak, current);
    await p.setInt(_longestStreak, longest);
    await p.setInt(_totalAttempts, total);
    await p.setString(_lastAttemptDate, lastDate);
  }

  // ---------- BOOKMARKS ----------

  static Future<List<String>> getBookmarks() async {
    final p = await _prefs;
    return p.getStringList(_bookmarks) ?? [];
  }

  static Future<void> toggleBookmark(String id) async {
    final p = await _prefs;
    final list = p.getStringList(_bookmarks) ?? [];
    list.contains(id) ? list.remove(id) : list.add(id);
    await p.setStringList(_bookmarks, list);
  }

  static Future<bool> isBookmarked(String id) async {
    final list = await getBookmarks();
    return list.contains(id);
  }
}
