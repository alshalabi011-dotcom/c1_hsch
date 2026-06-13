import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'core/localization/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/constants/app_colors.dart';
import 'core/router/app_router.dart';

import 'core/services/local_storage_service.dart';

bool _showIntro = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorageService = LocalStorageService();
  await localStorageService.init();

  final prefs = await SharedPreferences.getInstance();
  _showIntro = prefs.getBool('showIntro') ?? true;

  runApp(ProviderScope(
    overrides: [
      localStorageServiceProvider.overrideWithValue(localStorageService),
    ],
    child: const C1HschApp(),
  ));
}



/// شاشة الـ Splash مخصصة لفحص التوجيه المناسب للمستخدم وتجنب حدوث وميض بالشاشة
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // نقوم بالتوجيه مباشرة بعد اكتمال بناء الإطار الرسومي الأول للتطبيق
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_showIntro) {
        context.go('/intro');
      } else {
        context.go('/sections');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
        ),
      ),
    );
  }
}

class C1HschApp extends ConsumerWidget {
  const C1HschApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);
    AppColors.isDark = themeMode == ThemeMode.dark;

    return MaterialApp.router(
      title: 'C1 Hsch',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
