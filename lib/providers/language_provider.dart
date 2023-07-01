import 'package:flutter/foundation.dart';

import '../models/Language.dart';

class LanguageProvider with ChangeNotifier {
  static List<Language> languagesList = [
    Language(name: 'English', code: 'en'),
    Language(name: 'Hindi', code: 'hi'),
    Language(name: 'Arabic', code: 'ar'),
    Language(name: 'German', code: 'de'),
    Language(name: 'Russian', code: 'ru'),
    Language(name: 'Spanish', code: 'es'),
    Language(name: 'Urdu', code: 'ur'),
    Language(name: 'Japanese', code: 'ja'),
    Language(name: 'Italian', code: 'it'),
  ];

  Language _selectedLanguage = Language(name: 'English', code: 'en'); // Default language is English

  List<Language> get languages => languagesList;

  Language get selectedLanguage => _selectedLanguage;

  void setLanguage(Language language) {
    _selectedLanguage = language;
    notifyListeners();
  }
  Language _fromLanguage = Language(name: 'English', code: 'en');
  Language _toLanguage = Language(name: 'English', code: 'en');

  Language get fromLanguage => _fromLanguage;
  Language get toLanguage => _toLanguage;

  void setFromLanguage(Language language) {
    _fromLanguage = language;
    notifyListeners();
  }

  void setToLanguage(Language language) {
    _toLanguage = language;
    notifyListeners();
  }
}
