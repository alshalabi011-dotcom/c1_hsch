import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

/// Displays the app icon, app name, and subtitle at the top of [UpdateScreen].
class UpdateHeader extends StatelessWidget {
  const UpdateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Image.asset(
          'assets/icon/app_icon.png',
          width: 88,
          height: 88,
          errorBuilder: (context, _, __) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.school, size: 54, color: AppColors.accent),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'C1 Hsch',
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.academicCourse.toUpperCase(),
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 3.0,
          ),
        ),
      ],
    );
  }
}
