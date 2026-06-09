import 'package:c1_hsch/features/onboarding/presentation/widgets/illustration_area.dart';
import 'package:c1_hsch/features/onboarding/presentation/widgets/text_content.dart';
import 'package:flutter/material.dart';

/// 2. المحتوى المتحرك الأوسط (المسؤول عن توحيد الأنيميشن للصورة والنصوص)
class AnimatedContentBody extends StatelessWidget {
  const AnimatedContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(height: 24),
          IllustrationArea(), // قسم الخلفية المنقطة والصورة الدائرية
          SizedBox(height: 24),
          TextContent(), // قسم النصوص والترجمات
        ],
      ),
    );
  }
}
