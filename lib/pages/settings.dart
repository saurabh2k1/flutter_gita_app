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
  late String _selectedCommentAuthor;
  List<String> _authors = [];
  List<String> _commentAuthor = [];

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
      _selectedCommentAuthor =
          prefs.getString('preferredCommentAuthor') ?? 'Sri Vallabhacharya';
    });
  }

  _fetchAuthors() async {
    // Fetch authors from API or define statically
    // Example static list:
    setState(() {
      _authors = [
        'Swami Tejomayananda',
        'Swami Gambirananda',
        'Swami Sivananda',
        'Dr. S. Sankaranarayan',
        'Shri Purohit Swami',
        'Swami Ramsukhdas',
        'Swami Adidevananda'
      ];
      _commentAuthor = [
        'Sri Neelkanth',
        'Sri Ramanujacharya',
        'Sri Sridhara Swami',
        'Sri Vedantadeshikacharya Venkatanatha',
        'Sri Abhinavgupta',
        'Sri Jayatritha',
        'Sri Madhusudan Saraswati',
        'Sri Purushottamji',
        'Sri Shankaracharya',
        'Sri Vallabhacharya',
        'Swami Sivananda',
        'Swami Ramsukhdas',
        'Swami Chinmayananda',
        'Sri Anandgiri',
        'Sri Dhanpati',
        'Sri Madhavacharya',
      ];
    });
  }

  _savePreferredAuthor(String author) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredAuthor', author);
    setState(() {
      _selectedAuthor = author;
    });
  }

  _savePreferredCommentAuthor(String author) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredCommentAuthor', author);
    setState(() {
      _selectedCommentAuthor = author;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
        // resizeToAvoidBottomInset: false,
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
                  subtitle:
                      Text(languageProvider.isEnglish ? 'English' : 'Hindi'),
                  trailing: CupertinoSwitch(
                    value: languageProvider.isEnglish,
                    onChanged: (value) {
                      languageProvider.toggleLanguage();
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Preferred Translation By'),
                  subtitle: Text(_selectedAuthor),
                  trailing: DropdownButton<String>(
                    value: _selectedAuthor,
                    items: _authors.map((String author) {
                      return DropdownMenuItem<String>(
                          value: author, child: Text(author));
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _savePreferredAuthor(newValue);
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Preferred Commentary By'),
                  subtitle: Text(_selectedCommentAuthor),
                  trailing: DropdownButton<String>(
                    value: _selectedCommentAuthor,
                    items: _commentAuthor.map((String commentAuthor) {
                      return DropdownMenuItem<String>(
                          value: commentAuthor, child: Text(commentAuthor));
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _savePreferredCommentAuthor(newValue);
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }
}
