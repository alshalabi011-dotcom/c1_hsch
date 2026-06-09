import 'package:c1_hsch/core/constants/app_colors.dart';
import 'package:c1_hsch/features/onboarding/presentation/widgets/bento_pattern_painter.dart';
import 'package:flutter/material.dart';

class IllustrationArea extends StatelessWidget {
  const IllustrationArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الخلفية الشبكية المنقطة (Bento Dot Pattern)
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: CustomPaint(
                painter: BentoPatternPainter(
                  dotColor: AppColors.locked,
                ),
              ),
            ),
          ),
          // الحاوية الدائرية للصورة التوضيحية
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.border,
                width: 4,
              ),
            ),
            child: ClipOval(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDflH9_cNy41qvbwwcxXjE63QDYlcuptEupQYg4-T4zojrXEXfs22XZV-OgCkXTeidPQ8Wz3y7Ahw844LfIPyTvh5IIHUL5CZ7xWXZFkVo3MaYz7hWwNlxfriwRncD7knUnO9NpZAkfaD4z-b-aWFcov4rW4MhPznR3VSwQvWOdEeB0RqsU-0P-DWfzUnjzQRdDvmD6nE_y3Z0GBQHzIA0Ef2qt_XV0vE25T4LHZmk2mq3Rq0nnqqFi6fn-h1ZAPaaSj8gl7cT4Iw',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.accent),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: AppColors.accentLight);
                    },
                  ),
                  // طبقة الفلتر الملونة
                  Container(
                    // ignore: deprecated_member_use
                    color: AppColors.accent.withValues(alpha: 0.1),
                  ),
                  // أيقونة الكتاب بمنتصف الدائرة
                  Center(
                    child: Icon(
                      Icons.auto_stories,
                      size: 64,
                      color: AppColors.accentDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
