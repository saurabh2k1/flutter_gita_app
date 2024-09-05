import 'package:flutter/material.dart';
import 'package:flutter_gita_app/language_provider.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'api_service.dart';
import 'chapter_details.dart';

class ChapterList extends StatefulWidget {
  const ChapterList({super.key});

  @override
  _ChapterListState createState() => _ChapterListState();
}



class _ChapterListState extends State<ChapterList> {
  late Future<List<Chapter>> futureChapters;
  List<Chapter> chapters = [];
  final ApiService apiService = ApiService();
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    futureChapters = apiService.fetchChapters();
    futureChapters.then((data) {
      setState(() {
        chapters = data;
      });
    });
  }

  void sortChapters() {
    setState(() {
      if (isAscending) {
        chapters.sort((a, b) => a.chapterNumber.compareTo(b.chapterNumber));
      } else {
        chapters.sort((a, b) => b.chapterNumber.compareTo(a.chapterNumber));
      }
      isAscending = !isAscending;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: sortChapters,
          )
        ],
      ),
      body: FutureBuilder<List<Chapter>>(
        future: futureChapters, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load chapters'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chapters found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final chapter = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Text('${chapter.chapterNumber}.'),
                    title: Text(languageProvider.isEnglish ? chapter.nameTranslated : chapter.name),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.list),
                        Text('${chapter.versesCount} verses'),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ChapterDetailPage(chapter: chapter,),
                      )
                    );
                    },
                  ),
                );
              },
            );
          }
        }  
      ),
      //  bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.language),
      //       label: 'Hindi / English',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   onTap: (index){
      //     if (index == 0) {
      //       toggleLanguage();
      //     }
      //   },
      // ),
    ); 
  }
}