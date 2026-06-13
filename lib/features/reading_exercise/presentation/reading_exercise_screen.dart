import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'widgets/reading_app_bar.dart';
import 'widgets/reading_header.dart';
import 'widgets/reading_paragraph.dart';
import 'widgets/reading_question_card.dart';
import 'reading_exercise_notifier.dart';

class ReadingExerciseScreen extends ConsumerStatefulWidget {
  final int sectionId;
  final int modelId;
  final String slug;

  const ReadingExerciseScreen({
    super.key,
    required this.sectionId,
    required this.modelId,
    required this.slug,
  });

  @override
  ConsumerState<ReadingExerciseScreen> createState() => _ReadingExerciseScreenState();
}

class _ReadingExerciseScreenState extends ConsumerState<ReadingExerciseScreen> {
  late final ReadingExerciseParams _params;

  @override
  void initState() {
    super.initState();
    _params = ReadingExerciseParams(
      sectionId: widget.sectionId,
      modelId: widget.modelId,
      slug: widget.slug,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(readingExerciseProvider(_params), (previous, next) {
      final exercise = next.exercise.valueOrNull;
      if (exercise != null) {
        if (next.selectedAnswers.length == exercise.questions.length &&
            (previous?.selectedAnswers.length ?? 0) < exercise.questions.length) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (context.mounted) {
              context.pushReplacement(
                  '/reading_results/${widget.sectionId}/${widget.modelId}?slug=${widget.slug}');
            }
          });
        }
      }
    });

    final state = ref.watch(readingExerciseProvider(_params));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ReadingAppBar(),
      body: state.exercise.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('Fehler beim Laden: $error', style: const TextStyle(color: Colors.red)),
        ),
        data: (exercise) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReadingHeader(
                    category: exercise.sectionName.toUpperCase(),
                    title: exercise.modelName,
                  ),
                  ...exercise.paragraphs.map((p) => ReadingParagraph(
                        letter: p.letter,
                        content: p.de,
                        translation: p.ar,
                      )),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.list_alt, color: AppColors.textPrimary),
                      const SizedBox(width: 8),
                      Text(
                        'Fragen zum Text',
                        style: AppTextStyles.headingLarge.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...exercise.questions.map((q) {
                    final selectedLetter = state.selectedAnswers[q.number];
                    final isCorrect = state.validationResults[q.number];
                    return ReadingQuestionCard(
                      number: q.number,
                      questionDe: q.de,
                      questionAr: q.ar,
                      selectedLetter: selectedLetter,
                      isCorrect: isCorrect,
                      onAnswerSelected: (letter) {
                        ref.read(readingExerciseProvider(_params).notifier).selectAnswer(q.number, letter);
                      },
                    );
                  }),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
