import 'package:flutter/material.dart';
import 'package:flutter_gita_app/main.dart';
import 'package:flutter_gita_app/pages/settings.dart';
import 'package:flutter_gita_app/services/language_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_mock.mocks.dart';

void main() {
  group('MyApp', () {
    late MockSharedPreferences mockPrefs;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      when(mockPrefs.getString(any)).thenReturn(null);
      when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
    });

    testWidgets('initializes MaterialApp with default language', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(prefs: mockPrefs),
          child: const MyApp(),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Sri Mad Bhagwad Gita'), findsOneWidget);
    });

    testWidgets('changes language and updates locale in MaterialApp', (WidgetTester tester) async {
      when(mockPrefs.getString('languageCode')).thenReturn('en');

      await tester.pumpWidget(
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(prefs: mockPrefs),
          child: const MyApp(),
        ),
      );

      final languageProvider = Provider.of<LanguageProvider>(tester.element(find.byType(MyApp)), listen: false);
      await languageProvider.changeLanguage('hi');
      await tester.pump();

      expect(languageProvider.locale, const Locale('hi'));
    });

    testWidgets('navigates to settings page', (WidgetTester tester) async {
      when(mockPrefs.getString('languageCode')).thenReturn('en');

      await tester.pumpWidget(
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(prefs: mockPrefs),
          child: const MyApp(),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });
}
