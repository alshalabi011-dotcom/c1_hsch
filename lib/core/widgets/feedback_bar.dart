import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Animated feedback bar that slides up from the bottom of the exercise screen.
/// Spec §2.5: 48px height, correct/wrong color, top border accent, auto-dismiss 2200ms.
class FeedbackBar extends StatelessWidget {
  const FeedbackBar({
    super.key,
    required this.isCorrect,
    required this.message,
  });

  final bool isCorrect;
  final String message;

  @override
  Widget build(BuildContext context) {
    final bg = isCorrect ? AppColors.correctLight : AppColors.wrongLight;
    final textColor = isCorrect ? AppColors.correctDark : AppColors.wrongDark;
    final borderColor = isCorrect ? AppColors.correctBorder : AppColors.wrongBorder;

    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bg,
        border: Border(top: BorderSide(color: borderColor, width: 1.5)),
      ),
      alignment: Alignment.center,
      child: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
