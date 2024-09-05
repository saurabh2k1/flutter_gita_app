import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gita_app/language_provider.dart';
import 'models.dart';


class ChapterDetailPage extends StatelessWidget {
  final Chapter chapter;

  const ChapterDetailPage({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.isEnglish ? chapter.nameTranslated : chapter.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name Transliterated: ${chapter.nameTransliterated}'),
            Text('Name Translated: ${chapter.nameTranslated}'),
            Text('Name Meaning: ${chapter.nameMeaning}'),
            // const SizedBox(height: 10),
            // Text('Summary: ${chapter.chapterSummary}'),
            const SizedBox(height: 10),
            Text('Summary: ${languageProvider.isEnglish ? chapter.chapterSummary : chapter.chapterSummaryHindi}'),
          ],
        ),
      ),
     
    );
  }
}