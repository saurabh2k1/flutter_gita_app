import 'package:flutter/material.dart';
import 'package:flutter_gita_app/models/verse.dart';
import 'package:flutter_gita_app/services/local_json.dart';

class VersePage extends StatefulWidget {
  final int chapterId;
  final int verseId;

  const VersePage({super.key, required this.chapterId, required this.verseId});

  @override
  // ignore: library_private_types_in_public_api
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  late Verse _verse;
  bool _isLoading = true;
  final LocalJsonService localJsonService = LocalJsonService();

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _loadVerse(widget.chapterId, widget.verseId);
  }

  _loadVerse(int chapterId, int verseId) {
    setState(() {
      _isLoading = true;
    });
    localJsonService.fetchVerse(chapterId, verseId).then((value) {
      setState(() {
        _verse = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter ${_verse.chapter}, Verse ${_verse.verse}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to next Slok',
            onPressed: () {
              // Refresh the page with next slok
              _loadVerse(_verse.chapter?? 1, _verse.verse! + 1);
            },
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: _isLoading
            ? const Center(
                child: SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.deepPurple,
                    strokeWidth: 4.0,
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SelectableText(
                        _verse.slok ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.orange.shade900, fontSize: 20.0),
                      ),
                      const SizedBox(height: 16.0),
                      Text(_verse.transliteration ?? ' ',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.deepPurple, fontSize: 16.0)),
                      const SizedBox(height: 16.0),
                      Text(
                        _verse.tej!.ht ?? ' ',
                      ),
                      const SizedBox(height: 16.0),
                      Text(_verse.siva!.et ?? ' '),
                      const SizedBox(height: 16.0),
                      Text(_verse.rams!.hc ?? ' '),
                      const SizedBox(height: 16.0),
                      Text(_verse.siva!.ec ?? ' '),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
              // Refresh the page with next slok
              _loadVerse(_verse.chapter?? 1, _verse.verse! + 1);
            },
        child: const Icon(Icons.navigate_next_rounded),
      ),
    );
  }
}
