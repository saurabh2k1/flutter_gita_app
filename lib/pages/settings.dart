// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gita_app/generated/l10n.dart';
import 'package:flutter_gita_app/services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class AuthorChoice {
  final String id;
  final String name;
  final bool ht;
  final bool et;
  final bool hc;
  final bool ec;
  final bool sc;
 const AuthorChoice(this.id, this.name, this.ht, this.et, this.hc, this.ec, this.sc) ;
}



class _SettingsPageState extends State<SettingsPage> {
  late String _selectedAuthor;
  late String _selectedCommentAuthor;
  List<String> _authors = [];
  List<String> _commentAuthor = [];

  List<AuthorChoice> authors = const [
    AuthorChoice('tej',  'Swami Tejomayananda',  true,  false,  false,  false,  false),
    AuthorChoice('siva',  'Swami Sivananda',  false,  true,  false,  true,  false),
    AuthorChoice('purohit',  'Shri Purohit Swami',  false,  true,  false,  false,  false),
    AuthorChoice('chinmay',  'Swami Chinmayananda',  false,  false,  true,  false,  false),
    AuthorChoice('san',  'Dr.S.Sankaranarayan',  false,  true,  false,  false,  false),
    AuthorChoice('adi',  'Swami Adidevananda',  false,  true,  false,  false,  false),
    AuthorChoice('gambir',  'Swami Gambirananda',  false,  true,  false,  false,  false),
    AuthorChoice('madhav',  'Sri Madhavacharya',  false,  false,  false,  false,  true),
    AuthorChoice('anand',  'Sri Anandgiri',  false,  false,  false,  false,  true),
    AuthorChoice('rams',  'Swami Ramsukhdas',  true,  false,  true,  false,  false),
    AuthorChoice('raman',  'Sri Ramanuja',  false,  true,  false,  false,  true),
    AuthorChoice('abhinav',  'Sri Abhinav Gupta',  false,  true,  false,  false,  true),
    AuthorChoice('sankar',  'Sri Shankaracharya',  true,  true,  false,  false,  true),
    AuthorChoice('jaya',  'Sri Jayatritha',  false,  false,  false,  false,  true),
    AuthorChoice('vallabh',  'Sri Vallabhacharya',  false,  false,  false,  false,  true),
    AuthorChoice('ms',  'Sri Madhusudan Saraswati',  false,  false,  false,  false,  true),
    AuthorChoice('srid',  'Sri Sridhara Swami',  false,  false,  false,  false,  true),
    AuthorChoice('dhan',  'Sri Dhanpati',  false,  false,  false,  false,  true),
    AuthorChoice('venkat',  'Vedantadeshikacharya Venkatanatha',  false,  false,  false,  false,  true),
    AuthorChoice('puru', 'Sri Purushottamji',  false,  false,  false,  false,  true),
    AuthorChoice('neel', 'Sri Neelkanth',  false,  false,  false,  false,  true),
    AuthorChoice('prabhu', 'A.C. Bhaktivedanta Swami Prabhupada',  false,  true,  false,  true,  false),
  ];

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

  String getAvailableOptions({required bool ht, required bool et, required bool hc, required bool ec, required bool sc}){
  List<String> options = [];

    if (ht) options.add('Hindi Translations');
    if (et) options.add('English Translations');
    if (hc) options.add('Hindi Commentory');
    if (ec) options.add('English Commentory');
    if (sc) options.add('Sanskrit Commentory');

    return options.isEmpty ? 'No options available' : 'Available options: ${options.join(', ')}';
}

  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
     String currentLanguage = languageProvider.locale.languageCode;
    bool isEnglish = currentLanguage == 'en';

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(S.of(context).settings),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // leading: Icon(Icons.settings),
        ),
        body: ListView(
              children: [
                SwitchListTile(
                  value: isEnglish,
                  onChanged: (bool value) {
                    languageProvider.changeLanguage(value ? 'en' : 'hi');
                  },
                  title: Text(S.of(context).selectedLanguages),
                  subtitle:
                      Text(languageProvider.locale.languageCode == 'en' ? 'English' : 'हिन्दी'),
                ),
                const   Divider(),
                ListTile(
                  title: Text(S.of(context).selectedAuthors),
                  subtitle: const Text('for translation and commentory'),
                  tileColor: Colors.orange,
                ),
                 ListView.builder(
                    itemCount: authors.length,
                    physics: const ClampingScrollPhysics(), 
                    shrinkWrap: true,
                    itemBuilder: (_, index){
                      return Card(
                        child: ListTile(
                          leading: Text('${index + 1}'),
                          title: Text(authors[index].name),
                          subtitle: Text(getAvailableOptions(ec: authors[index].ec,  ht: authors[index].ht, et: authors[index].et, hc:  authors[index].hc, sc:  authors[index].sc)),
                          trailing: _selectedIndex == index ? const Icon(Icons.check) : null,
                          onTap: (){
                            setState(() {
                              if (_selectedIndex == index) {
                                _selectedIndex = null;
                              } else {
                                _selectedIndex = index;
                              }
                            });
                          },
                          selected: _selectedIndex == index,
                          selectedTileColor: Colors.deepPurple,
                          selectedColor: Colors.white,
                        ),
                      );
                    }),


                // ListTile(
                //   title: const Text('Preferred Translation By'),
                //   subtitle: Text(_selectedAuthor),
                //   trailing: DropdownButton<String>(
                //     value: _selectedAuthor,
                //     items: _authors.map((String author) {
                //       return DropdownMenuItem<String>(
                //           value: author, child: Text(author));
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       if (newValue != null) {
                //         _savePreferredAuthor(newValue);
                //       }
                //     },
                //   ),
                // ),
                // ListTile(
                //   title: const Text('Preferred Commentary By'),
                //   subtitle: Text(_selectedCommentAuthor),
                //   trailing: DropdownButton<String>(
                //     value: _selectedCommentAuthor,
                //     items: _commentAuthor.map((String commentAuthor) {
                //       return DropdownMenuItem<String>(
                //           value: commentAuthor, child: Text(commentAuthor));
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       if (newValue != null) {
                //         _savePreferredCommentAuthor(newValue);
                //       }
                //     },
                //   ),
                // ),
              ],
            ));
          }
  }
