import 'package:flutter/material.dart';

/// All color tokens for C1 Hochschule, as defined in design spec §2.2.
/// No other colors may be used in the app.
abstract final class AppColors {
  static const Color background   = Color(0xFFFFFFFF);
  static const Color surface      = Color(0xFFF5F5F5);
  static const Color accent       = Color(0xFF378ADD);
  static const Color accentLight  = Color(0xFFE6F1FB);
  static const Color correct      = Color(0xFF1D9E75);
  static const Color correctLight = Color(0xFFE1F5EE);
  static const Color wrong        = Color(0xFFE24B4A);
  static const Color wrongLight   = Color(0xFFFCEBEB);
  static const Color textPrimary  = Color(0xFF1A1A1A);
  static const Color textSecondary= Color(0xFF6B6B6B);
  static const Color border       = Color(0xFFE0E0E0);
  static const Color locked       = Color(0xFFB0B0B0);

  // Derived shades used in specific states (not new palette tokens)
  static const Color accentDark   = Color(0xFF185FA5); // active blank text, keyword text
  static const Color correctDark  = Color(0xFF085041); // correct blank text
  static const Color wrongDark    = Color(0xFF791F1F); // wrong blank text
  static const Color correctBorder= Color(0xFF5DCAA5); // feedback bar top border correct
  static const Color wrongBorder  = Color(0xFFF09595); // feedback bar top border wrong
}
