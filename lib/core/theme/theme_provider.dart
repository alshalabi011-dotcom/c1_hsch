import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StateProvider to manage the active ThemeMode of the application.
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
