import 'models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://bhagavad-gita3.p.rapidapi.com/v2/chapters/?skip=0&limit=18'; // Replace with your API URL
  final String apiKey = '080e53c97bmsh638b42174dd0840p185507jsn47f7ce7f09af'; // Replace with your API key
  final String apiHost = 'bhagavad-gita3.p.rapidapi.com';
  
  Future<List<Chapter>> fetchChapters() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-rapidapi-key': apiKey,
        'x-rapidapi-host': apiHost,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((chapter) => Chapter.fromJson(chapter)).toList();
    } else {
      throw Exception('Failed to load chapters');
    }
  }
}