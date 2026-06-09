import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

/// Shows a linear progress bar with status text while the update is downloading.
class UpdateProgressWidget extends StatelessWidget {
  const UpdateProgressWidget({
    super.key,
    required this.progress,
    required this.statusText,
  });

  final double progress;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAr = l10n.localeName == 'ar';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isAr
                  ? 'جاري التحميل... $statusText'
                  : 'Wird heruntergeladen... $statusText',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isAr ? 'يرجى الانتظار' : 'Bitte warten',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: isDark
                ? const Color(0xFF2F3542)
                : Colors.grey.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
