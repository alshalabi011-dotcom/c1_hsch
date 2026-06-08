import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/exercise.dart';
import 'exercise_notifier.dart';
import 'exercise_state.dart';
import 'widgets/reading_area.dart';
import 'widgets/translation_button.dart';
import 'widgets/answer_bottom_sheet.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/feedback_bar.dart';
import '../../../../core/widgets/progress_bar.dart';

/// Main exercise screen.
/// Spec §4.3 — top bar, progress bar, reading area, translation button,
/// bottom sheet on blank tap, animated feedback bar, finish navigation.
class ExerciseScreen extends ConsumerWidget {
  const ExerciseScreen({
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

    // Navigate to results when exercise finishes
    ref.listen(exerciseProvider((sectionId, modelId, slug)), (prev, next) {
      if (next.isFinished && !(prev?.isFinished ?? false)) {
        Future.delayed(const Duration(milliseconds: 2400), () {
          if (context.mounted) {
            context.pushReplacement(
                '/results/$sectionId/$modelId?slug=$slug');
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.exercise.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(err.toString(),
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.wrong)),
        ),
        data: (exercise) => _ExerciseBody(
          exercise: exercise,
          state: state,
          notifier: notifier,
          sectionId: sectionId,
          modelId: modelId,
          slug: slug,
        ),
      ),
    );
  }
}

class _ExerciseBody extends StatelessWidget {
  const _ExerciseBody({
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

  @override
  Widget build(BuildContext context) {
    final answered = state.selectedAnswers.length;
    final total = exercise.totalBlanks;
    final correctKeys = {for (final b in exercise.blanks) b.id: b.correctKey};

    return Stack(
      children: [
        Column(
          children: [
            // 1. Top bar
            _TopBar(
              modelName: exercise.modelName,
              answered: answered,
              total: total,
              lang: state.lang,
              onBack: () => context.pop(),
              onLangChanged: notifier.setLang,
            ),
            // 2. Progress bar (full width, no padding)
            ExerciseProgressBar(answered: answered, total: total),
            // 3. Scrollable reading area + translation button
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenH, 16, AppSpacing.screenH, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // German paragraphs (always shown)
                    ReadingAreaWithCorrectness(
                      paragraphs: exercise.deParagraphs,
                      textDirection: TextDirection.ltr,
                      selectedAnswers: state.selectedAnswers,
                      activeBlankId: state.activeBlankId,
                      correctKeys: correctKeys,
                      optionsPool: exercise.optionsPool,
                      onBlankTap: (id) => _openSheet(context, id),
                    ),
                    // Arabic translation paragraph (shown when toggled)
                    if (state.showTranslation) ...[
                      const Divider(height: 24),
                      ReadingAreaWithCorrectness(
                        paragraphs: exercise.arParagraphs,
                        textDirection: TextDirection.rtl,
                        selectedAnswers: state.selectedAnswers,
                        activeBlankId: state.activeBlankId,
                        correctKeys: correctKeys,
                        optionsPool: exercise.optionsPool,
                        // No onBlankTap — static markers in Arabic paragraph
                      ),
                    ],
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            // 4. Translation toggle button
            TranslationButton(
              showTranslation: state.showTranslation,
              onTap: notifier.toggleTranslation,
            ),
            const SizedBox(height: 8),
          ],
        ),
        // 5. Animated feedback bar
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedSlide(
            offset: state.showFeedback ? Offset.zero : const Offset(0, 1),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: state.showFeedback
                ? FeedbackBar(
                    isCorrect: state.lastAnswerCorrect,
                    message: _feedbackMessage(state, exercise),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  void _openSheet(BuildContext context, int blankId) {
    notifier.openBlank(blankId);
    final usedKeys = Set<String>.from(state.selectedAnswers.values);
    // Remove current blank's answer from used so it can be re-selected
    final current = state.selectedAnswers[blankId];
    if (current != null) usedKeys.remove(current);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => AnswerBottomSheet(
        blankId: blankId,
        options: exercise.optionsPool,
        usedKeys: usedKeys,
        showTranslation: state.showTranslation,
        onSelect: (key) => notifier.selectAnswer(blankId, key),
      ),
    ).whenComplete(notifier.closeBlank);
  }

  String _feedbackMessage(ExerciseState state, Exercise exercise) {
    if (state.lastAnswerCorrect) return '✓ ممتاز! إجابة صحيحة';
    // Find the correct key for the last answered blank
    final lastBlankId = state.selectedAnswers.keys.lastOrNull;
    if (lastBlankId == null) return '✗';
    final blank =
        exercise.blanks.firstWhere((b) => b.id == lastBlankId,
            orElse: () => exercise.blanks.first);
    return '✗ الجواب الصحيح: ${blank.correctKey}';
  }
}

/// Top bar: back arrow + model name | blank counter + DE/AR toggle.
/// Spec §4.3 top bar.
class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.modelName,
    required this.answered,
    required this.total,
    required this.lang,
    required this.onBack,
    required this.onLangChanged,
  });

  final String modelName;
  final int answered;
  final int total;
  final String lang;
  final VoidCallback onBack;
  final void Function(String) onLangChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: onBack,
              iconSize: 22,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                modelName,
                style: AppTextStyles.headingMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '$answered / $total',
              style: AppTextStyles.labelMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(width: 12),
            _LangToggle(lang: lang, onChanged: onLangChanged),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

/// DE/AR two-segment toggle.
/// Spec §2.5 DE/AR toggle.
class _LangToggle extends StatelessWidget {
  const _LangToggle({required this.lang, required this.onChanged});

  final String lang;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Segment(label: 'DE', isActive: lang == 'de', onTap: () => onChanged('de')),
          _Segment(label: 'AR', isActive: lang == 'ar', onTap: () => onChanged('ar')),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 32, minHeight: 28),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? AppColors.accentLight : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isActive ? AppColors.accentDark : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

extension _IterableExtension<T> on Iterable<T> {
  T? get lastOrNull => isEmpty ? null : last;
}
