import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ReadingHeader extends StatelessWidget {
  final String category;
  final String title;

  const ReadingHeader({
    super.key,
    required this.category,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.school_outlined, color: AppColors.accent, size: 20),
            const SizedBox(width: 8),
            Text(
              category,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyles.headingLarge.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
