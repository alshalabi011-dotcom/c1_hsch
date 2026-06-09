import 'package:c1_hsch/core/constants/app_colors.dart';
import 'package:c1_hsch/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../l10n/app_localizations.dart';

/// 3. زر الحفظ والبدء وتوقيع رقم الإصدار بالأسفل (Footer Actions)
class FooterActions extends StatelessWidget {
  const FooterActions({super.key});

  Future<void> _onStartPressed(BuildContext context) async {
    // تخزين العلم بأن المستخدم قد أتم عرض شاشة الإنترو
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showIntro', false);

    // التوجيه عبر GoRouter للشاشة الرئيسية
    if (context.mounted) {
      context.go('/sections');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () => _onStartPressed(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 52,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const SizedBox(
                        width: 24), // موازنة مع السهم بالجهة المقابلة
                    Expanded(
                      child: Text(
                        l10n.startButton,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Version 1.0.4 • Academic Standard',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
