import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/localization/locale_provider.dart';

class DesktopHeader extends ConsumerWidget {
  const DesktopHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      child: Row(
        children: [
          Icon(
            Icons.school,
            color: AppColors.accent,
            size: 36,
          ),
          const SizedBox(width: 12),
          Text(
            'C1 Hsch',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppColors.accentDark,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
                  color: AppColors.textSecondary,
                  onPressed: () {
                    ref.read(themeProvider.notifier).state =
                        themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                  },
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: AppColors.border,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(localeProvider.notifier).toggleLocale();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Text(
                    'DE | AR',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
