import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Row component for the results breakdown.
class BreakdownRow extends StatelessWidget {
  const BreakdownRow({
    super.key,
    required this.blankIndex,
    required this.chosenKey,
    required this.correctKey,
    required this.isCorrect,
  });

  final int blankIndex;
  final String chosenKey;
  final String correctKey;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: deprecated_member_use
      color: isCorrect
          ? Colors.transparent
          // ignore: deprecated_member_use
          : AppColors.wrongLight.withValues(alpha: 0.4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          // Index Circle
          IndexCircle(isCorrect: isCorrect, blankIndex: blankIndex),
          const SizedBox(width: 16),

          // User answers
          UserAnswer(
              chosenKey: chosenKey,
              isCorrect: isCorrect,
              correctKey: correctKey),

          // Status Badge
          StatusBadge(isCorrect: isCorrect),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.isCorrect,
  });

  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isCorrect ? AppColors.accentLight : AppColors.wrongLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isCorrect ? AppColors.accent : AppColors.wrong,
          ),
          const SizedBox(width: 4),
          Text(
            isCorrect ? 'Richtig' : 'Falsch',
            style: AppTextStyles.labelMedium.copyWith(
              color: isCorrect ? AppColors.accent : AppColors.wrong,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class UserAnswer extends StatelessWidget {
  const UserAnswer({
    super.key,
    required this.chosenKey,
    required this.isCorrect,
    required this.correctKey,
  });

  final String chosenKey;
  final bool isCorrect;
  final String correctKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              children: [
                const TextSpan(text: 'Your Answer: '),
                TextSpan(
                  text: chosenKey,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? AppColors.accent : AppColors.wrong,
                  ),
                ),
              ],
            ),
          ),
          if (!isCorrect) ...[
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                children: [
                  const TextSpan(text: 'Correct: '),
                  TextSpan(
                    text: correctKey,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class IndexCircle extends StatelessWidget {
  const IndexCircle({
    super.key,
    required this.isCorrect,
    required this.blankIndex,
  });

  final bool isCorrect;
  final int blankIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isCorrect ? AppColors.accentLight : AppColors.wrongLight,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$blankIndex',
        style: AppTextStyles.labelMedium.copyWith(
          color: isCorrect ? AppColors.accent : AppColors.wrong,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
