import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_gita_app/models/chapter.dart';
import 'package:flutter_gita_app/models/verse.dart';

class LocalJsonService {
  Future<List<Chapter>> fetchAllChapters() async {
    List<Chapter> chapters = [];
    for (int i = 1; i <= 18; i++) {
      final String response =
          await rootBundle.loadString('chapter/bhagavadgita_chapter_$i.json');
      Map<String, dynamic> data = json.decode(response);
      chapters.add(Chapter.fromJson(data));
    }
    return chapters;
  }

  Future<Verse> fetchVerse(int chapterID, int verseId) async {
    final String response = await rootBundle.loadString(
        'slok/bhagavadgita_chapter_${chapterID}_slok_$verseId.json');
    Map<String, dynamic> data = json.decode(response);
    return Verse.fromJson(data);
  }
}
