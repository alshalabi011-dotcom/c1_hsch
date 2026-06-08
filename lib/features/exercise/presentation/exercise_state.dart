import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/exercise.dart';

part 'exercise_state.freezed.dart';

/// Full state for an exercise session.
/// Spec §6.2 — all 8 fields as defined.
@freezed
class ExerciseState with _$ExerciseState {
  const factory ExerciseState({
    required AsyncValue<Exercise> exercise,
    @Default({}) Map<int, String> selectedAnswers, // blankId → chosen key
    int? activeBlankId,
    @Default(false) bool showTranslation,
    @Default('de') String lang, // 'de' | 'ar'
    @Default(false) bool showFeedback,
    @Default(true) bool lastAnswerCorrect,
    @Default(false) bool isFinished,
  }) = _ExerciseState;
}
