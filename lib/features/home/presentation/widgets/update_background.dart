import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Renders the atmospheric blurred background circles for [UpdateScreen].
class UpdateBackground extends StatelessWidget {
  const UpdateBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Top-right accent circle
        Positioned(
          top: -100,
          right: -100,
          width: 300,
          height: 300,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withValues(alpha: isDark ? 0.15 : 0.08),
            ),
          ),
        ),
        // Bottom-left amber circle
        Positioned(
          bottom: -100,
          left: -100,
          width: 250,
          height: 250,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber.withValues(alpha: isDark ? 0.08 : 0.04),
            ),
          ),
        ),
        // Blur overlay
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
