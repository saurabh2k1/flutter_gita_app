import 'package:flutter/material.dart';
import 'package:flutter_gita_app/language_provider.dart';
import 'package:flutter_gita_app/pages/chapter_page.dart';
import 'package:flutter_gita_app/services/local_json.dart';
import 'package:provider/provider.dart';

class ChapterListWidget extends StatelessWidget {
  final LocalJsonService jsonService = LocalJsonService();

  ChapterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return FutureBuilder(
        future: jsonService.fetchAllChapters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load chapters'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No Chapter found'));
          } else {
            final chapters = snapshot.data!;
            return ListView.builder(
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  final chapter = chapters[index];
                  final selectedLanguage =
                      languageProvider.isEnglish ? 'en' : 'hi';
                  String nameMeaning = chapter.meaning[selectedLanguage] ??
                      chapter.meaning['en'] as String;
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange.shade900,
                        child: Text('${chapter.chapterNumber}'),
                      ),
                      title: Text(
                        languageProvider.isEnglish
                            ? chapter.translation
                            : chapter.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent.shade700),
                      ),
                      subtitle: Text(
                        '$nameMeaning - : ${chapter.summary[selectedLanguage]}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChapterPage(
                                chapter: chapter,
                              ),
                            ));
                      },
                    ),
                  );
                });
          }
        });
  }
}
