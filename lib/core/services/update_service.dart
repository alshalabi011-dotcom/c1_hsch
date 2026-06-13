import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

class UpdateService {
  static bool _hasChecked = false;

  static const String _versionUrl =
      'https://qoiyvojzqhbabnncfcjo.supabase.co/storage/v1/object/public/app-updates/version.json';

  static Future<String?> checkForUpdate(BuildContext context, {bool manual = false}) async {
    if (!manual && _hasChecked) return null;
    _hasChecked = true;

    // The ota_update package is only supported on Android.
    if (!Platform.isAndroid) return 'not_android';

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final response = await http.get(Uri.parse('$_versionUrl?t=$timestamp'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        
        final latestVersion = data['version'] as String;
        final latestBuildNumber = int.tryParse(data['build_number'].toString()) ?? 0;
        final apkUrl = data['apk_url'] as String;
        final notes = data['release_notes'] as String;
        final forceUpdate = data['force_update'] as bool? ?? false;

        if (latestBuildNumber > currentBuildNumber) {
          if (context.mounted) {
            context.go(
              '/update?version=$latestVersion'
              '&notes=${Uri.encodeComponent(notes)}'
              '&apkUrl=${Uri.encodeComponent(apkUrl)}'
              '&forceUpdate=$forceUpdate',
            );
          }
          return 'update_available';
        } else {
          return 'up_to_date';
        }
      } else {
        return 'server_error: ${response.statusCode}';
      }
    } catch (e) {
      debugPrint("Update check error: $e");
      return 'error: $e';
    }
  }
}
