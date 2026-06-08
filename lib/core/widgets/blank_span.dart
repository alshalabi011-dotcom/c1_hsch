import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// The visual state of a blank widget.
enum BlankState { unanswered, active, correct, wrong }

/// A blank fill-in widget rendered as part of a [Text.rich] span.
/// Wraps [GestureDetector] so tapping opens the answer sheet.
/// The [onTap] callback is null for static (Arabic translation) blanks.
class BlankWidget extends StatelessWidget {
  const BlankWidget({
    super.key,
    required this.blankId,
    required this.blankState,
    this.displayText,
    this.onTap,
  });

  final int blankId;
  final BlankState blankState;

  /// Text shown inside the blank. Null when unanswered.
  final String? displayText;

  /// Null → static non-tappable blank (Arabic paragraph).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 36, minHeight: 24),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: _decoration,
        child: Text(
          displayText ?? '…$blankId…',
          style: _textStyle,
        ),
      ),
    );
  }

  BoxDecoration get _decoration {
    return switch (blankState) {
      BlankState.unanswered => BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: AppColors.border,
            width: 1.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      BlankState.active => BoxDecoration(
          color: AppColors.accentLight,
          border: Border.all(color: AppColors.accent, width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
      BlankState.correct => BoxDecoration(
          color: AppColors.correctLight,
          border: Border.all(color: AppColors.correct, width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
      BlankState.wrong => BoxDecoration(
          color: AppColors.wrongLight,
          border: Border.all(color: AppColors.wrong, width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
    };
  }

  TextStyle get _textStyle {
    return switch (blankState) {
      BlankState.unanswered => AppTextStyles.labelMedium.copyWith(
          color: AppColors.locked,
        ),
      BlankState.active => AppTextStyles.labelMedium.copyWith(
          color: AppColors.accentDark,
        ),
      BlankState.correct => AppTextStyles.labelMedium.copyWith(
          color: AppColors.correctDark,
        ),
      BlankState.wrong => AppTextStyles.labelMedium.copyWith(
          color: AppColors.wrongDark,
        ),
    };
  }
}
