import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class TranslationButton extends StatelessWidget {
  final String textDe;
  final String textAr;
  final VoidCallback onTap;

  const TranslationButton({
    super.key,
    required this.textDe,
    required this.textAr,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.translate, color: AppColors.textPrimary, size: 20),
            const SizedBox(width: 8),
            Text(
              '$textDe | $textAr',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
