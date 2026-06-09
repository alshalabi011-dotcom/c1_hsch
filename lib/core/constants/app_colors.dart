import 'package:flutter/material.dart';

/// All color tokens for C1 Hsch, dynamically resolving based on light/dark mode.
abstract final class AppColors {
  /// Toggle to control the active theme state.
  static bool isDark = false;

  static Color get background =>
      isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF);
  static Color get surface =>
      isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5);
  static Color get accent =>
      isDark ? const Color(0xFF60A5FA) : const Color(0xFF378ADD);
  static Color get accentLight =>
      isDark ? const Color(0xFF1E293B) : const Color(0xFFE6F1FB);
  static Color get correct =>
      isDark ? const Color(0xFF10B981) : const Color(0xFF1D9E75);
  static Color get correctLight =>
      isDark ? const Color(0xFF064E3B) : const Color(0xFFE1F5EE);
  static Color get wrong =>
      isDark ? const Color(0xFFF87171) : const Color(0xFFE24B4A);
  static Color get wrongLight =>
      isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFCEBEB);
  static Color get textPrimary =>
      isDark ? const Color(0xFFF3F4F6) : const Color(0xFF1A1A1A);
  static Color get textSecondary =>
      isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B6B6B);
  static Color get border =>
      isDark ? const Color(0xFF374151) : const Color(0xFFE0E0E0);
  static Color get locked =>
      isDark ? const Color(0xFF4B5563) : const Color(0xFFB0B0B0);

  // Derived shades used in specific states
  static Color get accentDark =>
      isDark ? const Color(0xFF93C5FD) : const Color(0xFF185FA5);
  static Color get correctDark =>
      isDark ? const Color(0xFF34D399) : const Color(0xFF085041);
  static Color get wrongDark =>
      isDark ? const Color(0xFFFCA5A5) : const Color(0xFF791F1F);
  static Color get correctBorder =>
      isDark ? const Color(0xFF059669) : const Color(0xFF5DCAA5);
  static Color get wrongBorder =>
      isDark ? const Color(0xFFDC2626) : const Color(0xFFF09595);
}
