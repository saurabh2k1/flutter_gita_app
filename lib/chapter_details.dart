import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gita_app/api_service.dart';
import 'package:flutter_gita_app/verse_details.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gita_app/language_provider.dart';
import 'models.dart';

class ChapterDetailPage extends StatefulWidget {
  final Chapter chapter;

  const ChapterDetailPage({super.key, required this.chapter});

  @override
  _ChapterDetailPageState createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  late Future<List<Verse>> futureVerses;
  final ApiService apiService = ApiService();
  String _preferredAuthor = '';
  String _preferredCommentAuthor = '';

  @override
  void initState() {
    super.initState();
    futureVerses = apiService.getVerseByChapter(widget.chapter.id);
    _loadPreferredAuthor();
  }

  _loadPreferredAuthor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _preferredAuthor =
          prefs.getString('preferredAuthor') ?? 'Swami Sivananda';
      _preferredCommentAuthor =
          prefs.getString('preferredCommentAuthor') ?? 'Sri Vallabhacharya';
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.isEnglish
            ? widget.chapter.nameTranslated
            : widget.chapter.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Text('Name Transliterated: ${widget.chapter.nameTransliterated}'),
          // Text('Name Translated: ${widget.chapter.nameTranslated}'),
          Text(
            'Name Meaning: ${widget.chapter.nameMeaning}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
              'Summary: ${languageProvider.isEnglish ? widget.chapter.chapterSummary : widget.chapter.chapterSummaryHindi}'),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Verses',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: FutureBuilder<List<Verse>>(
              future: futureVerses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load verses'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No verses found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final verse = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.book),
                          title: Text(' ${verse.text}'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerseDetailsPage(
                                  verse: verse,
                                  preferredAuthor: _preferredAuthor,
                                  commentAuthor: _preferredCommentAuthor,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
