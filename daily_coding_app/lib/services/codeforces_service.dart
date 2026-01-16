import 'dart:convert';
import 'package:http/http.dart' as http;

class CodeforcesService {
  static Future<Map<String, dynamic>?> fetchProblem() async {
    final uri =
        Uri.parse('https://codeforces.com/api/problemset.problems');

    final response = await http.get(uri);

    if (response.statusCode != 200) return null;

    final decoded = jsonDecode(response.body);

    if (decoded['status'] != 'OK') return null;

    final problems = decoded['result']['problems'] as List;

    // Only problems with rating
    final filtered =
        problems.where((p) => p['rating'] != null).toList();

    filtered.shuffle();
    final p = filtered.first;

    return {
      'name': p['name'],
      'rating': p['rating'],
      'tags': List<String>.from(p['tags']),
      'url':
          'https://codeforces.com/problemset/problem/${p['contestId']}/${p['index']}',
    };
  }
}
