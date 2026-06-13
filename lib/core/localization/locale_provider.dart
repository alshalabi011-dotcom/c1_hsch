import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_storage_service.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final localStorage = ref.watch(localStorageServiceProvider);
  return LocaleNotifier(localStorage);
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(this._localStorage) : super(_localStorage.loadLocale() ?? const Locale('ar'));

  final LocalStorageService _localStorage;

  Future<void> toggleLocale() async {
    final newLanguageCode = state.languageCode == 'ar' ? 'de' : 'ar';
    final newLocale = Locale(newLanguageCode);
    state = newLocale;
    await _localStorage.saveLocale(newLocale);
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _localStorage.saveLocale(locale);
  }
}
