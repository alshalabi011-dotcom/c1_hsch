import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/local_storage_service.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final localStorage = ref.watch(localStorageServiceProvider);
  return ThemeNotifier(localStorage);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier(this._localStorage) : super(_localStorage.loadTheme());

  final LocalStorageService _localStorage;

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await _localStorage.saveTheme(mode);
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setTheme(newMode);
  }
}
