import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'sections_notifier.dart';
import 'widgets/desktop_header.dart';
import 'widgets/section_card.dart';
import 'widgets/section_grid_card.dart';
import 'widgets/sections_header.dart';
import '../../../core/services/update_service.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../l10n/app_localizations.dart';

/// Redesigned Sections Screen.
/// Responsive layout using a Grid for wide screens and List for narrow screens.
class SectionsScreen extends ConsumerStatefulWidget {
  const SectionsScreen({super.key});

  @override
  ConsumerState<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends ConsumerState<SectionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UpdateService.checkForUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sectionsProvider);
    ref.watch(themeProvider); // Force rebuild on theme change
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
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: isDesktop 
            ? null 
            : AppBar(
                title: const Text('C1 Hsch'),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      context.push('/settings');
                    },
                  ),
                ],
              ),
          body: Column(
            children: [
              if (isDesktop) const DesktopHeader(),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isDesktop ? 1200 : 800),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 40.0 : 20.0,
                        vertical: isDesktop ? 32.0 : 24.0,
                      ),
                      child: CustomScrollView(
                        slivers: [
                        if (isDesktop)
                          SliverToBoxAdapter(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Willkommen zurück!',
                                          style: AppTextStyles.headingLarge.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.accentDark,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Wähle eine Lektion, um dein Deutsch weiter zu verbessern.',
                                          style: AppTextStyles.bodyLarge.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Icon(Icons.workspace_premium_rounded, size: 80, color: AppColors.accent),
                                ],
                              ),
                            ),
                          ),
                        const SliverToBoxAdapter(
                          child: SectionsHeader(),
                        ),
                        if (isDesktop)
                          SliverGrid(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 24,
                              childAspectRatio: 0.9,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final section = sections[index];
                                return SectionGridCard(
                                  section: section,
                                  onTap: section.isLocked
                                      ? () => _showLockedSnackbar(context)
                                      : () => context.push('/section/${section.id}'),
                                );
                              },
                              childCount: sections.length,
                            ),
                          )
                        else
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final section = sections[index];
                                return SectionCard(
                                  section: section,
                                  onTap: section.isLocked
                                      ? () => _showLockedSnackbar(context)
                                      : () => context.push('/section/${section.id}'),
                                );
                              },
                              childCount: sections.length,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          ),
        );
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
