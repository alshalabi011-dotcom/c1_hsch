import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

/// Displays a "What's New" card with bullet-point release notes.
class UpdateNotesWidget extends StatelessWidget {
  const UpdateNotesWidget({
    super.key,
    required this.notes,
  });

  final String notes;

  List<String> get _bulletPoints => notes
      .split('\n')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .map(
        (e) => e.startsWith('•') || e.startsWith('-') ? e.substring(1).trim() : e,
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bulletPoints = _bulletPoints;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF161C27)
            : Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? const Color(0xFF334155).withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 18, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                l10n.whatsNew,
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Bullet points or raw text fallback
          if (bulletPoints.isEmpty)
            Text(
              notes,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          else
            Column(
              children: bulletPoints.map((point) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          point,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
