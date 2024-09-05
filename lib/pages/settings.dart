import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gita_app/language_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
        // leading: Icon(Icons.settings),
      ),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return ListView(
            children: [
              CupertinoListTile(
                title: const Text('Preferred Language'),
                subtitle: Text(languageProvider.isEnglish? 'English' : 'Hindi'),
                trailing: CupertinoSwitch(
                  value: languageProvider.isEnglish,
                  onChanged: (value) {
                    languageProvider.setLanguage(value);
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
