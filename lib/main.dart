import 'package:flutter/material.dart';
import 'package:flutter_gita_app/widgets/chapter_list.dart';
import 'package:flutter_gita_app/widgets/random_verse.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'pages/settings.dart';

import 'chapter_list.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: MyHomePage(
            title: languageProvider.isEnglish
                ? 'Sri Mad Bhagwad Gita'
                : 'श्रीमद् भगवद् गीता'),
        routes: {'/settings': (context) => const SettingsPage()},
        locale: languageProvider.isEnglish
            ? const Locale('en')
            : const Locale('hi'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ));
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: RandomVerse()),
            const Divider(),
            Expanded(child: ChapterListWidget()),
          ],
        ),
      ),
    );
  }
}
