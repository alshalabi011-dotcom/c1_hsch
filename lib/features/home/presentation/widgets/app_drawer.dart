import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

/// Navigation Drawer for Mobile layout.
/// Mirrors the logo, user profile, progress, and navigation options of the Desktop sidebar.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: AppColors.background,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Branding Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.school,
                    color: AppColors.accent,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'C1 Hsch',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            // Profile info
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCy8kafkeRxGLSzmRk2tXfHMSaCigSwmNM-HxCZ9TbS0OVXOZ6E6RpaLWzg_HOwT30WFC8R4T5y8GQyJepXFXeWa3-IhZIF5CtkhcVneAIsqzbk0O6SKXWhEm8u6hitHv4XyAEALGKdia1brh68yPabS_7FFjWMO_zJzPod1_M-n7dLRxiiR4RDajuui2VYSht9Qw_TYn31KZazQMgHrtMc3PmYfUPFuGag42r0f84158sq5_jSvwLZBfyFHJZYXostYrOR-Rv0Qw',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.person,
                          color: AppColors.locked,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.academicCourse,
                          style: AppTextStyles.labelMedium,
                        ),
                        Text(
                          l10n.c1Level,
                          style: AppTextStyles.labelSmall,
                        ),
                        Text(
                          l10n.progressValue(65),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),

            // Links List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    _DrawerLink(
                      icon: Icons.home_outlined,
                      label: l10n.homeLink,
                      isActive: false,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerLink(
                      icon: Icons.school,
                      label: l10n.myCoursesLink,
                      isActive: true,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerLink(
                      icon: Icons.menu_book_outlined,
                      label: l10n.grammarLink,
                      isActive: false,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerLink(
                      icon: Icons.book_outlined,
                      label: l10n.dictionaryLink,
                      isActive: false,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(),
            // Settings at bottom
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: _DrawerLink(
                icon: Icons.settings_outlined,
                label: l10n.settingsLink,
                isActive: false,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  const _DrawerLink({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? AppColors.accentLight : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    isActive ? AppColors.accentDark : AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color:
                      isActive ? AppColors.accentDark : AppColors.textPrimary,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
