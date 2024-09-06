// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gita_app/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String _selectedAuthor;
  List<String> _authors = [];

@override
  void initState() {
    super.initState();
    _fetchAuthors();
    _loadPreferredAuthor();
  }

  _loadPreferredAuthor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedAuthor = prefs.getString('preferredAuthor') ?? 'Swami Sivananda';
    });
  }

  _fetchAuthors() async {
    // Fetch authors from API or define statically
    // Example static list:
    setState(() {
      _authors = ['Swami Tejomayananda', 'Swami Gambirananda', 'Swami Sivananda', 'Dr. S. Sankaranarayan', 'Shri Purohit Swami', 'Swami Ramsukhdas', 'Swami Adidevananda'];
    });
  }

  _savePreferredAuthor(String author) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredAuthor', author);
    setState(() {
      _selectedAuthor = author;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Settings'),
    //   ),
    //   body: Consumer<LanguageProvider>(
    //     builder: (context, languageProvider, child) {
    //       return ListView(
    //         children: [
    //           ListTile(
    //             title: const Text('Preferred Language'),
    //             subtitle: Text(languageProvider.isEnglish ? 'English' : 'Hindi'),
    //             trailing: Switch(
    //               value: languageProvider.isEnglish,
    //               onChanged: (value) {
    //                 languageProvider.setLanguage(value);
    //               },
    //             ),
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        // leading: Icon(Icons.settings),
      ),
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Preferred Language'),
                subtitle: Text(languageProvider.isEnglish? 'English' : 'Hindi'),
                trailing: CupertinoSwitch(
                  value: languageProvider.isEnglish,
                  onChanged: (value) {
                    languageProvider.setLanguage(value);
                  },
                ),
              ),
              ListTile(
                title: const Text('Preferred Translation By'),
                subtitle: Text(_selectedAuthor),
                trailing: DropdownButton<String>(
                  value: _selectedAuthor,
                  items: _authors.map((String author){
                    return DropdownMenuItem<String>(value: author, child: Text(author));
                  }).toList(), 
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _savePreferredAuthor(newValue);
                    }
                  },
                  
                ),
              ),

            ],
          );
        },
      )
    );
  }
}
