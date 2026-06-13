import 'package:go_router/go_router.dart';
import '../../main.dart';
import '../../features/onboarding/index.dart' hide SplashScreen;
import '../../features/home/presentation/sections_screen.dart';
import '../../features/home/presentation/models_screen.dart';
import '../../features/home/presentation/update_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/exercise/presentation/exercise_screen.dart';
import '../../features/exercise/presentation/results_screen.dart';
import '../../features/reading_exercise/presentation/reading_exercise_screen.dart';
import '../../features/reading_exercise/presentation/reading_results_screen.dart';

final appRouter = GoRouter(
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
      path: '/settings',
      builder: (_, __) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/sections',
      builder: (_, __) => const SectionsScreen(),
    ),
    GoRoute(
      path: '/reading_exercise/:sectionId/:modelId',
      builder: (_, state) {
        final sectionId = int.parse(state.pathParameters['sectionId']!);
        final modelId = int.parse(state.pathParameters['modelId']!);
        final slug = state.uri.queryParameters['slug'] ?? '';
        return ReadingExerciseScreen(
          sectionId: sectionId,
          modelId: modelId,
          slug: slug,
        );
      },
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
    GoRoute(
      path: '/reading_results/:sectionId/:modelId',
      builder: (_, state) {
        final sectionId = int.parse(state.pathParameters['sectionId']!);
        final modelId = int.parse(state.pathParameters['modelId']!);
        final slug = state.uri.queryParameters['slug'] ?? '';
        return ReadingResultsScreen(
          sectionId: sectionId,
          modelId: modelId,
          slug: slug,
        );
      },
    ),
  ],
);
