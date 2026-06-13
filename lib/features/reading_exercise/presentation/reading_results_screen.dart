import 'package:c1_hsch/features/exercise/presentation/widgets/results_action_buttons.dart';
import 'package:c1_hsch/features/exercise/presentation/widgets/score_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/reading_exercise.dart';
import 'reading_exercise_notifier.dart';
import 'reading_exercise_state.dart';
import 'widgets/reading_breakdown_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

class ReadingResultsScreen extends ConsumerWidget {
  const ReadingResultsScreen({
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
    final params = ReadingExerciseParams(
        sectionId: sectionId, modelId: modelId, slug: slug);
    final state = ref.watch(readingExerciseProvider(params));

    return state.exercise.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        body: Center(child: Text(err.toString())),
      ),
      data: (exercise) => _ReadingResultsBody(
        exercise: exercise,
        state: state,
        sectionId: sectionId,
        modelId: modelId,
        slug: slug,
        ref: ref,
      ),
    );
  }
}

class _ReadingResultsBody extends StatelessWidget {
  const _ReadingResultsBody({
    required this.exercise,
    required this.state,
    required this.sectionId,
    required this.modelId,
    required this.slug,
    required this.ref,
  });

  final ReadingExercise exercise;
  final ReadingExerciseState state;
  final int sectionId;
  final int modelId;
  final String slug;
  final WidgetRef ref;

  int get _correctCount {
    int count = 0;
    for (final question in exercise.questions) {
      if (state.selectedAnswers[question.number] == question.correctAnswer) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final correct = _correctCount;
    final total = exercise.questions.length;
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
                  ReadingBreakdownCard(
                    questions: exercise.questions,
                    selectedAnswers: state.selectedAnswers,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ResultsActionButtons(
                      sectionId: sectionId,
                      modelId: modelId,
                      isReading: true,
                      onRetry: () {
                        final params = ReadingExerciseParams(
                            sectionId: sectionId, modelId: modelId, slug: slug);
                        ref.invalidate(readingExerciseProvider(params));
                        context.pushReplacement(
                            '/reading_exercise/$sectionId/$modelId?slug=$slug');
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
