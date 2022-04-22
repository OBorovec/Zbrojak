import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepo {
  final SharedPreferences _prefsInstance;

  static const String keyLang = 'lang';
  static const String keyTheme = 'theme';

  static const String keyQuestionIncorrect = 'question Incorrect';
  static const String keyQuestionListingIdx = 'questionListingIdx';

  PrefsRepo(SharedPreferences prefs) : _prefsInstance = prefs;

  // App settings

  String? loadLang() {
    return _prefsInstance.getString(keyLang);
  }

  void saveLang(String? value) {
    _prefsInstance.setString(keyLang, value ?? '');
  }

  String? loadTheme() {
    return _prefsInstance.getString(keyTheme);
  }

  void saveTheme(String? value) {
    _prefsInstance.setString(keyTheme, value ?? '');
  }

  // Question records

  List<int> loadQuestionIdsIncorrect() {
    final String? json = _prefsInstance.getString(keyQuestionIncorrect);
    if (json == null) {
      return [];
    }
    return List<int>.from(jsonDecode(json));
  }

  void saveQuestionIdsIncorrect(List<int> value) {
    _prefsInstance.setString(
      keyQuestionIncorrect,
      jsonEncode(value),
    );
  }

  void addQuestionIdIncorrect(int id) {
    final List<int> ids = loadQuestionIdsIncorrect();
    ids.add(id);
    saveQuestionIdsIncorrect(ids);
  }

  void removeQuestionIdIncorrect(int id) {
    List<int> ids = loadQuestionIdsIncorrect();
    ids.remove(id);
    saveQuestionIdsIncorrect(ids);
  }

  int? loadQuestionListingIdx() {
    return _prefsInstance.getInt(keyQuestionListingIdx);
  }

  void saveQuestionListingIdx(int value) {
    _prefsInstance.setInt(keyQuestionListingIdx, value);
  }
}
