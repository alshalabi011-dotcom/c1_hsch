import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ar')) {
    _loadLocale();
  }

  static const String _localeKey = 'selected_locale';

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_localeKey);
      if (languageCode != null) {
        state = Locale(languageCode);
      }
    } catch (_) {
      // Fallback to default state if error occurs
    }
  }

  Future<void> toggleLocale() async {
    final newLanguageCode = state.languageCode == 'ar' ? 'de' : 'ar';
    state = Locale(newLanguageCode);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, newLanguageCode);
    } catch (_) {}
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (_) {}
  }
}
