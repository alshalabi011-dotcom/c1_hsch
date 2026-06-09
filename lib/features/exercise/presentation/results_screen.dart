import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/exercise.dart';
// import '../domain/blank_answer.dart';
import 'exercise_notifier.dart';
import 'exercise_state.dart';
import 'widgets/score_circle.dart';
import 'widgets/breakdown_card.dart';
import 'widgets/results_retry_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../../l10n/app_localizations.dart';

/// Redesigned Results screen shown after the last blank is answered.
/// Spec §4.4 — score circular reveal, breakdown card, retry action.
class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({
    super.key,
    required this.sectionId,
    required this.modelId,
    required this.slug,
  });

  final int sectionId;
  final int modelId;
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exerciseProvider((sectionId, modelId, slug)));
    final notifier =
        ref.read(exerciseProvider((sectionId, modelId, slug)).notifier);

    return state.exercise.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        body: Center(child: Text(err.toString())),
      ),
      data: (exercise) => _ResultsBody(
        exercise: exercise,
        state: state,
        notifier: notifier,
        sectionId: sectionId,
        modelId: modelId,
        slug: slug,
      ),
    );
  }
}

class _ResultsBody extends ConsumerWidget {
  const _ResultsBody({
    required this.exercise,
    required this.state,
    required this.notifier,
    required this.sectionId,
    required this.modelId,
    required this.slug,
  });

  final Exercise exercise;
  final ExerciseState state;
  final ExerciseNotifier notifier;
  final int sectionId;
  final int modelId;
  final String slug;

  int get _correctCount {
    int count = 0;
    for (final blank in exercise.blanks) {
      if (state.selectedAnswers[blank.id] == blank.correctKey) count++;
    }
    return count;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final correct = _correctCount;
    final total = exercise.totalBlanks;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.accent),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/sections');
            }
          },
        ),
        title: Text(
          l10n.resultsScreenTitle,
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {
                ref.read(localeProvider.notifier).toggleLocale();
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: AppColors.surface,
              ),
              child: Text(
                'DE | AR',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.border,
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScoreCircle(correct: correct, total: total),
                  const SizedBox(height: 24),
                  BreakdownCard(
                    blanks: exercise.blanks,
                    selectedAnswers: state.selectedAnswers,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ResultsRetryButton(
                      onPressed: () {
                        notifier.retry();
                        context.pushReplacement(
                          '/exercise/$sectionId/$modelId?slug=$slug',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
