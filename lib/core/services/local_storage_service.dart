import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('localStorageServiceProvider must be overridden in main');
});

class LocalStorageService {
  static const String _settingsBoxName = 'settingsBox';
  static const String _exercisesBoxName = 'exercisesBox';

  late Box _settingsBox;
  late Box _exercisesBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _settingsBox = await Hive.openBox(_settingsBoxName);
    _exercisesBox = await Hive.openBox(_exercisesBoxName);
  }

  // --- Settings (Theme & Locale) ---

  ThemeMode loadTheme() {
    final themeStr = _settingsBox.get('theme_mode');
    if (themeStr == 'dark') return ThemeMode.dark;
    if (themeStr == 'light') return ThemeMode.light;
    return ThemeMode.system; // default
  }

  Future<void> saveTheme(ThemeMode mode) async {
    String modeStr = 'system';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    if (mode == ThemeMode.light) modeStr = 'light';
    await _settingsBox.put('theme_mode', modeStr);
  }

  Locale? loadLocale() {
    final langCode = _settingsBox.get('selected_locale');
    if (langCode != null) {
      return Locale(langCode);
    }
    return null;
  }

  Future<void> saveLocale(Locale locale) async {
    await _settingsBox.put('selected_locale', locale.languageCode);
  }

  // --- Exercises Progress ---

  String _getExerciseKey(int sectionId, int modelId) => 'exercise_${sectionId}_$modelId';

  Map<int, String>? loadExerciseAnswers(int sectionId, int modelId) {
    final jsonStr = _exercisesBox.get(_getExerciseKey(sectionId, modelId));
    if (jsonStr != null) {
      final Map<String, dynamic> decoded = jsonDecode(jsonStr);
      return decoded.map((key, value) => MapEntry(int.parse(key), value as String));
    }
    return null;
  }

  Future<void> saveExerciseAnswers(int sectionId, int modelId, Map<int, String> answers) async {
    final encoded = answers.map((key, value) => MapEntry(key.toString(), value));
    await _exercisesBox.put(_getExerciseKey(sectionId, modelId), jsonEncode(encoded));
  }

  // --- Reading Exercises Progress ---

  String _getReadingAnswersKey(int sectionId, int modelId) => 'reading_answers_${sectionId}_$modelId';
  String _getReadingValidationsKey(int sectionId, int modelId) => 'reading_validations_${sectionId}_$modelId';

  Map<String, String>? loadReadingAnswers(int sectionId, int modelId) {
    final jsonStr = _exercisesBox.get(_getReadingAnswersKey(sectionId, modelId));
    if (jsonStr != null) {
      final Map<String, dynamic> decoded = jsonDecode(jsonStr);
      return decoded.map((key, value) => MapEntry(key, value as String));
    }
    return null;
  }

  Future<void> saveReadingAnswers(int sectionId, int modelId, Map<String, String> answers) async {
    await _exercisesBox.put(_getReadingAnswersKey(sectionId, modelId), jsonEncode(answers));
  }

  Map<String, bool>? loadReadingValidations(int sectionId, int modelId) {
    final jsonStr = _exercisesBox.get(_getReadingValidationsKey(sectionId, modelId));
    if (jsonStr != null) {
      final Map<String, dynamic> decoded = jsonDecode(jsonStr);
      return decoded.map((key, value) => MapEntry(key, value as bool));
    }
    return null;
  }

  Future<void> saveReadingValidations(int sectionId, int modelId, Map<String, bool> validations) async {
    await _exercisesBox.put(_getReadingValidationsKey(sectionId, modelId), jsonEncode(validations));
  }

  // --- Clear Data ---

  Future<void> clearAllData() async {
    await _settingsBox.clear();
    await _exercisesBox.clear();
  }
}
