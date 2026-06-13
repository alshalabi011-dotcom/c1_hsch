import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/theme_provider.dart';

class DesktopHeader extends ConsumerWidget {
  const DesktopHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider); // Force rebuild on theme change

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
            child: IconButton(
              icon: const Icon(Icons.settings),
              color: AppColors.textSecondary,
              onPressed: () {
                context.push('/settings');
              },
            ),
          )
        ],
      ),
    );
  }
}
