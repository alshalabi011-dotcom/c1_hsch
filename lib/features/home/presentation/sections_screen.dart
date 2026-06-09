import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'sections_notifier.dart';
// import 'widgets/app_drawer.dart';
import 'widgets/desktop_sidebar.dart';
// import 'widgets/mobile_bottom_nav.dart';
import 'widgets/section_card.dart';
import 'widgets/sections_header.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../l10n/app_localizations.dart';

/// Redesigned Sections Screen.
/// Adapts responsively to viewport size, providing a Sidebar Navigation on Desktop
/// and standard AppBar/Drawer/BottomBar experience on Mobile.
class SectionsScreen extends ConsumerWidget {
  const SectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sectionsProvider);
    final themeMode = ref.watch(themeProvider);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 768;

    return state.when(
      loading: () => Scaffold(
        backgroundColor: AppColors.background,
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            err.toString(),
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.wrong),
          ),
        ),
      ),
      data: (sections) {
        // Main list content centered inside a max-width container
        final mainContent = Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionsHeader(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sections.length,
                    itemBuilder: (context, index) {
                      final section = sections[index];
                      return SectionCard(
                        section: section,
                        onTap: section.isLocked
                            ? () => _showLockedSnackbar(context)
                            : () => context.push('/section/${section.id}'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );

        if (isDesktop) {
          // Desktop Screen Layout with persistent sidebar
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Row(
              children: [
                const DesktopSidebar(),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
          );
        } else {
          // Mobile Screen Layout with top bar, drawer, and bottom navigation
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: const Text('C1 Hsch'),
              centerTitle: false,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  onPressed: () {
                    ref.read(themeProvider.notifier).state =
                        themeMode == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark;
                  },
                ),
                TextButton(
                  onPressed: () {
                    ref.read(localeProvider.notifier).toggleLocale();
                  },
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
            // drawer: const AppDrawer(),
            body: mainContent,
            // bottomNavigationBar: const MobileBottomNav(),
          );
        }
      },
    );
  }

  void _showLockedSnackbar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l10n.lockedSection,
          style: TextStyle(color: AppColors.textPrimary),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
