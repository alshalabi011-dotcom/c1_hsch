import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/exercise.dart';
import '../exercise_notifier.dart';
import '../exercise_state.dart';
import 'reading_area.dart';
import 'translation_button.dart';
import 'answer_bottom_sheet.dart';
import 'exercise_top_bar.dart'; // استيراد التوب بار الجديد
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/feedback_bar.dart';
import '../../../../core/widgets/progress_bar.dart';
import '../../../../l10n/app_localizations.dart';

class ExerciseBody extends StatelessWidget {
  const ExerciseBody({
    super.key,
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
            ExerciseTopBar(
              modelName: exercise.modelName,
              answered: answered,
              total: total,
              lang: state.lang,
              onBack: () => context.pop(),
              onLangChanged: notifier.setLang,
            ),
            ExerciseProgressBar(answered: answered, total: total),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenH, 16, AppSpacing.screenH, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ReadingAreaWithCorrectness(
                      paragraphs: exercise.deParagraphs,
                      textDirection: TextDirection.ltr,
                      selectedAnswers: state.selectedAnswers,
                      activeBlankId: state.activeBlankId,
                      correctKeys: correctKeys,
                      optionsPool: exercise.optionsPool,
                      onBlankTap: (id) => _openSheet(context, id),
                    ),
                    if (state.showTranslation) ...[
                      const Divider(height: 24),
                      ReadingAreaWithCorrectness(
                        paragraphs: exercise.arParagraphs,
                        textDirection: TextDirection.rtl,
                        selectedAnswers: state.selectedAnswers,
                        activeBlankId: state.activeBlankId,
                        correctKeys: correctKeys,
                        optionsPool: exercise.optionsPool,
                      ),
                    ],
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            TranslationButton(
              showTranslation: state.showTranslation,
              onTap: notifier.toggleTranslation,
            ),
            const SizedBox(height: 8),
          ],
        ),
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
                    message: _feedbackMessage(context, state, exercise),
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

  String _feedbackMessage(BuildContext context, ExerciseState state, Exercise exercise) {
    final l10n = AppLocalizations.of(context)!;
    if (state.lastAnswerCorrect) return l10n.feedbackCorrect;
    final lastBlankId = state.selectedAnswers.keys.last;
    final blank = exercise.blanks.firstWhere((b) => b.id == lastBlankId,
        orElse: () => exercise.blanks.first);
    return l10n.feedbackWrong(blank.correctKey);
  }
}
