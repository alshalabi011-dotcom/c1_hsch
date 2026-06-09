import 'package:flutter/material.dart';
import 'package:c1_hsch/core/constants/app_colors.dart';
import 'package:c1_hsch/core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

/// 2.ب النصوص والترجمات الترحيبية والتفصيلية (Text Content)
class TextContent extends StatelessWidget {
  const TextContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.welcomeTitle,
          style: AppTextStyles.headingMedium.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          height: 1,
          width: 64,
          color: AppColors.border,
          margin: const EdgeInsets.symmetric(vertical: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            l10n.welcomeSubtitle,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
