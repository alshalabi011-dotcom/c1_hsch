import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/reading_exercise_repository.dart';
import 'reading_exercise_state.dart';
import '../../../core/services/local_storage_service.dart';

final readingExerciseProvider = StateNotifierProvider.autoDispose.family<ReadingExerciseNotifier, ReadingExerciseState, ReadingExerciseParams>((ref, params) {
  final repository = ref.watch(readingExerciseRepositoryProvider);
  final localStorage = ref.watch(localStorageServiceProvider);
  return ReadingExerciseNotifier(repository, localStorage, params);
});

class ReadingExerciseParams {
  final int sectionId;
  final int modelId;
  final String slug;

  ReadingExerciseParams({
    required this.sectionId,
    required this.modelId,
    required this.slug,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingExerciseParams &&
          runtimeType == other.runtimeType &&
          sectionId == other.sectionId &&
          modelId == other.modelId &&
          slug == other.slug;

  @override
  int get hashCode => sectionId.hashCode ^ modelId.hashCode ^ slug.hashCode;
}

class ReadingExerciseNotifier extends StateNotifier<ReadingExerciseState> {
  final ReadingExerciseRepository _repository;
  final LocalStorageService _localStorage;
  final ReadingExerciseParams _params;

  ReadingExerciseNotifier(this._repository, this._localStorage, this._params)
      : super(const ReadingExerciseState(exercise: AsyncValue.loading())) {
    _load();
  }

  Future<void> _load() async {
    try {
      final exercise = await _repository.loadExercise(_params.sectionId, _params.modelId, _params.slug);
      
      final savedAnswers = _localStorage.loadReadingAnswers(_params.sectionId, _params.modelId) ?? const {};
      final savedValidations = _localStorage.loadReadingValidations(_params.sectionId, _params.modelId) ?? const {};
      
      state = state.copyWith(
        exercise: AsyncValue.data(exercise),
        selectedAnswers: savedAnswers,
        validationResults: savedValidations,
      );
    } catch (e, st) {
      state = state.copyWith(exercise: AsyncValue.error(e, st));
    }
  }

  void selectAnswer(String questionNumber, String selectedLetter) {
    final exerciseOpt = state.exercise.valueOrNull;
    if (exerciseOpt == null) return;

    final question = exerciseOpt.questions.firstWhere((q) => q.number == questionNumber);
    final isCorrect = question.correctAnswer == selectedLetter;

    final newSelectedAnswers = Map<String, String>.from(state.selectedAnswers);
    newSelectedAnswers[questionNumber] = selectedLetter;

    final newValidationResults = Map<String, bool>.from(state.validationResults);
    newValidationResults[questionNumber] = isCorrect;

    _localStorage.saveReadingAnswers(_params.sectionId, _params.modelId, newSelectedAnswers);
    _localStorage.saveReadingValidations(_params.sectionId, _params.modelId, newValidationResults);

    state = state.copyWith(
      selectedAnswers: newSelectedAnswers,
      validationResults: newValidationResults,
    );
  }

  void retry() {
    _localStorage.clearReadingData(_params.sectionId, _params.modelId);
    state = state.copyWith(
      selectedAnswers: const {},
      validationResults: const {},
    );
  }
}
