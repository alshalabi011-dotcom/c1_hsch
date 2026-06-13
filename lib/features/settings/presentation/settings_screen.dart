import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/localization/locale_provider.dart';
import 'widgets/theme_selection_card.dart';
import 'widgets/language_tile.dart';
import 'widgets/clear_data_dialog.dart';
import '../../../../core/services/update_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _appVersion = 'Lade...';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final jsonStr = await rootBundle.loadString('version.json');
      final data = jsonDecode(jsonStr);
      setState(() {
        _appVersion = data['version'] ?? 'Unbekannt';
      });
    } catch (_) {
      setState(() {
        _appVersion = 'Fehler';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    final isDark = themeMode == ThemeMode.dark;
    final isGerman = locale.languageCode == 'de';

    String tr(String ar, String de) => isGerman ? de : ar;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'C1 Hochschule',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'DE',
                  style: TextStyle(
                    color:
                        isGerman ? AppColors.accent : AppColors.textSecondary,
                    fontWeight: isGerman ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                Text(' | ', style: TextStyle(color: AppColors.border)),
                Text(
                  'AR',
                  style: TextStyle(
                    color:
                        !isGerman ? AppColors.accent : AppColors.textSecondary,
                    fontWeight: !isGerman ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          )
        ],
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.accent),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Header Section
          Text(
            tr('الإعدادات', 'Einstellungen'),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tr('تخصيص البيئة الأكاديمية الخاصة بك',
                'Personalisiere deine akademische Umgebung'),
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),

          // Theme Section
          _buildSectionCard(
            title: tr('المظهر / السمة', 'Motto / Thema'),
            subtitle: tr('مظهر واجهة المستخدم', 'Optik der Benutzeroberfläche'),
            child: Row(
              children: [
                Expanded(
                  child: ThemeSelectionCard(
                    icon: Icons.light_mode_outlined,
                    label: tr('فاتح (Light)', 'Hell (Light)'),
                    isSelected: !isDark,
                    onTap: () => ref
                        .read(themeProvider.notifier)
                        .setTheme(ThemeMode.light),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ThemeSelectionCard(
                    icon: Icons.dark_mode_outlined,
                    label: tr('داكن (Dark)', 'Dunkel (Dark)'),
                    isSelected: isDark,
                    onTap: () => ref
                        .read(themeProvider.notifier)
                        .setTheme(ThemeMode.dark),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Language Section
          _buildSectionCard(
            title: tr('اللغة', 'Sprache'),
            subtitle: tr('اختر لغة النظام', 'Systemsprache wählen'),
            child: Column(
              children: [
                LanguageTile(
                  icon: Icons.language,
                  label: 'Deutsch',
                  isSelected: isGerman,
                  onTap: () => ref
                      .read(localeProvider.notifier)
                      .setLocale(const Locale('de')),
                ),
                Divider(color: AppColors.border, height: 1),
                LanguageTile(
                  icon: Icons.translate,
                  label: 'العربية',
                  isSelected: !isGerman,
                  onTap: () => ref
                      .read(localeProvider.notifier)
                      .setLocale(const Locale('ar')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Data Management Section
          Text(
            tr('إدارة البيانات', 'DATENVERWALTUNG').toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () => _showClearDataConfirm(context, tr),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.wrong.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.wrong.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr('مسح بيانات التطبيق', 'App-Daten löschen'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.wrong,
                          ),
                        ),
                        Icon(Icons.warning_amber_rounded,
                            color: AppColors.wrong),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tr('* لا يمكن التراجع عن هذا الإجراء.',
                '* Dies kann nicht rückgängig gemacht werden.'),
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 48),

          // About App Section
          Text(
            tr('عن التطبيق', 'ÜBER DIE APP').toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    tr('الإصدار', 'Version'),
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  trailing: Text(
                    _appVersion,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(color: AppColors.border, height: 1),
                ListTile(
                  title: Text(
                    tr('البحث عن التحديثات', 'Nach Updates suchen'),
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  trailing:
                      Icon(Icons.system_update_alt, color: AppColors.accent),
                  onTap: () => _checkForUpdates(context, tr),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
          Center(
            child: Text(
              '© 2026 C1 Hsch',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required Widget child,
    String? title,
    String? subtitle,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20),
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
            const SizedBox(height: 20),
          ],
          child,
        ],
      ),
    );
  }

  void _showClearDataConfirm(
      BuildContext context, String Function(String, String) tr) {
    showDialog(
      context: context,
      builder: (ctx) => ClearDataDialog(tr: tr),
    );
  }

  Future<void> _checkForUpdates(
      BuildContext context, String Function(String, String) tr) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final result = await UpdateService.checkForUpdate(context, manual: true);

    if (context.mounted) {
      Navigator.of(context).pop(); // hide loading
      if (result == 'up_to_date') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                tr('أنت تستخدم أحدث إصدار', 'Du nutzt die neueste Version')),
            backgroundColor: AppColors.correct,
          ),
        );
      } else if (result != null && result.startsWith('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(tr('حدث خطأ أثناء الفحص', 'Fehler bei der Überprüfung')),
            backgroundColor: AppColors.wrong,
          ),
        );
      }
    }
  }
}
