import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/blank_answer.dart';
import 'breakdown_row.dart';

/// Card container for the breakdown list.
class BreakdownCard extends StatelessWidget {
  const BreakdownCard({
    super.key,
    required this.blanks,
    required this.selectedAnswers,
  });

  final List<BlankAnswer> blanks;
  final Map<int, String> selectedAnswers;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                bottom: BorderSide(color: AppColors.border),
              ),
            ),
            child: Text(
              l10n.breakdownTitle,
              style: AppTextStyles.headingMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Items List
          Column(
            children: List.generate(blanks.length, (index) {
              final blank = blanks[index];
              final chosen = selectedAnswers[blank.id] ?? '—';
              final isCorrect = chosen == blank.correctKey;

              return Column(
                children: [
                  BreakdownRow(
                    blankIndex: index + 1,
                    chosenKey: chosen,
                    correctKey: blank.correctKey,
                    isCorrect: isCorrect,
                  ),
                  if (index < blanks.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.border,
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
