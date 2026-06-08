import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// An inline keyword highlight rendered as part of a [Text.rich] span.
/// Spec §2.5: background accentLight, text accentDark, border-radius 4px, padding 0 3px.
class KeywordWidget extends StatelessWidget {
  const KeywordWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.accentDark,
          height: 1.0,
        ),
      ),
    );
  }
}
