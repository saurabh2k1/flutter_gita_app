import 'package:flutter/material.dart';

import 'package:flutter_gita_app/language_provider.dart';
import 'package:flutter_gita_app/models.dart';
import 'package:provider/provider.dart';

class VerseDetailsPage extends StatelessWidget {
  final Verse verse;
  final String preferredAuthor;
  final String commentAuthor;

  const VerseDetailsPage({
    super.key,
    required this.verse,
    required this.preferredAuthor,
    required this.commentAuthor,
  });

  @override
  Widget build(BuildContext context) {
    // final languageProvider = Provider.of<LanguageProvider>(context);

    final preferredTranslation = verse.translations
        .firstWhere((translation) => translation.authorName == preferredAuthor);
    final preferredCommentary = verse.commentaries
        .firstWhere((commentary) => commentary.authorName == commentAuthor);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${verse.chapterNumber}.${verse.verseNumber}',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  verse.text,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(fontSize: 18, color: Colors.deepOrange),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('*********** Transliteration ***********'),
                Text(
                  verse.transliteration,
                  style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.amber),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('*********** Word Meaning ***********'),
                Text(verse.wordMeanings,
                    style: const TextStyle(
                      fontSize: 18,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text('*********** Translation ***********'),
                Text(
                  preferredTranslation.description,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '- ${preferredTranslation.authorName}',
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('*********** Commentory ***********'),
                Text(preferredCommentary.language),
                Text(
                  preferredCommentary.description,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '- ${preferredCommentary.authorName}',
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        )));
  }
}
