import 'models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'https://bhagavad-gita3.p.rapidapi.com/v2';

  final String apiKey = '080e53c97bmsh638b42174dd0840p185507jsn47f7ce7f09af';
  final String apiHost = 'bhagavad-gita3.p.rapidapi.com';

  Future<List<Chapter>> fetchChapters() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedChapters = prefs.getString('chapters');

    if (cachedChapters != null) {
      List<dynamic> body = jsonDecode(cachedChapters);
      return body.map((dynamic item) => Chapter.fromJson(item)).toList();
    } else {
      final response = await http.get(
        Uri.parse('$baseUrl/chapters/?skip=0&limit=18'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': apiHost,
        },
      );

      if (response.statusCode == 200) {
        prefs.setString('chapters', utf8.decode(response.bodyBytes));
        List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data.map((chapter) => Chapter.fromJson(chapter)).toList();
      } else {
        throw Exception('Failed to load chapters');
      }
    }
  }

  Future<List<Verse>> getVerseByChapter(int chapterId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedVerses = prefs.getString('verses_$chapterId');

    if (cachedVerses != null) {
      List<dynamic> body = jsonDecode(cachedVerses);
      return body.map((dynamic item) => Verse.fromJson(item)).toList();
    } else {
      final response = await http.get(
        Uri.parse('$baseUrl/chapters/$chapterId/verses/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': apiHost,
        },
      );

      if (response.statusCode == 200) {
        prefs.setString('verses_$chapterId', utf8.decode(response.bodyBytes));
        final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
        return body.map((verse) => Verse.fromJson(verse)).toList();
      } else {
        throw Exception('Failed to load verses');
      }
    }
  }
}
