import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Full-width translation toggle button.
/// Spec §4.3: outlined style, language icon, label switches with state.
class TranslationButton extends StatelessWidget {
  const TranslationButton({
    super.key,
    required this.showTranslation,
    required this.onTap,
  });

  final bool showTranslation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(Icons.language, size: 18, color: AppColors.textSecondary),
        label: Text(
          showTranslation ? 'إخفاء الترجمة' : 'ترجمة النص والأجوبة',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textDirection: TextDirection.rtl,
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.border, width: 0.5),
          backgroundColor: AppColors.background,
          minimumSize: const Size(double.infinity, 44),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
    );
  }
}
