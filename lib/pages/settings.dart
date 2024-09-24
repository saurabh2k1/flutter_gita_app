// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gita_app/generated/l10n.dart';
import 'package:flutter_gita_app/services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class AuthorChoice {
  final String id;
  final String name;
  final String hindiName;
  final bool ht;
  final bool et;
  final bool hc;
  final bool ec;
  final bool sc;
 const AuthorChoice(this.id, this.name, this.hindiName, this.ht, this.et, this.hc, this.ec, this.sc) ;
}



class _SettingsPageState extends State<SettingsPage> {
  
  List<AuthorChoice> authors = const [
    AuthorChoice('tej',  'Swami Tejomayananda', 'स्वामी तेजोमयानंद', true,  false,  false,  false,  false),
    AuthorChoice('siva',  'Swami Sivananda', 'स्वामी शिवानंद', false,  true,  false,  true,  false),
    AuthorChoice('purohit',  'Shri Purohit Swami', 'श्री पुरोहित स्वामी', false,  true,  false,  false,  false),
    AuthorChoice('chinmay',  'Swami Chinmayananda', 'स्वामी चिन्मयानंद',  false,  false,  true,  false,  false),
    AuthorChoice('san',  'Dr.S.Sankaranarayan', 'डॉ.एस.शंकरनारायण', false,  true,  false,  false,  false),
    AuthorChoice('adi',  'Swami Adidevananda', 'स्वामी आदिदेवानंद', false,  true,  false,  false,  false),
    AuthorChoice('gambir',  'Swami Gambirananda', 'स्वामी गंभीरानंद',  false,  true,  false,  false,  false),
    AuthorChoice('madhav',  'Sri Madhavacharya', 'श्री माधवाचार्य', false,  false,  false,  false,  true),
    AuthorChoice('anand',  'Sri Anandgiri', 'श्री आनंदगिरि', false,  false,  false,  false,  true),
    AuthorChoice('rams',  'Swami Ramsukhdas', 'स्वामी रामसुखदास', true,  false,  true,  false,  false),
    AuthorChoice('raman',  'Sri Ramanuja', 'श्री रामानुज', false,  true,  false,  false,  true),
    AuthorChoice('abhinav',  'Sri Abhinav Gupta', 'श्री अभिनव गुप्ता',  false,  true,  false,  false,  true),
    AuthorChoice('sankar',  'Sri Shankaracharya', 'श्री शंकराचार्य',  true,  true,  false,  false,  true),
    AuthorChoice('jaya',  'Sri Jayatirtha', 'श्री जयतीर्थ', false,  false,  false,  false,  true),
    AuthorChoice('vallabh',  'Sri Vallabhacharya', 'श्री वल्लभाचार्य', false,  false,  false,  false,  true),
    AuthorChoice('ms',  'Sri Madhusudan Saraswati', 'श्री मधुसूदन सरस्वती',  false,  false,  false,  false,  true),
    AuthorChoice('srid',  'Sri Sridhara Swami', 'श्री श्रीधर स्वामी', false,  false,  false,  false,  true),
    AuthorChoice('dhan',  'Sri Dhanpati', 'श्री धनपति',  false,  false,  false,  false,  true),
    AuthorChoice('venkat',  'Vedantadeshikacharya Venkatanatha', 'वेदांतदेशिकाचार्य वेंकटनाथ', false,  false,  false,  false,  true),
    AuthorChoice('puru', 'Sri Purushottamji', 'श्रीपुरुषोत्तमजी',  false,  false,  false,  false,  true),
    AuthorChoice('neel', 'Sri Neelkanth', 'श्री नीलकंठ',  false,  false,  false,  false,  true),
    AuthorChoice('prabhu', 'A.C. Bhaktivedanta Swami Prabhupada', 'ए.सी. भक्तिवेदांत स्वामी प्रभुपाद', false,  true,  false,  true,  false),
  ];

  String? _selectedAuthorId;

  @override
  void initState() {
    super.initState();
    _loadSelectedAuthor();
  }

  Future<void> _loadSelectedAuthor() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedAuthorId = prefs.getString('selectedAuthorId');
    });
  } 

  Future<void> _saveSelectedAuthor(String authorId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedAuthorId', authorId);
    setState(() {
      _selectedAuthorId = authorId;
    });
  }

  String getAvailableOptions({required bool ht, required bool et, required bool hc, required bool ec, required bool sc}){
  List<String> options = [];

    if (ht) options.add( '${S.of(context).hindi} ${S.of(context).translations}');
    if (et) options.add('${S.of(context).english} ${S.of(context).translations}');
    if (hc) options.add('${S.of(context).hindi} ${S.of(context).commentary}');
    if (ec) options.add('${S.of(context).english} ${S.of(context).commentary}');
    if (sc) options.add('${S.of(context).sanskrit} ${S.of(context).commentary}');

    return options.isEmpty ? 'No options available' : '${S.of(context).available}: ${options.join(', ')}';
}



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
                  subtitle: Text(S.of(context).translateNCommentary),
                  tileColor: Colors.orange,
                ),
                 ListView.builder(
                    itemCount: authors.length,
                    physics: const ClampingScrollPhysics(), 
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      final author = authors[index];
                      return Card(
                        child: ListTile(
                          leading: Text('${index + 1}'),
                          title: Text(languageProvider.locale.languageCode == 'en' ?  authors[index].name : authors[index].hindiName),
                          subtitle: Text(getAvailableOptions(ec: authors[index].ec,  ht: authors[index].ht, et: authors[index].et, hc:  authors[index].hc, sc:  authors[index].sc)),
                          trailing: _selectedAuthorId == author.id ? const Icon(Icons.check) : null,
                          onTap: (){
                            _saveSelectedAuthor(author.id);
                          },
                          selected: _selectedAuthorId == author.id,
                          selectedTileColor: Colors.deepPurple,
                          selectedColor: Colors.white,
                        ),
                      );
                    }),
              ],
            ));
          }
  }
