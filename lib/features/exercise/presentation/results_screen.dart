import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/exercise.dart';
import '../domain/blank_answer.dart';
import '../domain/option.dart';
import 'exercise_notifier.dart';
import 'exercise_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';

/// Results screen shown after the last blank is answered.
/// Spec §4.4 — score card, breakdown list, retry button.
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

class _ResultsBody extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final correct = _correctCount;
    final total = exercise.totalBlanks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('النتيجة'),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ScoreCard(correct: correct, total: total),
                  const SizedBox(height: 24),
                  _BreakdownList(
                    blanks: exercise.blanks,
                    selectedAnswers: state.selectedAnswers,
                  ),
                ],
              ),
            ),
          ),
          _RetryButton(
            onRetry: () {
              notifier.retry();
              context.pushReplacement('/exercise/$sectionId/$modelId?slug=$slug');
            },
          ),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.correct, required this.total});
  final int correct;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '$correct / $total',
            style: AppTextStyles.headingLarge.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: correct == total
                  ? AppColors.correct
                  : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'إجابات صحيحة',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownList extends StatelessWidget {
  const _BreakdownList({
    required this.blanks,
    required this.selectedAnswers,
  });

  final List<BlankAnswer> blanks;
  final Map<int, String> selectedAnswers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: blanks.map((blank) {
        final chosen = selectedAnswers[blank.id] ?? '—';
        final isCorrect = chosen == blank.correctKey;
        return _BreakdownRow(blank: blank, chosenKey: chosen, isCorrect: isCorrect);
      }).toList(),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.blank,
    required this.chosenKey,
    required this.isCorrect,
  });

  final BlankAnswer blank;
  final String chosenKey;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    // Find the correct option's German sentence for display
    final Option? correctOption = blank.options.isNotEmpty
        ? blank.options.firstWhere(
            (o) => o.key == blank.correctKey,
            orElse: () => blank.options.first,
          )
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '${blank.id}',
              style: AppTextStyles.labelMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 8),
          _KeyBadge(keyLabel: chosenKey, isCorrect: isCorrect),
          if (!isCorrect) ...[
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward,
                size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            _KeyBadge(keyLabel: blank.correctKey, isCorrect: true),
          ],
          const SizedBox(width: 8),
          if (correctOption != null)
            Expanded(
              child: Text(
                correctOption.de,
                style: AppTextStyles.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

class _KeyBadge extends StatelessWidget {
  const _KeyBadge({required this.keyLabel, required this.isCorrect});
  final String keyLabel;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isCorrect ? AppColors.correctLight : AppColors.wrongLight,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        keyLabel,
        style: AppTextStyles.labelMedium.copyWith(
          color: isCorrect ? AppColors.correctDark : AppColors.wrongDark,
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: ElevatedButton(
        onPressed: onRetry,
        child: const Text(
          'إعادة المحاولة',
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
