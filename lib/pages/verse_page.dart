import 'package:flutter/material.dart';
import 'package:flutter_gita_app/generated/l10n.dart';
import 'package:flutter_gita_app/models/verse.dart';
import 'package:flutter_gita_app/services/local_json.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late String selectedAuthor;
  String _title = "";
  
  

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
        _title = '${S.of(context).chapter} $chapterId, ${S.of(context).slok} $verseId';
      });
    });
    setState(() {
      getSelectedAuthor().then((value){
        setState(() {
          selectedAuthor = value;
        });
      });
    });
  }

  Future<String> getSelectedAuthor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedAuthorId')?? 'siva';
  }

  String getTranslations()  {
    switch (selectedAuthor) {
      case 'tej':
        return _verse.tej?.et ?? _verse.tej?.ht ?? '';
      case 'siva':
        return _verse.siva?.et ?? _verse.siva?.ht ?? '';
      case 'purohit':
        return _verse.purohit?.et ?? _verse.purohit?.ht ?? '';
      case 'chinmay':
        return _verse.chinmay?.et ?? _verse.chinmay?.ht ?? '';
      case 'san':
        return _verse.san?.et ?? _verse.san?.ht ?? '';
      case 'adi':
        return _verse.adi?.et ?? _verse.adi?.ht ?? '';
      case 'gambir':
        return _verse.gambir?.et ?? _verse.gambir?.ht ?? '';
      case 'madhav':
        return _verse.madhav?.et ?? _verse.madhav?.ht ?? '';
      case 'anand':
        return _verse.anand?.et ?? _verse.anand?.ht ?? '';
      case 'rams':
        return _verse.rams?.et ?? _verse.rams?.ht ?? '';
      case 'raman':
        return _verse.raman?.et ?? _verse.raman?.ht ?? '';
      case 'abhinav':
        return _verse.abhinav?.et ?? _verse.abhinav?.ht ?? '';
      case 'sankar':
        return _verse.sankar?.et ?? _verse.sankar?.ht ?? '';
      case 'jaya':
        return _verse.jaya?.et ?? _verse.jaya?.ht ?? '';
      case 'vallabh':
        return _verse.vallabh?.et ?? _verse.vallabh?.ht ?? '';
      case 'ms':
        return _verse.ms?.et ?? _verse.ms?.ht ?? '';
      case 'srid':
        return _verse.srid?.et ?? _verse.srid?.ht ?? '';
      case 'dhan':
        return _verse.dhan?.et ?? _verse.dhan?.ht ?? '';
      case 'venkat':
        return _verse.venkat?.et ?? _verse.venkat?.ht ?? '';
      case 'puru':
        return _verse.puru?.et ?? _verse.puru?.ht ?? '';
      case 'neel':
        return _verse.neel?.et ?? _verse.neel?.ht ?? '';
      case 'prabhu':
        return _verse.prabhu?.et ?? _verse.prabhu?.ht ?? '';
      default:
        return 'No translation found';
    }
  }


  String getCommentary()  {
    switch (selectedAuthor) {
      case 'tej':
        return _verse.tej?.ec ?? _verse.tej?.hc ?? '';
      case 'siva':
        return _verse.siva?.ec ?? _verse.siva?.hc ?? '';
      case 'purohit':
        return _verse.purohit?.ec ?? _verse.purohit?.hc ?? '';
      case 'chinmay':
        return _verse.chinmay?.ec ?? _verse.chinmay?.hc ?? '';
      case 'san':
        return _verse.san?.ec ?? _verse.san?.hc ?? '';
      case 'adi':
        return _verse.adi?.ec ?? _verse.adi?.hc ?? '';
      case 'gambir':
        return _verse.gambir?.ec ?? _verse.gambir?.hc ?? '';
      case 'madhav':
        return _verse.madhav?.ec ?? _verse.madhav?.hc ?? '';
      case 'anand':
        return _verse.anand?.ec ?? _verse.anand?.hc ?? '';
      case 'rams':
        return _verse.rams?.ec ?? _verse.rams?.hc ?? '';
      case 'raman':
        return _verse.raman?.ec ?? _verse.raman?.hc ?? '';
      case 'abhinav':
        return _verse.abhinav?.ec ?? _verse.abhinav?.hc ?? '';
      case 'sankar':
        return _verse.sankar?.ec ?? _verse.sankar?.hc ?? '';
      case 'jaya':
        return _verse.jaya?.ec ?? _verse.jaya?.hc ?? '';
      case 'vallabh':
        return _verse.vallabh?.ec ?? _verse.vallabh?.hc ?? '';
      case 'ms':
        return _verse.ms?.ec ?? _verse.ms?.hc ?? '';
      case 'srid':
        return _verse.srid?.ec ?? _verse.srid?.hc ?? '';
      case 'dhan':
        return _verse.dhan?.ec ?? _verse.dhan?.hc ?? '';
      case 'venkat':
        return _verse.venkat?.ec ?? _verse.venkat?.hc ?? '';
      case 'puru':
        return _verse.puru?.ec ?? _verse.puru?.hc ?? '';
      case 'neel':
        return _verse.neel?.ec ?? _verse.neel?.hc ?? '';
      case 'prabhu':
        return _verse.prabhu?.ec ?? _verse.prabhu?.hc ?? '';
      default:
        return 'No commentary found';
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
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
                        '${S.of(context).translations} :', 
                        style: const TextStyle(
                          fontSize: 20.0, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.teal,
                        ),
                      ),
                      Text(getTranslations()),
                      const SizedBox(height: 16.0),
                      Text('${S.of(context).commentary} :'),
                      // const SizedBox(height: 16.0),
                      Text(getCommentary()),
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
