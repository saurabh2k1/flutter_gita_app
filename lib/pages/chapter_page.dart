import 'package:flutter/material.dart';
import 'package:flutter_gita_app/generated/l10n.dart';
import 'package:flutter_gita_app/models/chapter.dart';
import 'package:flutter_gita_app/pages/verse_page.dart';
import 'package:flutter_gita_app/services/language_provider.dart';
import 'package:provider/provider.dart';

class ChapterPage extends StatefulWidget {
  final Chapter chapter;

  const ChapterPage({super.key, required this.chapter});
  @override
  // ignore: library_private_types_in_public_api
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('${S.of(context).chapter}  ${widget.chapter.chapterNumber.toString()}'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectableText(
                  widget.chapter.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SelectableText(widget.chapter.translation),
                SelectableText(widget.chapter.meaning[languageProvider.locale.languageCode] ?? ''),
                SelectableText(widget.chapter.summary[languageProvider.locale.languageCode] ?? ''),
                const SizedBox(
                  height: 16.0,
                ),
                Text(S.of(context).slok,
                    style: const TextStyle(fontSize: 32.0, color: Colors.orange)),
                ListView.builder(
                  itemCount: widget.chapter.versesCount,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return VersePage(
                                      chapterId: widget.chapter.chapterNumber,
                                      verseId: index + 1,
                                    );
                                  }));
                        },
                        tileColor: Colors.orangeAccent,
                        title: Text('${S.of(context).slok}  -   ${index + 1}', 
                          style: const TextStyle(
                            fontSize: 18.0, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.brown),
                        ),
                        trailing: Text(S.of(context).read, 
                          style: const TextStyle(
                            fontSize: 18.0, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.brown),
                        ),
                        ),

                    );
                  },
                ),
                // Image(image: image)
              ],
            ),
          ),
        ));
  }
}
