import 'dart:convert';
import 'dart:math';
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

  Future<Verse> getRandomVerse() async {
    const int totalChapters = 18;
    final int randomChapterNumber = Random().nextInt(totalChapters) + 1;

    final String chapterResponse = await rootBundle
        .loadString('chapter/bhagavadgita_chapter_$randomChapterNumber.json');
    Map<String, dynamic> chapterData = json.decode(chapterResponse);
    int versesCount = chapterData['verses_count'];

    final randomVerseNumber = Random().nextInt(versesCount) + 1;
    final String verseResponse = await rootBundle.loadString(
        'slok/bhagavadgita_chapter_${randomChapterNumber}_slok_$randomVerseNumber.json');
    Map<String, dynamic> verseData = json.decode(verseResponse);
    return Verse.fromJson(verseData);
  }
}
