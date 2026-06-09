import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'core/localization/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/constants/app_colors.dart';
import 'features/onboarding/index.dart';
import 'features/home/presentation/sections_screen.dart';
import 'features/home/presentation/models_screen.dart';
import 'features/home/presentation/update_screen.dart';
import 'features/exercise/presentation/exercise_screen.dart';
import 'features/exercise/presentation/results_screen.dart';

bool _showIntro = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  _showIntro = prefs.getBool('showIntro') ?? true;

  runApp(const ProviderScope(child: C1HschApp()));
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/intro',
      builder: (_, __) => const IntroScreen(),
    ),
    GoRoute(
      path: '/sections',
      builder: (_, __) => const SectionsScreen(),
    ),
    GoRoute(
      path: '/update',
      builder: (_, state) {
        final version = state.uri.queryParameters['version'] ?? '';
        final notes = state.uri.queryParameters['notes'] ?? '';
        final apkUrl = state.uri.queryParameters['apkUrl'] ?? '';
        final forceUpdate = state.uri.queryParameters['forceUpdate'] ?? 'false';
        return UpdateScreen(
          latestVersion: version,
          notes: notes,
          apkUrl: apkUrl,
          forceUpdate: forceUpdate,
        );
      },
    ),
    GoRoute(
      path: '/section/:sectionId',
      builder: (_, state) {
        final sectionId = int.parse(state.pathParameters['sectionId']!);
        return ModelsScreen(sectionId: sectionId);
      },
    ),
    GoRoute(
      path: '/exercise/:sectionId/:modelId',
      builder: (_, state) {
        final sectionId = int.parse(state.pathParameters['sectionId']!);
        final modelId = int.parse(state.pathParameters['modelId']!);
        final slug = state.uri.queryParameters['slug'] ?? 'maus';
        return ExerciseScreen(
          sectionId: sectionId,
          modelId: modelId,
          slug: slug,
        );
      },
    ),
    GoRoute(
      path: '/results/:sectionId/:modelId',
      builder: (_, state) {
        final sectionId = int.parse(state.pathParameters['sectionId']!);
        final modelId = int.parse(state.pathParameters['modelId']!);
        final slug = state.uri.queryParameters['slug'] ?? 'maus';
        return ResultsScreen(
          sectionId: sectionId,
          modelId: modelId,
          slug: slug,
        );
      },
    ),
  ],
);

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
      routerConfig: _router,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
