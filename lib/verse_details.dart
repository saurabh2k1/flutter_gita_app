import 'package:flutter/material.dart';

import 'package:flutter_gita_app/language_provider.dart';
import 'package:flutter_gita_app/models.dart';
import 'package:provider/provider.dart';

class VerseDetailsPage extends StatelessWidget {
  final Verse verse;

  const VerseDetailsPage({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
        appBar: AppBar(),
        body: Center(
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
                style: const TextStyle(fontSize: 18, color: Colors.deepOrange),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('*********** Transliteration ***********'),
              Text(
                verse.transliteration,
                style: const TextStyle(fontSize: 18, color: Colors.amber),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
