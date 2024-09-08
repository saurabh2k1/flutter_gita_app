import 'package:flutter/material.dart';
import 'package:flutter_gita_app/models/chapter.dart';
import 'package:flutter_gita_app/pages/verse_page.dart';

class ChapterPage extends StatefulWidget {
  final Chapter chapter;

  const ChapterPage({Key? key, required this.chapter}) : super(key: key);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(' अध्याय ${widget.chapter.chapterNumber.toString()}'),
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
                SelectableText(widget.chapter.meaning['hi'] ?? ''),
                SelectableText(widget.chapter.meaning['en'] ?? ''),
                SelectableText(widget.chapter.summary['hi'] ?? ''),
                SelectableText(widget.chapter.summary['en'] ?? ''),
                const SizedBox(
                  height: 16.0,
                ),
                const Text("All Shloka[श्लोक]",
                    style: TextStyle(fontSize: 32.0, color: Colors.orange)),
                ListView.builder(
                  itemCount: widget.chapter.versesCount,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
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
                      title: Text('श्लोक  -   ${index + 1}'),
                      trailing: const Text('Read [ पढे ]'),
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
