import 'package:flutter/material.dart';
import 'package:flutter_gita_app/main.dart';
import 'package:flutter_gita_app/services/language_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'shared_preferences_mock.mocks.dart';
void main() {
  group('LanguageProvider', () {
    late MockSharedPreferences mockPrefs;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      // Provide default stubs to avoid MissingStubError
      when(mockPrefs.getString(any)).thenReturn(null);
      when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
    });

    test('should load default language as English', () async {
      when(mockPrefs.getString('languageCode')).thenReturn(null);

      final languageProvider = LanguageProvider(prefs: mockPrefs);
      // await languageProvider._loadLanguage();

      expect(languageProvider.locale, const Locale('en'));
    });

    test('should load saved language from SharedPreferences', () async {
      when(mockPrefs.getString('languageCode')).thenReturn('hi');

      final languageProvider = LanguageProvider(prefs: mockPrefs);
      // await languageProvider._loadLanguage();

      expect(languageProvider.locale, const Locale('hi'));
    });

    test('should change language and save to SharedPreferences', () async {
      when(mockPrefs.setString('languageCode', 'hi')).thenAnswer((_) async => true);

      final languageProvider = LanguageProvider(prefs: mockPrefs);
      await languageProvider.changeLanguage('hi');

      expect(languageProvider.locale, const Locale('hi'));
      verify(mockPrefs.setString('languageCode', 'hi')).called(1);
    });

    testWidgets('should change language in the app', (WidgetTester tester) async {
      when(mockPrefs.getString('languageCode')).thenReturn('en');
      when(mockPrefs.setString('languageCode', any)).thenAnswer((_) async => true);

      await tester.pumpWidget(
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(prefs: mockPrefs),
          child: const MyApp(),
        ),
      );

      expect(find.text('Sri Mad Bhagwad Gita'), findsOneWidget);

      final languageProvider = Provider.of<LanguageProvider>(tester.element(find.byType(MyApp)), listen: false);
      await languageProvider.changeLanguage('hi');
      await tester.pump();

      expect(languageProvider.locale, const Locale('hi'));
      expect(find.text('श्रीमद् भगवद् गीता'), findsOneWidget);
    });
  });
}