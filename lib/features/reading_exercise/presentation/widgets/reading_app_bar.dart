import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/locale_provider.dart';

class ReadingAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const ReadingAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      // leading: IconButton(
      //   icon: Icon(Icons.menu, color: AppColors.textPrimary),
      //   onPressed: () {
      //     // TODO: Open drawer or handle menu
      //   },
      // ),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school, color: AppColors.accent, size: 24),
          const SizedBox(width: 8),
          Text(
            'Leseverstehen',
            style: AppTextStyles.headingLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                ref.read(localeProvider.notifier).toggleLocale();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Center(
                  child: Text(
                    'DE | AR',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
