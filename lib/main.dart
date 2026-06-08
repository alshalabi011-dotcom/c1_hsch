import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/sections_screen.dart';
import 'features/home/presentation/models_screen.dart';
import 'features/exercise/presentation/exercise_screen.dart';
import 'features/exercise/presentation/results_screen.dart';

void main() {
  runApp(const ProviderScope(child: C1HschApp()));
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SectionsScreen(),
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

class C1HschApp extends StatelessWidget {
  const C1HschApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'C1 Hochschule',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: _router,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('de'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
