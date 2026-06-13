import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/reading_question.dart';
import '../../../exercise/presentation/widgets/breakdown_row.dart';

class ReadingBreakdownCard extends StatelessWidget {
  const ReadingBreakdownCard({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  final List<ReadingQuestion> questions;
  final Map<String, String> selectedAnswers;

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
          Column(
            children: List.generate(questions.length, (index) {
              final question = questions[index];
              final chosen = selectedAnswers[question.number] ?? '—';
              final isCorrect = chosen == question.correctAnswer;

              return Column(
                children: [
                  BreakdownRow(
                    blankIndex: int.tryParse(question.number) ?? (index + 1),
                    chosenKey: chosen,
                    correctKey: question.correctAnswer,
                    isCorrect: isCorrect,
                  ),
                  if (index < questions.length - 1)
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
