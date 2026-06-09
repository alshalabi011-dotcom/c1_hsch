import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

/// Renders the "Update Now" primary button and optional "Later" secondary button.
class UpdateActionsWidget extends StatelessWidget {
  const UpdateActionsWidget({
    super.key,
    required this.isDownloading,
    required this.isForceUpdate,
    required this.onUpdate,
  });

  final bool isDownloading;
  final bool isForceUpdate;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAr = l10n.localeName == 'ar';

    return Column(
      children: [
        // Primary: Update Now
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor:
                  isDark ? const Color(0xFF0D131F) : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: isDownloading ? null : onUpdate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isDownloading
                      ? (isAr ? 'جاري التنزيل...' : 'Herunterladen...')
                      : l10n.updateNowBtn,
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isDownloading) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.play_arrow, size: 18),
                ],
              ],
            ),
          ),
        ),

        // Secondary: Later (hidden during force-update or active download)
        if (!isForceUpdate && !isDownloading) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: BorderSide(
                  color: isDark
                      ? const Color(0xFF334155)
                      : Colors.grey.withValues(alpha: 0.3),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => context.go('/sections'),
              child: Text(l10n.laterBtn, style: AppTextStyles.labelMedium),
            ),
          ),
        ],
      ],
    );
  }
}
