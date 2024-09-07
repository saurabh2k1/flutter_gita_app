import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  bool _isEnglish = true;

  LanguageProvider() {
    _loadPreferredLanguage();
  }

  bool get isEnglish => _isEnglish;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }

  Future<void> _loadPreferredLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isEnglish = prefs.getBool('preferredLanguageIsEnglish') ?? true;
    notifyListeners();
  }

  Future<void> _savePreferredLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('preferredLanguageIsEnglish', _isEnglish);
  }
}
