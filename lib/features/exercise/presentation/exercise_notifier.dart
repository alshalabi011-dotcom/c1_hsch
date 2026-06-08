import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/exercise_repository.dart';
import '../data/exercise_repository_impl.dart';
import '../domain/exercise.dart';
import 'exercise_state.dart';

final exerciseRepositoryProvider = Provider<ExerciseRepository>(
  (_) => ExerciseRepositoryImpl(),
);

/// All business logic for an exercise session.
/// Spec §6.3 — implements loadExercise, openBlank, closeBlank,
/// selectAnswer, toggleTranslation, setLang, retry.
class ExerciseNotifier extends StateNotifier<ExerciseState> {
  ExerciseNotifier(this._repository, this._sectionId, this._modelId, this._slug)
      : super(const ExerciseState(exercise: AsyncValue.loading())) {
    loadExercise();
  }

  final ExerciseRepository _repository;
  final int _sectionId;
  final int _modelId;
  final String _slug;

  Future<void> loadExercise() async {
    state = state.copyWith(exercise: const AsyncValue.loading());
    final result = await _repository.getExercise(
      sectionId: _sectionId,
      modelId: _modelId,
      slug: _slug,
    );
    state = state.copyWith(
      exercise: result.when(
        ok: (ex) => AsyncValue.data(ex),
        err: (msg) => AsyncValue.error(msg, StackTrace.empty),
      ),
    );
  }

  void openBlank(int blankId) {
    state = state.copyWith(activeBlankId: blankId);
  }

  void closeBlank() {
    state = state.copyWith(activeBlankId: null);
  }

  void selectAnswer(int blankId, String key) {
    final exercise = _exercise;
    if (exercise == null) return;

    final blank = exercise.blanks.firstWhere((b) => b.id == blankId);
    final isCorrect = blank.correctKey == key;

    final updated = Map<int, String>.from(state.selectedAnswers)..[blankId] = key;
    final answered = updated.length;
    final isFinished = answered >= exercise.totalBlanks;

    state = state.copyWith(
      selectedAnswers: updated,
      activeBlankId: null,
      showFeedback: true,
      lastAnswerCorrect: isCorrect,
      isFinished: isFinished,
    );

    Future.delayed(const Duration(milliseconds: 2200), _dismissFeedback);
  }

  void _dismissFeedback() {
    if (mounted) state = state.copyWith(showFeedback: false);
  }

  void toggleTranslation() {
    state = state.copyWith(showTranslation: !state.showTranslation);
  }

  void setLang(String lang) {
    state = state.copyWith(lang: lang);
  }

  void retry() {
    state = state.copyWith(
      selectedAnswers: {},
      activeBlankId: null,
      showTranslation: false,
      showFeedback: false,
      lastAnswerCorrect: true,
      isFinished: false,
    );
  }

  Exercise? get _exercise => switch (state.exercise) {
        AsyncData(:final value) => value,
        _ => null,
      };
}

final exerciseProvider = StateNotifierProvider.family<ExerciseNotifier,
    ExerciseState, (int, int, String)>(
  (ref, args) => ExerciseNotifier(
    ref.read(exerciseRepositoryProvider),
    args.$1,
    args.$2,
    args.$3,
  ),
);
