import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/update_background.dart';
import 'widgets/update_header.dart';
import 'widgets/update_progress_widget.dart';
import 'widgets/update_notes_widget.dart';
import 'widgets/update_actions_widget.dart';

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
        _currentVersionText =
            '${packageInfo.version} (Build ${packageInfo.buildNumber})';
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
      OtaUpdate()
          .execute(widget.apkUrl, destinationFilename: 'C1_Hsch.apk')
          .listen(
        (OtaEvent event) {
          if (event.status == OtaStatus.DOWNLOADING) {
            final value = double.tryParse(event.value ?? '') ?? 0.0;
            setState(() {
              _progress = value / 100.0;
              _statusText = '${value.toInt()}%';
            });
          } else if (event.status == OtaStatus.INSTALLING) {
            setState(() {
              _isDownloading = false;
              _statusText = 'Installing...';
            });
          } else if (event.status == OtaStatus.INTERNAL_ERROR ||
              event.status == OtaStatus.DOWNLOAD_ERROR ||
              event.status == OtaStatus.PERMISSION_NOT_GRANTED_ERROR) {
            setState(() => _isDownloading = false);
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
          setState(() => _isDownloading = false);
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
    } catch (_) {
      setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAr = l10n.localeName == 'ar';

    return Scaffold(
      body: Stack(
        children: [
          // Atmospheric background blobs + blur
          const UpdateBackground(),

          // Scrollable content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo + app name
                      const UpdateHeader(),
                      const SizedBox(height: 40),

                      // Main card
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF334155)
                                    .withValues(alpha: 0.5)
                                : Colors.grey.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card title
                            Text(
                              l10n.updateTitle,
                              style: AppTextStyles.headingMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Update size hint
                            Row(
                              children: [
                                Icon(
                                  Icons.download_for_offline,
                                  size: 18,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isAr
                                      ? 'حجم التحديث: 50.4 ميجابايت'
                                      : 'Update-Größe: 50.4 MB',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Download progress bar (visible only while downloading)
                            if (_isDownloading)
                              UpdateProgressWidget(
                                progress: _progress,
                                statusText: _statusText,
                              ),

                            // Release notes
                            UpdateNotesWidget(notes: widget.notes),
                            const SizedBox(height: 24),

                            // Action buttons
                            UpdateActionsWidget(
                              isDownloading: _isDownloading,
                              isForceUpdate: _isForceUpdate,
                              onUpdate: _startUpdate,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Current version footer
                      Text(
                        isAr
                            ? 'إصدار التطبيق الحالي: $_currentVersionText'
                            : 'Aktuelle App-Version: $_currentVersionText',
                        style: AppTextStyles.labelSmall.copyWith(
                          color:
                              AppColors.textSecondary.withValues(alpha: 0.7),
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
