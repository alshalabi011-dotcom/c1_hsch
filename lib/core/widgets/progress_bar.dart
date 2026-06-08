import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A 3px tall animated progress bar.
/// Spec §2.5: height 3px, bg border, fill correct, AnimatedContainer 300ms.
class ExerciseProgressBar extends StatelessWidget {
  const ExerciseProgressBar({
    super.key,
    required this.answered,
    required this.total,
  });

  final int answered;
  final int total;

  @override
  Widget build(BuildContext context) {
    final fraction = total == 0 ? 0.0 : answered / total;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 3,
              width: constraints.maxWidth,
              color: AppColors.border,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 3,
              width: constraints.maxWidth * fraction,
              color: AppColors.correct,
            ),
          ],
        );
      },
    );
  }
}
