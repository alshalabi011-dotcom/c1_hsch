import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ota_update/ota_update.dart';
import '../../l10n/app_localizations.dart';

class UpdateService {
  static const String _versionUrl =
      'https://qoiyvojzqhbabnncfcjo.supabase.co/storage/v1/object/public/app-updates/version.json';

  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

      final response = await http.get(Uri.parse(_versionUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        
        final latestVersion = data['version'] as String;
        final latestBuildNumber = int.tryParse(data['build_number'].toString()) ?? 0;
        final apkUrl = data['apk_url'] as String;
        final notes = data['release_notes'] as String;
        final forceUpdate = data['force_update'] as bool? ?? false;

        if (latestBuildNumber > currentBuildNumber) {
          if (context.mounted) {
            _showUpdateDialog(context, latestVersion, notes, apkUrl, forceUpdate);
          }
        }
      }
    } catch (e) {
      debugPrint("Update check error: $e");
    }
  }

  static void _showUpdateDialog(
    BuildContext context,
    String latestVersion,
    String notes,
    String apkUrl,
    bool forceUpdate,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: !forceUpdate,
      builder: (BuildContext context) {
        return PopScope(
          canPop: !forceUpdate,
          child: AlertDialog(
            title: Text(l10n.updateTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.newVersionLabel(latestVersion)),
                const SizedBox(height: 12),
                Text(
                  l10n.whatsNew,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(notes),
              ],
            ),
            actions: [
              if (!forceUpdate)
                TextButton(
                  child: Text(l10n.laterBtn),
                  onPressed: () => Navigator.pop(context),
                ),
              ElevatedButton(
                child: Text(l10n.updateNowBtn),
                onPressed: () {
                  Navigator.pop(context);
                  _startDownloadAndInstall(context, apkUrl);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void _startDownloadAndInstall(BuildContext context, String apkUrl) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text(l10n.downloadingUpdate)),
            ],
          ),
        );
      },
    );

    try {
      OtaUpdate().execute(
        apkUrl,
        destinationFilename: 'C1_Hsch.apk',
      ).listen(
        (OtaEvent event) {
          if (event.status == OtaStatus.INSTALLING) {
            if (context.mounted) {
              Navigator.pop(context);
            }
          } else if (event.status == OtaStatus.INTERNAL_ERROR ||
                     event.status == OtaStatus.DOWNLOAD_ERROR ||
                     event.status == OtaStatus.PERMISSION_NOT_GRANTED_ERROR) {
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to install update.')),
              );
            }
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      debugPrint('Self-update execution error: $e');
    }
  }
}
