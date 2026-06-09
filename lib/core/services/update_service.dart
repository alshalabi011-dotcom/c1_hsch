import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

class UpdateService {
  static bool _hasChecked = false;

  static const String _versionUrl =
      'https://qoiyvojzqhbabnncfcjo.supabase.co/storage/v1/object/public/app-updates/version.json';

  static Future<void> checkForUpdate(BuildContext context) async {
    if (_hasChecked) return;
    _hasChecked = true;

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
            context.go(
              '/update?version=$latestVersion'
              '&notes=${Uri.encodeComponent(notes)}'
              '&apkUrl=${Uri.encodeComponent(apkUrl)}'
              '&forceUpdate=$forceUpdate',
            );
          }
        }
      }
    } catch (e) {
      debugPrint("Update check error: $e");
    }
  }
}
