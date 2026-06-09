import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';

class UpdateScreen extends ConsumerStatefulWidget {
  const UpdateScreen({
    super.key,
    required this.latestVersion,
    required this.notes,
    required this.apkUrl,
    required this.forceUpdate,
  });

  final String latestVersion;
  final String notes;
  final String apkUrl;
  final String forceUpdate;

  @override
  ConsumerState<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends ConsumerState<UpdateScreen> {
  bool _isDownloading = false;
  double _progress = 0.0;
  String _statusText = '';
  String _currentVersionText = '';
  bool _isForceUpdate = false;

  @override
  void initState() {
    super.initState();
    _isForceUpdate = widget.forceUpdate == 'true';
    _loadCurrentVersion();
  }

  Future<void> _loadCurrentVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _currentVersionText = '${packageInfo.version} (Build ${packageInfo.buildNumber})';
      });
    } catch (_) {}
  }

  void _startUpdate() {
    setState(() {
      _isDownloading = true;
      _progress = 0.0;
      _statusText = '';
    });

    try {
      OtaUpdate().execute(
        widget.apkUrl,
        destinationFilename: 'C1_Hsch.apk',
      ).listen(
        (OtaEvent event) {
          if (event.status == OtaStatus.DOWNLOADING) {
            final doubleVal = double.tryParse(event.value ?? '') ?? 0.0;
            setState(() {
              _progress = doubleVal / 100.0;
              _statusText = '${doubleVal.toInt()}%';
            });
          } else if (event.status == OtaStatus.INSTALLING) {
            setState(() {
              _isDownloading = false;
              _statusText = 'Installing...';
            });
          } else if (event.status == OtaStatus.INTERNAL_ERROR ||
                     event.status == OtaStatus.DOWNLOAD_ERROR ||
                     event.status == OtaStatus.PERMISSION_NOT_GRANTED_ERROR) {
            setState(() {
              _isDownloading = false;
            });
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    event.status == OtaStatus.PERMISSION_NOT_GRANTED_ERROR
                        ? 'Permission denied to install APK.'
                        : 'Failed to download update.',
                  ),
                  backgroundColor: AppColors.wrong,
                ),
              );
            }
          }
        },
        onError: (err) {
          setState(() {
            _isDownloading = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('An error occurred during update.'),
                backgroundColor: AppColors.wrong,
              ),
            );
          }
        },
      );
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Split release notes by newlines to render as bullet points
    final bulletPoints = widget.notes
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .map((e) => e.startsWith('•') || e.startsWith('-') ? e.substring(1).trim() : e)
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          // Background Atmospheric blur circles
          Positioned(
            top: -100,
            right: -100,
            width: 300,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: isDark ? 0.15 : 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            width: 250,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber.withValues(alpha: isDark ? 0.08 : 0.04),
              ),
            ),
          ),
          // Blur filter
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Main Canvas
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App Logo & Brand Header
                      Image.asset(
                        'assets/icon/app_icon.png',
                        width: 88,
                        height: 88,
                        errorBuilder: (context, _, __) => Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.school, size: 54, color: AppColors.accent),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'C1 Hochschule',
                        style: AppTextStyles.headingLarge.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.academicCourse.toUpperCase(),
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 3.0,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Card
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark 
                                ? const Color(0xFF334155).withValues(alpha: 0.5)
                                : Colors.grey.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              l10n.updateTitle,
                              style: AppTextStyles.headingMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Subtitle with download size
                            Row(
                              children: [
                                Icon(
                                  Icons.download_for_offline,
                                  size: 18,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  // Localized size fallback
                                  l10n.localeName == 'ar' 
                                      ? 'حجم التحديث: 50.4 ميجابايت'
                                      : 'Update-Größe: 50.4 MB',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Progress / Download UI
                            if (_isDownloading) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.localeName == 'ar'
                                        ? 'جاري التحميل... $_statusText'
                                        : 'Wird heruntergeladen... $_statusText',
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    l10n.localeName == 'ar'
                                        ? 'يرجى الانتظار'
                                        : 'Bitte warten',
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: _progress,
                                  minHeight: 8,
                                  backgroundColor: isDark 
                                      ? const Color(0xFF2F3542) 
                                      : Colors.grey.withValues(alpha: 0.15),
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],

                            // What's New Box
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: isDark 
                                    ? const Color(0xFF161C27)
                                    : Colors.grey.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDark 
                                      ? const Color(0xFF334155).withValues(alpha: 0.3)
                                      : Colors.grey.withValues(alpha: 0.15),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.auto_awesome,
                                        size: 18,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n.whatsNew,
                                        style: AppTextStyles.labelMedium.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  if (bulletPoints.isEmpty)
                                    Text(
                                      widget.notes,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    )
                                  else
                                    Column(
                                      children: bulletPoints.map((point) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                size: 16,
                                                color: AppColors.accent,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  point,
                                                  style: AppTextStyles.bodyMedium.copyWith(
                                                    color: AppColors.textSecondary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Actions
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.accent,
                                      foregroundColor: isDark ? const Color(0xFF0D131F) : Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: _isDownloading ? null : _startUpdate,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _isDownloading
                                              ? (l10n.localeName == 'ar' ? 'جاري التنزيل...' : 'Herunterladen...')
                                              : l10n.updateNowBtn,
                                          style: AppTextStyles.labelMedium.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (!_isDownloading) ...[
                                          const SizedBox(width: 8),
                                          const Icon(Icons.play_arrow, size: 18),
                                        ]
                                      ],
                                    ),
                                  ),
                                ),
                                if (!_isForceUpdate && !_isDownloading) ...[
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.textSecondary,
                                        side: BorderSide(
                                          color: isDark 
                                              ? const Color(0xFF334155) 
                                              : Colors.grey.withValues(alpha: 0.3),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: () => context.go('/sections'),
                                      child: Text(
                                        l10n.laterBtn,
                                        style: AppTextStyles.labelMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Footer
                      Text(
                        l10n.localeName == 'ar'
                            ? 'إصدار التطبيق الحالي: $_currentVersionText'
                            : 'Aktuelle App-Version: $_currentVersionText',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary.withValues(alpha: 0.7),
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
  }
}
