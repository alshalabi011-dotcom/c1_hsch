import 'package:c1_hsch/core/constants/app_colors.dart';
import 'package:c1_hsch/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

/// 1. شعار التطبيق العلوي (Branding Header)
class BrandingHeader extends StatelessWidget {
  const BrandingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school,
            color: AppColors.accent,
            size: 32,
          ),
          const SizedBox(width: 8),
          Text(
            'C1 Hsch',
            style: AppTextStyles.headingLarge.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
