import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/reading_exercise.dart';

part 'reading_exercise_state.freezed.dart';

@freezed
class ReadingExerciseState with _$ReadingExerciseState {
  const factory ReadingExerciseState({
    required AsyncValue<ReadingExercise> exercise,
    @Default({}) Map<String, String> selectedAnswers,
    @Default({}) Map<String, bool> validationResults,
  }) = _ReadingExerciseState;
}
