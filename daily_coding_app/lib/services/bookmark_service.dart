import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static Future<List<String>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bookmarks') ?? [];
  }

  static Future<List<String>> toggle(
      List<String> current, String id) async {
    final prefs = await SharedPreferences.getInstance();
    current.contains(id) ? current.remove(id) : current.add(id);
    await prefs.setStringList('bookmarks', current);
    return current;
  }
}
